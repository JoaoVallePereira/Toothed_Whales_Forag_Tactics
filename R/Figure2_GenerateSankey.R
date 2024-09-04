# Read in Table
lab_table <- read.csv("")

# Count the features in the table
## Photo ID
y.pi <- sum(lab_table$Animal.identity.data == "yes")
ny.pi <- sum(lab_table$Animal.identity.data == "no")

## How wide is the behavior?
single <- sum(lab_table$Number.of.animals == "one")
more <- sum(lab_table$Number.of.animals != "one" & 
              lab_table$Animal.identity.data == "yes")

## Social transmission?
y.st <- sum(lab_table$Multiple.animals.AND.ID.AND.learned == "yes" &
              lab_table$Number.of.animals != "one" & 
              lab_table$Animal.identity.data == "yes")
n.st <- sum(lab_table$Number.of.animals != "one" & 
              lab_table$Animal.identity.data == "yes" &
              (lab_table$Learning == "Social (- evidence)" | lab_table$Learning =="Individual (+ evidence); Social (- evidence)"))
unk <- sum(lab_table$Number.of.animals != "one" & 
             lab_table$Animal.identity.data == "yes" &
             (lab_table$Learning == "Did not investigate (UNK)" | lab_table$Learning == "Investigated but unsure (UNK)"))

## Evidence?
qual <- sum(lab_table$Multiple.animals.AND.ID.AND.learned == "yes" &
              lab_table$Number.of.animals != "one" & 
              lab_table$Animal.identity.data == "yes" &
              lab_table$Nature.of.learning.evidence == "qualitative")
quan <- sum(lab_table$Multiple.animals.AND.ID.AND.learned == "yes" &
              lab_table$Number.of.animals != "one" & 
              lab_table$Animal.identity.data == "yes" &
              lab_table$Nature.of.learning.evidence != "qualitative")

## Type of quantitative evidence?
assoc <- sum(lab_table$Multiple.animals.AND.ID.AND.learned == "yes" &
               lab_table$Number.of.animals != "one" & 
               lab_table$Animal.identity.data == "yes" &
               lab_table$Nature.of.learning.evidence == "quantitative - associations")
diffus <- sum(lab_table$Multiple.animals.AND.ID.AND.learned == "yes" &
                lab_table$Number.of.animals != "one" & 
                lab_table$Animal.identity.data == "yes" &
                lab_table$Nature.of.learning.evidence == "quantitative - diffusion")
both <- sum(lab_table$Multiple.animals.AND.ID.AND.learned == "yes" &
              lab_table$Number.of.animals != "one" & 
              lab_table$Animal.identity.data == "yes" &
              lab_table$Nature.of.learning.evidence == "quantitative - diffusion & associations")

# discreteness and evolutionary significance
lik <- sum(lab_table$Multiple.animals.AND.ID.AND.learned == "yes" &
             lab_table$Number.of.animals != "one" & 
             lab_table$Animal.identity.data == "yes" &
             lab_table$Nature.of.learning.evidence != "qualitative" &
             lab_table$Evidence.for.discreteness.evolutionary.significance == "likely")

unk2 <- sum(lab_table$Multiple.animals.AND.ID.AND.learned == "yes" &
             lab_table$Number.of.animals != "one" & 
             lab_table$Animal.identity.data == "yes" &
             lab_table$Nature.of.learning.evidence != "qualitative" &
             lab_table$Evidence.for.discreteness.evolutionary.significance == "unknown") 

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
           "Social Learning (n=55)", 
           "Social Learning (n=55)",
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
           "Social Learning (n=55)", 
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
           # "Likely",
           # "Unknown",
           # "Likely",
           # "Unknown",
           # "Unknown") ,
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
          # 6,
          # 17,
          # 2,
          # 1,
          # 2)
)

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
sankey <- sankeyNetwork(Links = links,
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
require(htmlwidgets)
saveWidget(sankey, file=paste0(getwd(),"/sankey.html"))

require(webshot)
webshot::install_phantomjs()
webshot(paste0(getwd(),"/sankey.html"), paste0(getwd(),"/sankey.pdf"))


