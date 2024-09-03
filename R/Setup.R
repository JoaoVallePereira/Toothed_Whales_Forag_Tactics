# Install/load packages -----
if(!require(tidyverse)){install.packages('tidyverse'); library(tidyverse)}
if(!require(janitor)){install.packages('janitor'); library(janitor)}
if(!require(ggplot2)){install.packages('ggplot2'); library(ggplot2)}
if(!require(ggpubr)){install.packages('ggpubr'); library(ggpubr)}
if(!require(sf)){install.packages('sf'); library(sf)}
if(!require(here)){install.packages('here'); library(here)}
if(!require(rnaturalearth)){install.packages('rnaturalearth'); library(rnaturalearth)}
if(!require(rnaturalearthhires)){install.packages('rnaturalearthhires'); library(rnaturalearthhires)}
if(!require(rvest)){install.packages('rvest'); library(rvest)}
if(!require(scales)){install.packages('scales'); library(scales)}


## Functions
# 
#'@author Alexandre M. S. Machado
#'
#'@param data data frame from labirinto table
#'@param by string. Column name to group data
#'@param broad string. Column name of broad threat type, existing protection or proposed protection type
#'@param specific string. Column name of specific threat type, existing protection or proposed protection type

summarise_links <- function(data, by, broad, specific) {
  
  grouping_vars <- rlang::syms(c(by, broad))
  
  data |>
    tidyr::separate_rows(!!rlang::sym(broad), sep = '; ') |>
    dplyr::mutate(
      specific_count = str_count(
        string = !!rlang::sym(specific), 
        pattern = paste0(!!rlang::sym(broad), ".")
      )
    ) |>
    dplyr::select(specific_count, !!!grouping_vars) |>
    dplyr::group_by(!!!grouping_vars) |>
    dplyr::summarise(total_specific = sum(specific_count, na.rm = TRUE), .groups = 'drop')
}
