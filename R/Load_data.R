# Load and clean table ----

#
dataTable <- read.csv("./data/240904_PhilTrans_Lab_Dataset.csv") %>% 
  janitor::clean_names() %>% 
  dplyr::mutate_if(is.character, str_trim)
head(dataTable)
