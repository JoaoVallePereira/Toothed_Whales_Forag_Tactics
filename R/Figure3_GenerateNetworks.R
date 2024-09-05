## Figure3_GenerateNetwork.R: Bipartide networks for figure 3
## Authors: Alexandre Machado

# IUCN THREATS ----
IUCN_CLASSIFICATION <- rvest::read_html("https://www.iucnredlist.org/resources/threat-classification-scheme") |>
  rvest::html_node("body") |>
  rvest::html_text() |>
  str_extract_all(pattern = "\\d{1,2}.*\\r") |>
  unlist() |>
  str_subset(pattern = '^\\d{1,2}(?!\\.)(?=\\s)') |>
  str_replace(pattern = "\r", replacement = "") |>
  as_tibble_col(column_name = 'iucn_broad_classification') |>
  dplyr::mutate(iucn_type = str_extract(iucn_broad_classification, pattern = '\\d{1,2}'),
                iucn_broad_classification = str_extract(iucn_broad_classification, pattern = '(?<=\\s)\\D+'))


# Create list of column names to summarise data ----
iucn <- list (
  iucn_threats = c('broad' = 'threat_category', 
                   'specific' = 'threat_subcategory'),
  iucn_existing = c('broad' = 'existing_conservation_actions_category', 
                    'specific' = 'existing_conservation_actions_subcategory'),
  iucn_proposed = c('broad' = 'proposed_conservation_actions_category', 
                    'specific' = 'proposed_conservation_actions_subcategory')
)

# Summarize data ----
BEHAVIOR_LINKS <- lapply(iucn, function(x){
  
  dataTable |>
    dplyr::filter(putative_specialised_foraging_tactic == "yes") |>
    summarise_links(
      broad = x[['broad']],
      specific = x[['specific']],
      by = c('foraging_category', 'threat_direction')
    ) |>
    tidyr::drop_na() |>
    dplyr::rename("iucn_type" = x[['broad']]) |>
    dplyr::mutate('iucn_var' = x[['broad']], .before = 'iucn_type')
  
}) |>
  do.call(what = rbind) |>
  dplyr::group_by(foraging_category, threat_direction, iucn_var, iucn_type) |>
  dplyr::arrange(desc(total_specific)) |>
  dplyr::ungroup() |>
  dplyr::left_join(y = IUCN_CLASSIFICATION, by = 'iucn_type')

#### ===== NETWORK OF THREATS ====== #####
LINKS_THREATS <- BEHAVIOR_LINKS |>
  dplyr::filter(iucn_var == "threat_category") |>
  dplyr::mutate(
    x = dplyr::if_else(threat_direction == "Consequence OF specialization", 
                       false = -0.5, 
                       true = 0.5),
    xend = rep(0, dplyr::n()),
    )

# Rank tactics based on the number of occurrances ---- 
foraging_category <- factor(
  x = LINKS_THREATS$foraging_category, 
  levels = unique(LINKS_THREATS$foraging_category)
  )

FREQ_TACTIC <- as.data.frame.table(table(foraging_category)) |>
  dplyr::arrange(Freq) |>
  dplyr::mutate(
    y_end = 1:n(),
    y_end_scaled = scales::rescale(y_end))

# Rank threats by degree ----
iucn_broad_classification <- factor(
  x = LINKS_THREATS$iucn_broad_classification, 
  levels = unique(LINKS_THREATS$iucn_broad_classification)
    )

# Rank threats by summarising total specific links ----
FREQ_THREAT <- as.data.frame.table(table(iucn_broad_classification)) |>
  dplyr::arrange(Freq) |>
  dplyr::mutate(
    y_start = 1:n(),
    y_start_scaled = scales::rescale(y_start))

# ylimit <- max(FREQ_TACTIC$y_end, FREQ_THREAT$y_start) * 1.20
MATRIX_THREATS <- LINKS_THREATS |>
  dplyr::left_join(y = FREQ_TACTIC, by = 'foraging_category') |> 
  dplyr::left_join(y = FREQ_THREAT, by = 'iucn_broad_classification') |>
  dplyr::group_by(foraging_category, threat_direction) |>
  dplyr::summarise(total_specific = sum(total_specific)) |>
  dplyr::ungroup() |>
  tidyr::pivot_wider(
    names_from = threat_direction,
    values_from = total_specific
    ) |>
  dplyr::mutate_if(is.numeric, .funs = function(x){ifelse(is.na(x),no = x, yes = 0)}) |>
  tibble::column_to_rownames(var = 'foraging_category') |>
  as.matrix()
 
## ----

GRAPH_THREATS <- LINKS_THREATS |>
  dplyr::left_join(y = FREQ_TACTIC, by = 'foraging_category') |> 
  dplyr::left_join(y = FREQ_THREAT, by = 'iucn_broad_classification') |>
  tibble::rownames_to_column() |>
  ggplot(aes(group = rowname)) +
  geom_segment(
    aes(x = x, xend = xend, y = y_start_scaled, yend = y_end_scaled, 
        linewidth = total_specific,
        #colour = labirinto_threat_category
        )
    ) +
  #geom_point(aes(x = x, y = y_start), size = 15) + 
  geom_label(
    aes(label =  stringr::str_wrap(iucn_broad_classification, width = 20), x = x, y = y_start_scaled),
    label.padding = unit(5, units = 'pt')
    ) +
  #geom_point(aes(x = xend, y = y_end), size = 15) + 
  geom_label(
    aes(label = stringr::str_wrap(foraging_category), x = xend, y = y_end_scaled)
    ) +
  geom_text(aes(x = 0.25, y = 1.1, size = 2, label = 'Threats as a consequence of \n the foraging specialization')) +
  geom_text(aes(x = -0.25, y = 1.1, size = 2, label = 'Threats to the \n foraging specialization')) +
  #scale_colour_manual(values = c('black', 'grey50')) +
  scale_y_continuous(limits = c(0, 1.1)) +
  scale_x_continuous(limits = c(-0.6, 0.6)) +
  scale_linewidth_continuous(name = 'Number of specific related threats', 
                             breaks = seq(from = min(LINKS_THREATS$total_specific), 
                                          to = max(LINKS_THREATS$total_specific), 
                                          by = 3)) +
  theme_void() +
  guides(colour = 'none', size = 'none') +
  theme(legend.position = 'bottom')


#### ===== NETWORK OF PROTECTIONS ====== #####

LINKS_PROTECTIONS <- BEHAVIOR_LINKS |>
  dplyr::select(-threat_direction) |>
  dplyr::filter(iucn_var != "iucn_broad_threat_type") |>
  dplyr::mutate(
    x = dplyr::if_else(iucn_var == "iucn_broad_existing_protection_type", true = -0.5, false = 0.5),
    xend = rep(0, dplyr::n()),
  )

# Rank tactics based on the number of occurrances ---- 
FREQ_TACTIC_PROTECT <- as.data.frame.table(table(LINKS_PROTECTIONS$foraging_category)) |>
  dplyr::arrange(Freq) |>
  dplyr::mutate(y_end = 1:n(),
                y_end_scaled = scales::rescale(y_end)) |>
  dplyr::rename(foraging_category = Var1)

# Rank threats by summarising total specific links ----

FREQ_THREAT_PROTECT <- as.data.frame.table(table(LINKS_PROTECTIONS$iucn_type)) |>
  dplyr::arrange(Freq) |>
  dplyr::mutate(y_start = 1:n(),
                y_start_scaled = scales::rescale(y_start)) |>
  dplyr::rename(iucn_type = Var1)


# ylimit <- max(FREQ_TACTIC$y_end, FREQ_THREAT$y_start) * 1.20
GRAPH_PROTECTIONS <- LINKS_PROTECTIONS |>
  dplyr::left_join(y = FREQ_TACTIC_PROTECT, by = 'foraging_category') |> 
  dplyr::left_join(y = FREQ_THREAT_PROTECT, by = 'iucn_type') |>
  tibble::rownames_to_column() |>
  ggplot(aes(group = rowname)) +
  geom_segment(
    aes(x = x, xend = xend, y = y_start_scaled, yend = y_end_scaled, 
        linewidth = total_specific,
        #colour = iucn_var
        )
  ) +
  #geom_point(aes(x = x, y = y_start), size = 15) + 
  geom_label(aes(label = iucn_type, x = x, y = y_start_scaled)) +
  #geom_point(aes(x = xend, y = y_end), size = 15) + 
  geom_label(aes(label = foraging_category, x = xend, y = y_end_scaled)) +
  geom_text(aes(x = 0.25, y = 1.1, label = 'IUCN Proposed Protection Type')) +
  geom_text(aes(x = -0.25, y = 1.1, label = 'IUCN Existing Protection Type')) +
  #scale_colour_manual(values = c('black', 'grey50')) +
  scale_y_continuous(limits = c(0, 1.2)) +
  scale_x_continuous(limits = c(-0.6, 0.6)) +
  scale_linewidth_continuous(name = 'Number of specific related threats', 
                             breaks = seq(from = min(LINKS_PROTECTIONS$total_specific), 
                                          to = max(LINKS_PROTECTIONS$total_specific), 
                                          by = 3)) +  theme_void() +
  guides(colour = 'none', size = 'none') +
  theme(legend.position = 'bottom')


# Merge and export plots ----
PLOT_OUT <- cowplot::plot_grid(plotlist = list(GRAPH_THREATS, GRAPH_PROTECTIONS), ncol = 1, align = 'hv')

# Export different formats 
outFormat <- c("svg", "eps", "pdf")

# sapply(outFormat, function(x){
#   ggplot2::ggsave(
#     plot = PLOT_OUT, 
#     filename = sprintf("./figures/TripartiteNetworks_Figure_03_V2.%s", x),
#     device = sprintf('%s', x),
#     width = 210,
#     height = 290,
#     units = 'mm', 
#     dpi = 800
#   )
# })


# IGRAPH ----
tmp_colors <- ifelse(
  LINKS_THREATS$threat_direction == "Threat TO specialization",
  yes = 'firebrick', 
  no = 'grey50'
  )

g <- igraph::graph.data.frame(
  LINKS_THREATS[,c("foraging_category", "iucn_broad_classification")],
  directed = TRUE
  )

V(g)$type <- igraph::bipartite_mapping(g)$type
E(g)$color <- tmp_colors
E(g)$weight <- LINKS_THREATS$total_specific

plot(
  g,
  layout = layout.bipartite,
  edge.width = log1p(E(g)$weight)*2,
  vertex.size = 15,
  edge.curved = FALSE,
  edge.arrow.size = 0.25,
  vertex.shape = 'rectangle',
  vertex.label.cex = 0.6
)
