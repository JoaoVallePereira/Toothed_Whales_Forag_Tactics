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


## Contents

1. Files and directions
    * 1.1. Data and script to reproduce the figures
    * 1.2. Instructions

### 1.1. Scripts to reproduce the figures

- `Setup.R`: This file contains the code to install and load the packages and the functions required to run the figures in `.R`.
- `Load_Data.R`: This file contains the code to load and clean the data.
- `Figure2_GenerateBarplots.R`: This file contains the code to generate de bar plots from Figure 2 of the paper.
- `Figure2_GenerateCircleplot.R`: This file contains the code to generate de circle plot from Figure 2 of the paper.
- `Figure2_GenerateSankey.R`: This file contains the code to generate de sankey plot from Figure 2 of the paper.
- `Figure2_GenerateMaps.R`: This file contains the code to generate de map from Figure 2 of the paper.
- `Figure3_GenerateNetworks.R`: This file contains the code to generate de networks from Figure 3 of the paper.

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
**Note:** The workflow to run at the time of this message is:  `Setup.R` &rarr; `Load_data.R` &rarr; `FigureX_GenerateX.R`. 

--------------------------------------

