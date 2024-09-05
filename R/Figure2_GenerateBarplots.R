## Figure2_GenerateBarplots.R: Barplots for figure 2 
## Authors: Joao Valle-Pereira


# Plot age of class of foraging tactics with photo ID infomation ----
age_plot <- dataTable %>% 
  dplyr::filter(age_class != "unknown",
                animal_identity_data == "yes") %>% 
  dplyr::group_by(sex, age_class) %>%  
  dplyr::summarize(Count = n()) %>% 
  ggplot() +
  geom_col(aes(y = Count, x = sex,  fill = sex)) +
  xlab("") +
  ylab("") +
  facet_wrap(~age_class) +
  scale_fill_manual(values = c("#000000","#696969","#D3D3D3", "#C0C0C0")) +
  theme_classic() +
  theme(legend.position = "none",
        text = element_text(size=15))
age_plot
# ggsave(file="./figures/age_plot.pdf", plot=age_plot, width=10, height=8)

# Plot transmission mode of the putative cultural foraging tactics ----
transmission_plot <- dataTable %>% 
  dplyr::filter(transmission_direction != "unknown",
                putative_cultural_foraging_tactic == "yes") %>% 
  dplyr::mutate(transmission_short = ifelse(transmission_direction != "vertical" &
                                              transmission_direction != "horizontal",
                                            "multiple", 
                                            transmission_direction)) %>% 
  dplyr::group_by(transmission_short) %>%  
  dplyr::summarize(Count = n()) %>% 
  ggplot() +
  geom_col(aes(y = Count, x = transmission_short,  fill = transmission_short)) +
  xlab("Transmission direction") +
  ylab("") +
  scale_fill_manual(values = c("#000000","#D3D3D3", "#808080"),
                    name = "Transmission direction") +
  theme_classic() +
  theme(legend.position = "none",
        text = element_text(size=15))
transmission_plot
# ggsave(file="./figures/transmission_plot.pdf", plot=transmission_plot, width=10, height=8)

# Plot tactic reliance on the nature of their prey or physical structures ----
tactic_driver_plot <- dataTable %>%  
  dplyr::group_by(common_name, tactic_driver) %>%  
  dplyr::summarize(Count = n()) %>%
  ggplot() +
  geom_bar(aes(y = forcats::fct_reorder(common_name, Count, .desc = TRUE),
               x = Count,
               fill = tactic_driver), stat = "identity") +
  scale_fill_manual(values = c("#696969","#D3D3D3"), 
                    name = "Tactic driver") +
  scale_x_continuous(expand = c(0,0)) +
  ylab("") +
  xlab("Number of cases") +
  theme_bw() +
  theme(axis.title.y = element_text(margin = margin(t = 0, r = 20, b = 0, l = 0))) +
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank(),
        text = element_text(size=15)) 
tactic_driver_plot
# ggsave(file = "./figures/tactic_driver_plot.pdf", plot = tactic_driver_plot, width=10, height=8)

