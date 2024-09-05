## Figure2_GenerateMap.R: maps for figure 2 (global map with data summaries)
## Authors: Michaela Kratofil & Kiera McGarvey Sears


## -------------------------------------------------------------------------- ##

# review
unique(dataTable_map$common_name)
unique(dataTable_map$region) 
unique(dataTable_map$foraging_category) 
unique(dataTable_map$putative_specialised_foraging_tactic) 
summary(dataTable_map)

# now make behavior specialisation type category a leveled factor, and level
# by grouping by whether the behavior involves humans or not 
unique(dataTable_map$foraging_category)
dataTable_map$tactic_cat_fact <- factor(dataTable_map$foraging_category,
                                      levels = c("Fisheries interaction",
                                                 "Human-cetacean cooperation",
                                                 "Human-mediated feeding",
                                                 "Aquaculture-associated foraging",
                                                 "Shore-based hunting",
                                                 "Prey herding",
                                                 "Prey disruption",
                                                 "Prey species specialisation",
                                                 "Seabird interaction",
                                                 "Tool use"))

# check
summary(dataTable_map$tactic_cat_fact)

# recategorize the cases that have multiple animals, ID data, and evidence of 
# social learning 
dataTable_map <- dataTable_map %>%
  mutate(
    evidence_for_discreteness_significance = ifelse(is.na(putative_specialised_foraging_tactic), "no", putative_specialised_foraging_tactic)
  )


## get polygons of the world to make map out of ## -------------------------- ##
world <- ne_countries(scale = "large", returnclass = "sf")
world

## globe with data points ## ------------------------------------------------ ##

# make into spatial object 
dataTable_map_sf <- st_as_sf(dataTable_map, coords = c("longitude","latitude"), crs = 4326)

# get interactive plot to check points manually
mapview::mapview(dataTable_map_sf)

# fill circles if they have evidence for putative cultural trait
# get the no evidence separate from the yes evidence
nos <- filter(dataTable_map_sf, evidence_for_discreteness_significance == "no")
yes <- filter(dataTable_map_sf, evidence_for_discreteness_significance == "yes")

# make the map
ggplot() +
  geom_sf(data = world, color = NA, fill = "gray80") +
  geom_sf(data = yes, color = "black", size = .85) +
  geom_sf(data = nos, fill = "white", color = "black", shape = 21, size = .85) +
  theme_void() 

# save the map 
# ggsave(here("figures","figure2_map_case_points_fill_by_evidence.pdf"),
       # width = 12, height = 6, units = "in", dpi = 500)

## regional insets with points ## -------------------------------------------- ##

## Hawaii
ggplot() +
  geom_sf(data = world, color = NA, fill = "gray80") +
  geom_sf(data = dataTable_map_sf, aes(fill = evidence_for_discreteness_significance), color = "black", shape = 21, size = 4.5) +
  scale_fill_manual(values = c("white","black")) +
  coord_sf(xlim = c(-161, -154),
           ylim = c(18, 23),
           crs = 4326) +
  theme_void() +
  theme(
    legend.position = "none"
  )

# ggsave(here("figures","hawaii_pts.pdf"), width = 5, height = 4, units = "in",
       # dpi = 500)

## SE Brazil 
ggplot() +
  #geom_sf(data = world, color = NA, fill = "gray25") +
  geom_sf(data = world, color = NA, fill = "gray80") +
  geom_sf(data = dataTable_map_sf, aes(fill = evidence_for_discreteness_significance), color = "black", shape = 21, size = 5.5) +
  scale_fill_manual(values = c("white","black")) +
  coord_sf(xlim = c(-53, -37.5),
           ylim = c(-32.7, -23.9),
           crs = 4326) +
  theme_void() +
  theme(
    legend.position = "none"
  )

# ggsave(here("figures","se_brazil_pts.pdf"), width = 4, height = 4, units = "in",
       # dpi = 500)

## Eastern Australia
ggplot() +
  #geom_sf(data = world, color = NA, fill = "gray25") +
  geom_sf(data = world, color = NA, fill = "gray80") +
  geom_sf(data = yes, color = "black", size = 4.5) +
  geom_sf(data = nos, fill = "white", color = "black", shape = 21, size = 4.5) +
  coord_sf(xlim = c(151, 158.5),
           ylim = c(-30, -25),
           crs = 4326) +
  theme_void() +
  theme(
    legend.position = "none"
  )

# ggsave(here("figures","east_aus_pts.pdf"), width = 3, height = 3, units = "in",
       # dpi = 500)

## sub-regional insets with points colored by tactic ## --------------------- ##

# palette for tactic categories 
colorblind_safe_cat <- c("#1B9E77","#7FC97F","#8DD3C7","#A6CEE3",
                         "#C2A5CF","#FDB863","#F4A582","#E66101","#A6611A","#CA0020")

## Gulf of Mexico/SE United States/Caribbean ## ----------------------------- ##

# all of GOM
ggplot() +
  geom_sf(data = world, color = NA, fill = "gray80") +
  geom_sf(data = yes, aes(color = tactic_cat_fact),
          size = 4.5) +
  geom_sf(data = nos, aes(color = tactic_cat_fact),  fill = NA, shape = 21,
          size = 4, stroke = 1.5) +
  scale_color_manual(values = colorblind_safe_cat) +
  coord_sf(xlim = c(-95.15,-78.6),
           ylim = c(24,33.2),
           crs = 4326) +
  theme_void() +
  theme(
    legend.position = "none"
  )

# ggsave(here("Figures","gulf_of_mx_caribbean_colored_by_tactic_category_fill_by_evidence.pdf"),
       # width = 5, height = 4, units = "in", dpi = 500)

# map of sarasota bay specifically
ggplot() +
  geom_sf(data = world, color = NA, fill = "gray80") +
  geom_sf(data = yes, aes(color = tactic_cat_fact), 
          size = 5.5) +
  geom_sf(data = nos, aes(color = tactic_cat_fact),  fill = NA, shape = 21, 
          size = 5, stroke = 1.5) +
  scale_color_manual(values = colorblind_safe_cat) +
  coord_sf(xlim = c(-83,-82.45),
           ylim = c(27.25,27.6),
           crs = 4326) +
  theme_void() +
  theme(
    legend.position = "none"
  )
# ggsave(here("figures","sarasota_bay_colored_by_tactic_category_fill_by_evidence.pdf"),
       # width = 3, height = 3, units = "in")


## Europe ## ---------------------------------------------------------------- ##

# map most of europe for inset
ggplot() +
  geom_sf(data = world, color = NA, fill = "gray80") +
  geom_sf(data = yes, color = "black", size = 3.5) +
  geom_sf(data = nos, fill = "white", color = "black", shape = 21, size = 3.5) +
  coord_sf(xlim = c(-14,39),
           ylim = c(29,46),
           crs = 4326) +
  theme_void() +
  theme(
    legend.position = "none"
  )

# ggsave(here("figures","europe_fill_by_evidence.pdf"), width = 6, height = 4, units = "in")

# Lampedusa island zoomed in
ggplot() +
  geom_sf(data = world, color = NA, fill = "gray80") +
  geom_sf(data = yes, color = "black", size = 3.5) +
  geom_sf(data = nos, fill = "white", color = "black", shape = 21, size = 3.5) +
  coord_sf(xlim = c(11.97,13.1),
           ylim = c(35.1,35.8),
           crs = 4326) +
  theme_void() +
  theme(
    legend.position = "none"
  )

# ggsave(here("figures","lampedusa_island_fill_by_evidence.pdf"), width = 4, height = 4, units = "in")


## Western Australia ## ------------------------------------------------------ ##

# map of shark bay
ggplot() +
  geom_sf(data = world, color = NA, fill = "gray80") +
  geom_sf(data = yes, aes(color = tactic_cat_fact), 
          size = 4.5) +
  geom_sf(data = nos, aes(color = tactic_cat_fact),  fill = NA, shape = 21, 
          size = 4, stroke = 1) +
  scale_color_manual(values = colorblind_safe_cat) +
  coord_sf(xlim = c(112.4,114.5),
           ylim = c(-26.7,-25.1),
           crs = 4326) +
  theme_void() +
  theme(
    legend.position = "none"
  )

# ggsave(here("figures","shark_bay_colored_by_specialization_category_fill_by_evidence.pdf"),
       # width = 2.5, height = 2.5, units = "in")


# map of bunbury
ggplot() +
  geom_sf(data = world, color = NA, fill = "gray80") +
  geom_sf(data = yes, aes(color = tactic_cat_fact), 
          size = 3.75) +
  geom_sf(data = nos, aes(color = tactic_cat_fact),  fill = NA, shape = 21, 
          size = 3.75, stroke = 1) +
  scale_color_manual(values = colorblind_safe_cat) +
  coord_sf(xlim = c(113.5,117),
           ylim = c(-34,-31.5),
           crs = 4326) +
  theme_void() +
  theme(
    legend.position = "none"
  )

# ggsave(here("figures","bunbury_colored_by_specialization_category_fill_by_evidence.pdf"),
       # width = 2, height = 2, units = "in")

## Northern South China Sea ## ----------------------------------------------- ##

# entire subregion
ggplot() +
  geom_sf(data = world, color = NA, fill = "gray80") +
  geom_sf(data = yes, aes(color = tactic_cat_fact), 
          size = 4.5) +
  geom_sf(data = nos, aes(color = tactic_cat_fact),  fill = NA, shape = 21, 
          size = 3.5, stroke = 1.25) +
  scale_color_manual(values = colorblind_safe_cat) +
  coord_sf(xlim = c(108.5, 114.3),
           ylim = c(20.6, 22.6),
           crs = 4326) +
  theme_void() +
  theme(
    legend.position = "none"
  )

# ggsave(here("figures","n_southchinasea_colored_by_specialization_category_fill_by_evidence.pdf"),
       # width = 4, height = 3, units = "in")

# Zhanjiang area 
ggplot() +
  geom_sf(data = world, color = NA, fill = "gray80") +
  geom_sf(data = yes, aes(color = tactic_cat_fact), 
          size = 4.5) +
  geom_sf(data = nos, aes(color = tactic_cat_fact),  fill = NA, shape = 21, 
          size = 5, stroke = 1.25) +
  scale_color_manual(values = colorblind_safe_cat) +
  coord_sf(xlim = c(110.1, 110.8),
           ylim = c(20.7, 21.15),
           crs = 4326) +
  theme_void() +
  theme(
    legend.position = "none"
  )

# ggsave(here("figures","zhanjiang_colored_by_specialization_category_fill_by_evidence.pdf"),
       # width = 2.5, height = 1.75, units = "in")

# Hong Kong area 
ggplot() +
  geom_sf(data = world, color = NA, fill = "gray80") +
  geom_sf(data = yes, aes(color = tactic_cat_fact), 
          size = 4.5) +
  geom_sf(data = nos, aes(color = tactic_cat_fact),  fill = NA, shape = 21, 
          size = 5, stroke = 1.25) +
  scale_color_manual(values = colorblind_safe_cat) +
  coord_sf(xlim = c(113, 113.9),
           ylim = c(21.5, 22.2),
           crs = 4326) +
  theme_void() +
  theme(
    legend.position = "none"
  )

# ggsave(here("figures","hongkong_colored_by_specialization_category_fill_by_evidence.pdf"),
       # width = 2.5, height = 2, units = "in")
