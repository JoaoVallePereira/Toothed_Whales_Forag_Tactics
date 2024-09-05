# Load and clean table ----

#
dataTable <- read.csv("./data/240904_PhilTrans_Lab_Dataset.csv") %>% 
  janitor::clean_names() %>% 
  dplyr::mutate_if(is.character, str_trim)
# dplyr::select(common_name,
#               latin_name,
#               country,
#               region_maybe_to_plot,
#               is_forag_spec = based_on_our_definition_is_this_a_foraging_specialization,
#               specialization_type,
#               specialization_type_cat,
#               prey_category,
#               prey_latin_name,
#               prey_description,
#               habitat_category,
#               prey_latin_name,
#               demographic_category,
#               forager_demographics,
#               ecological_driver_category,
#               genetics,
#               learning,
#               transmission_direction = if_social_learning_transmission_direction,
#               evidence,
#               type_of_evidence,
#               discreteness_y_n,
#               # discreteness_original_column,
#               evolutionary_significance,
#               threats_acknowledged = acknowledged,
#               iucn_broad_threat_type,
#               iucn_specific_threat_type,
#               manag_acknowledged = acknowledged_2,
#               ID)
head(dataTable)
