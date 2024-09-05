## Figure2_GenerateSankey.R: Sankey plot for figure 2
## Authors: Kyra Bankhead & Mauricio Cantor


# Count the features in the table
## Photo ID
y.pi <- sum(dataTable$animal_identity_data == "yes")
ny.pi <- sum(dataTable$animal_identity_data == "no")

## How wide is the behavior?
single <- sum(dataTable$number_of_animals == "one")
more <- sum(dataTable$number_of_animals != "one" & 
              dataTable$animal_identity_data == "yes")

## Social transmission?
y.st <- sum(dataTable$putative_specialised_foraging_tactic == "yes" &
              dataTable$number_of_animals != "one" & 
              dataTable$animal_identity_data == "yes")
n.st <- sum(dataTable$number_of_animals != "one" & 
              dataTable$animal_identity_data == "yes" &
              (dataTable$learning == "Social (- evidence)" | dataTable$learning =="Individual (+ evidence); Social (- evidence)"))
unk <- sum(dataTable$number_of_animals != "one" & 
             dataTable$animal_identity_data == "yes" &
             (dataTable$learning == "Did not investigate (UNK)" | dataTable$learning == "Investigated but unsure (UNK)"))

## Evidence?
qual <- sum(dataTable$putative_specialised_foraging_tactic == "yes" &
              dataTable$number_of_animals != "one" & 
              dataTable$animal_identity_data == "yes" &
              dataTable$nature_of_social_learning_evidence == "qualitative", na.rm = TRUE)
quan <- sum(dataTable$putative_specialised_foraging_tactic == "yes" &
              dataTable$number_of_animals != "one" & 
              dataTable$animal_identity_data == "yes" &
              dataTable$nature_of_social_learning_evidence != "qualitative", na.rm = TRUE)

## Type of quantitative evidence?
assoc <- sum(dataTable$putative_specialised_foraging_tactic == "yes" &
               dataTable$number_of_animals != "one" & 
               dataTable$animal_identity_data == "yes" &
               dataTable$nature_of_social_learning_evidence == "quantitative - associations", na.rm = TRUE)
diffus <- sum(dataTable$putative_specialised_foraging_tactic == "yes" &
                dataTable$number_of_animals != "one" & 
                dataTable$animal_identity_data == "yes" &
                dataTable$nature_of_social_learning_evidence == "quantitative - diffusion", na.rm = TRUE)
both <- sum(dataTable$putative_specialised_foraging_tactic == "yes" &
              dataTable$number_of_animals != "one" & 
              dataTable$animal_identity_data == "yes" &
              dataTable$nature_of_social_learning_evidence == "quantitative - diffusion & associations", na.rm = TRUE)

# discreteness and evolutionary significance
lik <- sum(dataTable$putative_specialised_foraging_tactic == "yes" &
             dataTable$number_of_animals != "one" & 
             dataTable$animal_identity_data == "yes" &
             dataTable$nature_of_social_learning_evidence != "qualitative" &
             dataTable$evidence_for_discreteness_significance == "likely", na.rm = TRUE)

unk2 <- sum(dataTable$putative_specialised_foraging_tactic == "yes" &
             dataTable$number_of_animals != "one" & 
             dataTable$animal_identity_data == "yes" &
             dataTable$nature_of_social_learning_evidence != "qualitative" &
             dataTable$evidence_for_discreteness_significance == "unknown", na.rm = TRUE) 



# Create Sankey Plot
# Connection data frame
links <- data.frame(
  source=c("Toothed whale foraging tactics (n=190)",
           "Toothed whale foraging tactics (n=190)",
           "Individual ID available (n=104)", 
           "Individual ID available (n=104)",
           "Done by >1 individual (n=98)",
           "Done by >1 individual (n=98)",
           "Done by >1 individual (n=98)",
           "Social learning (n=55)", 
           "Social learning (n=55)",
           "Quantitative (n=28)",
           "Quantitative (n=28)",
           "Quantitative (n=28)", 
           "Association (n=23)",
           "Association (n=23)",
           "Association+Diffusion (n=3)",
           "Association+Diffusion (n=3)",
           "Diffusion (n=2)"),
  target=c("Individual ID available (n=104)",
           "No Individual ID (n=86)",
           "Done by >1 individual (n=98)", 
           "Done by 1 individual (n=6)", 
           "Social learning (n=55)", 
           "Evidence against social learning (n=5)",
           "Unknown or unsure (n=38)",
           "Quantitative (n=28)", 
           "Qualitative (n=27)",
           "Association+Diffusion (n=3)",
           "Diffusion (n=2)",
           "Association (n=23)", 
           "Unknown",
           "Likely",
           "Likely",
           "Unknown",
           "Unknown") ,
  value=c(y.pi, 
          ny.pi, 
          more, 
          single, 
          y.st, 
          n.st,
          unk,
          quan, 
          qual,
          both,
          diffus,
          assoc,
          17,
          6,
          2,
          1,
          2)
)
links

# Create a node data frame: it lists every entities involved in the flow
nodes <- data.frame(
  name=c(as.character(links$source), 
         as.character(links$target)) %>% unique()
)

# node colors
nodes$group <- as.factor(c("i","i","ii","iii","iii","iii","iii","iii",
                           "i", "i", "ii", "ii", "iii", "iii", "iv"))
# Give a color for each group:
my_color <- 'd3.scaleOrdinal() .domain(["i", "ii", "iii", "iv"]) .range(["black", "darkgray", "lightgray", "white"])'


# With networkD3, connect using id
links$IDsource <- match(links$source, nodes$name)-1 
links$IDtarget <- match(links$target, nodes$name)-1

# Create the Sankey diagram
sankey <- networkD3::sankeyNetwork(Links = links,
                        Nodes = nodes,
                        Source = "IDsource",
                        Target = "IDtarget",
                        Value = "value",
                        NodeID = "name",
                        sinksRight = FALSE, 
                        units = "TWh", 
                        fontSize = 10,
                        nodeWidth = 50,
                        NodeGroup="group",
                        colourScale= my_color)  # Apply the custom color scale


# Remove the text labels
sankey <- htmlwidgets::onRender(sankey, "
  function(el) {
    d3.select(el).selectAll('.node text').remove();
  }
")

# Display the modified Sankey diagram
sankey

# export to PDF
# saveWidget(sankey, file=paste0(getwd(),"./figures/sankey.html"))
# webshot(paste0(getwd(),"./figures/sankey.html"), paste0(getwd(),"./figures/sankey.pdf"))


