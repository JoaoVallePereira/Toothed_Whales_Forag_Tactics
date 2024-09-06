# Load and clean main table names ----

dataTable <- read.csv("./data/dataTable_Forag_Tactics.csv") %>% 
  janitor::clean_names() %>% 
  dplyr::mutate_if(is.character, str_trim)
head(dataTable)


# Load and clean map table names ----

dataTable_map <- read.csv("./data/dataTable_Forag_Tactics_map.csv") %>% 
janitor::clean_names() %>%
  dplyr::rename(common_name = spp_common,
                latin_name = spp_latin,
                country = map_region,
                region = map_subregion,
                putative_specialised_foraging_tactic = multan_id_learn,
                foraging_category = tactic_category
                )
# head(dataTable_map)





