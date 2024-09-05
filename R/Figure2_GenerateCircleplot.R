## Figure2_GenerateCircleplot.R: Circle plot for figure 2 
## Authors: Joao Valle-Pereira


# Prepare data to transform in Igraph format
dataTable$prey_category <- gsub("; ", "", dataTable$prey_category)

dataCircle1 <- dataTable %>%
  dplyr::mutate(foraging_category = as.character(foraging_category),
                prey_category = as.character(prey_category),
                habitat = as.character(habitat)) %>% 
  dplyr::select(prey_category,
                habitat,
                foraging_category,
                latin_name) %>% 
  dplyr::relocate(habitat, prey_category)
head(dataCircle1)

dataCircle_tmp <- dataCircle1 %>% 
  dplyr::mutate(to = paste(habitat, prey_category, sep  = ".")) %>% 
  dplyr::select(from = habitat,
                to)

dataCircle_tmp2 <- cbind(from = dataCircle_tmp$to, to = paste(dataCircle_tmp$to, 
                                                              dataCircle1$foraging_category, sep  = ".")) 


# Set edges and vertices
edges <- data.frame(rbind(dataCircle_tmp, dataCircle_tmp2)) 

vertices <- edges %>% 
  dplyr::group_by(to) %>% 
  dplyr::summarise(size = as.numeric(length(to))) %>% 
  dplyr::rename(name = to) 

vertices <- rbind(vertices, data.frame(name = c("coastal", "oceanic", "riverine"),
                                       size = 0))

list_names <- stringr::str_split(vertices$name, "[.]") %>% 
  purrr::map(pluck, 3, .default	= NA) 
tactic_tmp <- data.frame(do.call(rbind, list_names)) %>% 
  dplyr::rename(tactic = 1)

vertices$tactic <- tactic_tmp$tactic

list_names2 <- stringr::str_split(vertices$name, "[.]") %>% 
  purrr::map(pluck, 2, .default	= NA) 
prey_tmp <- data.frame(do.call(rbind, list_names2)) %>% 
  dplyr::rename(prey = 1)
vertices$prey <- prey_tmp$prey


vertices <- vertices %>% 
  dplyr::mutate(tactic = ifelse(is.na(tactic), 0, tactic))


# Make a 'graph' object using the igraph library
mygraph <- igraph::graph_from_data_frame(edges, vertices = vertices)

# Plot circlepack plot
ggraph_circle <- mygraph %>%  
  ggraph::ggraph(layout = 'circlepack', weight = size) + 
  geom_node_circle(aes(fill = factor(tactic))) +
  geom_node_text(aes(label = prey), size = 2) +
  scale_fill_manual(values = colorblind_safe_cat) +
  theme_void() 
ggraph_circle
# ggsave("./figures/ggraph_circle.pdf", dpi = 300)


