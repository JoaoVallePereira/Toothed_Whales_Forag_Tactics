# README #
<img src="man/logo_git_OFT.png" align="right" width="180px"/>

Author, maintainer and contact 

João V. S. do Valle-Pereira[![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](http://orcid.org/0000-0002-1880-9495): joao.vallepereira@oregonstate.edu     

&nbsp;
&nbsp;


--------------------------------------
## Description

This repository includes the R script to reproduce the figures of the manuscript:     
## Ecology and conservation of socially learned foraging tactics in toothed whales *In prep*.
**Taylor A. Hersh 1***[![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](http://orcid.org/0000-0002-7891-596X), João V. S. Valle-Pereira 1[![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](http://orcid.org/0000-0002-1880-9495), Daiane S. Marcondes 1,2[![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](http://orcid.org/0000-0002-6705-7779), Gabriel F. Fonseca 1,2[![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](http://orcid.org/0009-0004-1491-8258), Shanan Atkins 3[![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](http://orcid.org/0000-0003-2327-5077), Kyra Bankhead 1[![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](http://orcid.org/0000-0002-5194-2802), Mahmud Rahman1[![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](http://orcid.org/0009-0006-2800-9199), Michaela Kratofil 1[![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](http://orcid.org/0000-0001-9519-9152), Stephane P. G. Moura 1,2[![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](http://orcid.org/0000-0002-8715-2845), Alexandre M. S. Machado 4[![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](http://orcid.org/0000-0001-6252-6890), Kiera M. Sears 1[![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](http://orcid.org/0009-0008-1183-8374), Fernanda Fecci 2[![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](http://orcid.org/0000-0002-3587-1362), Mauricio Cantor 1-4*[![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](http://orcid.org/0000-0002-0019-5106)

1 Marine Mammal Institute, Department of Fisheries, Wildlife and Conservation Sciences. Oregon State University. Newport OR, USA<br>
2 Graduate Program in Coastal and Estuarine Systems,Center for Marine Studies, Universidade Federal do Paraná. Pontal do Paraná PR, Brazil<br>
3 School of Animal, Plant and Environmental Sciences, University of the Witwatersrand. Johannesburg, South Africa<br>
4 Graduate Program in Ecology, Department of Ecology and Zoology, Universidade Federal de Santa Catarina, Florianópolis SC, Brazil<br>

\* Corresponding authors: taylor.hersh@oregonstate.edu, mauricio.cantor@oregonstate.edu 

### Abstract
Culture—group-typical behaviour shared by community members that rely on socially learned and transmitted information—can drive animal adaptations to local environments and thus has the potential of generating specialised behavioural tactics to solve fundamental life challenges, including capturing prey. However, as human cultures rapidly change the world in unprecedented ways, animal foraging cultures may no longer represent optimal solutions to local environments. Toothed whales are of particular concern because they rely on learned, specialised foraging tactics in habitats highly affected by human activities. We present a global inventory of toothed whale foraging tactics to evaluate their cultural underpinnings, vulnerability to human-induced threats, and how this knowledge can inform safeguards. Our synthesis reveals a diverse repertoire—190 cases of 36 foraging tactics in 21 species—but highlights that linkages between culture and anthropogenic impacts are generally obscured by a dearth of data on individual identity, social associations, and behavioural diffusion. By identifying global patterns, knowledge gaps, and common threats to specialised foraging, our review can guide long-term research towards understanding their ecological and evolutionary drivers. This crucial first step towards designing policies that mitigate human impacts on marine habitats may ultimately protect the diverse toothed whale behavioural repertoire that contribute to their survival.


DOI: 

### Data is available at ZENODO LINK

## Contents

1. Files and directions
    * 1.1. Scripts to reproduce the figures
    * 1.2. Instructions

### 1.1. Scripts to reproduce the figures

- `Setup.R`: This file contains the code to install and load the packages and the functions required to run the figures in all the following scripts.
- `Load_Data.R`: This file contains the code to load and clean the data.
- `Figure2_GenerateBarplots.R`: This file contains the code to generate the bar plots from Figure 2 of the paper.
- `Figure2_GenerateCircleplot.R`: This file contains the code to generate the circle plot from Figure 2 of the paper.
- `Figure2_GenerateSankey.R`: This file contains the code to generate the sankey plot from Figure 2 of the paper.
- `Figure2_GenerateMaps.R`: This file contains the code to generate the map from Figure 2 of the paper.
- `Figure3_GenerateNetworks.R`: This file contains the code to generate the networks from Figure 3 of the paper.

- `Figure2_GenerateBarplots.R`: This file contains the code to manage, clean, and prepare the data to be run in the `.R` script.

| Variable                                 | Class              | Description                            |
|------------------------------------------|--------------------|----------------------------------------|
| common_name                              | Character          | The common name of the species exhibiting the foraging tactic   |
| latin_name                               | Character          | The Latin name of the species exhibiting the foraging tactic|
| animal_identity_data                     | Character          | Whether identity information for the individual(s) exhibiting the foraging tactic is available    |
| number_of_animals                        | Character          | The number of different individuals exhibiting the foraging tactic                                       |
| foraging_category                        | Character          | The broad foraging category that the specific foraging tactic most closely aligns with                      |
| foraging_tactic                          | Character          | The specific foraging tactic                                       |
| tactic_driver                            | Character          | The key factor influencing or determining the observed foraging tactic                         |
| human_induced                            | Character          | Whether the foraging tactic is human-induced or not                   |
| prey_category                            | Character          | The type of prey being targeted during the foraging tactic                                       |
| habitat                                  | Character          | The type of habitat in which the foraging tactic is exhibited                                       |
| prey_category                            | Character          | The type of prey being targeted during the foraging tactic                                       |
| putative_specialised_foraging_tactic     | Character          | Foraging tactics having both individual identity information and evidence of being shared among conspecifics|
| putative_cultural_foraging_tactic        | Character          | Foraging tactics with positive evidence of social learning                                       |
| transmission_direction                   | Character          | How the foraging tactic is transmitted, given positive evidence of social learning                          |
| nature_of_social_learning_evidence       | Character          | The type of evidence for social learning                                     |
| culture_acknowledgement                  | Character          | The type of evidence for social learning                                      |
| evidence_for_discreteness_significance   | Character          | Evidence for differences in diet or foraging techniques that are stable                                       |
| threat_acknowledgement                   | Character          | Whether the reviewed studies acknowledge anthropogenic threats          |
| threat_category                          | Character          | For studies that acknowledge anthropogenic threats and impacts, the type of IUCN-CMP first-level threat classification  |
| threat_subcategory                       | Character          | For studies that acknowledge anthropogenic threats and impacts, the type of IUCN-CMP second-level threat classification|
| threat_direction                         | Character          | Whether the acknowledged threats were considered a threat to or a consequence of the foraging tactic   |
| conservation_actions_acknowledgement     | Character          | Whether the reviewed studies acknowledge existing or proposed conservation actions related to the foraging tactic  |
| existing_conservation_actions_category   | Character          | Existing conservation actions related to the foraging tactic, the type of IUCN-CMP first-level action classification  |
| existing_conservation_actions_subcategory| Character          | Existing conservation actions related to the foraging tactic, the type of IUCN-CMP second-level action classification  |
| proposed_conservation_actions_category   | Character          | Proposed conservation actions related to the foraging tactic, the type of IUCN-CMP first-level action classification    |
| proposed_conservation_actions_subcategory| Character          | Proposed conservation actions related to the foraging tactic, the type of IUCN-CMP second-level action classification   |
| references                               | Character          | Reviewed primary and secondary literature used to fill out metrics for the foraging tactic |

### 1.2. Instructions

Scripts contain relative paths to source functions and load data. Open an R session and set the working directory to the root of the project for better compatibility with relative paths. The tree below show how files were organized in the project folder:

```bash
Toothed_Whales_Forag_Tactics/
├── R/                        # contains the code to generate the figures
├── figures/                  # stores figures 
└── man/                      # contain the figure to implement in the GitHub layout
```

### This paper was produced using the following software and associated packages:

```bash

R version 4.4.1 (2024-06-14 ucrt)
Platform: x86_64-w64-mingw32/x64
Running under: Windows 11 x64 (build 22631)

Matrix products: default


locale:
[1] LC_COLLATE=English_United States.utf8  LC_CTYPE=English_United States.utf8   
[3] LC_MONETARY=English_United States.utf8 LC_NUMERIC=C                          
[5] LC_TIME=English_United States.utf8    

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
 [1] mapview_2.11.2      webshot_0.5.5       devtools_2.4.5      usethis_3.0.0      
 [5] igraph_2.0.3        ggraph_2.2.1        htmlwidgets_1.6.4   networkD3_0.4      
 [9] scales_1.3.0        rvest_1.0.4         rnaturalearth_1.0.1 here_1.0.1         
[13] sf_1.0-16           ggpubr_0.6.0        janitor_2.2.0       lubridate_1.9.3    
[17] forcats_1.0.0       stringr_1.5.1       dplyr_1.1.4         purrr_1.0.2        
[21] readr_2.1.5         tidyr_1.3.1         tibble_3.2.1        ggplot2_3.5.1      
[25] tidyverse_2.0.0    

loaded via a namespace (and not attached):
  [1] RColorBrewer_1.1-3            rstudioapi_0.16.0             jsonlite_1.8.8               
  [4] magrittr_2.0.3                farver_2.1.2                  fs_1.6.4                     
  [7] ragg_1.3.2                    vctrs_0.6.5                   memoise_2.0.1                
 [10] base64enc_0.1-3               terra_1.7-78                  rstatix_0.7.2                
 [13] htmltools_0.5.8.1             curl_5.2.2                    broom_1.0.6                  
 [16] raster_3.6-26                 KernSmooth_2.23-24            cachem_1.1.0                 
 [19] mime_0.12                     lifecycle_1.0.4               pkgconfig_2.0.3              
 [22] R6_2.5.1                      fastmap_1.2.0                 shiny_1.9.1                  
 [25] rnaturalearthhires_1.0.0.9000 snakecase_0.11.1              selectr_0.4-2                
 [28] digest_0.6.37                 colorspace_2.1-1              ps_1.7.7                     
 [31] rprojroot_2.0.4               leafem_0.2.3                  pkgload_1.4.0                
 [34] textshaping_0.4.0             crosstalk_1.2.1               labeling_0.4.3               
 [37] fansi_1.0.6                   timechange_0.3.0              httr_1.4.7                   
 [40] polyclip_1.10-7               abind_1.4-5                   compiler_4.4.1               
 [43] proxy_0.4-27                  remotes_2.5.0                 withr_3.0.1                  
 [46] backports_1.5.0               carData_3.0-5                 viridis_0.6.5                
 [49] DBI_1.2.3                     pkgbuild_1.4.4                ggforce_0.4.2                
 [52] ggsignif_0.6.4                MASS_7.3-60.2                 sessioninfo_1.2.2            
 [55] leaflet_2.2.2                 classInt_0.4-10               tools_4.4.1                  
 [58] units_0.8-5                   httpuv_1.6.15                 glue_1.7.0                   
 [61] satellite_1.0.5               callr_3.7.6                   promises_1.3.0               
 [64] grid_4.4.1                    generics_0.1.3                leaflet.providers_2.0.0      
 [67] gtable_0.3.5                  tzdb_0.4.0                    class_7.3-22                 
 [70] hms_1.1.3                     tidygraph_1.3.1               sp_2.1-4                     
 [73] xml2_1.3.6                    car_3.1-2                     utf8_1.2.4                   
 [76] ggrepel_0.9.5                 pillar_1.9.0                  later_1.3.2                  
 [79] tweenr_2.0.3                  lattice_0.22-6                tidyselect_1.2.1             
 [82] miniUI_0.1.1.1                gridExtra_2.3                 stats4_4.4.1                 
 [85] graphlayouts_1.1.1            stringi_1.8.4                 yaml_2.3.10                  
 [88] codetools_0.2-20              cli_3.6.3                     xtable_1.8-4                 
 [91] systemfonts_1.1.0             jquerylib_0.1.4               munsell_0.5.1                
 [94] processx_3.8.4                Rcpp_1.0.13                   png_0.1-8                    
 [97] ellipsis_0.3.2                profvis_0.3.8                 urlchecker_1.0.1             
[100] viridisLite_0.4.2             e1071_1.7-14                  crayon_1.5.3                 
[103] rlang_1.1.4                   cowplot_1.1.3    
--------------------------------------

