#########################################
dataTable_driver %>%  
  group_by(common_name, human_induced, tactic_driver) %>%  
  summarize(Count = n()) %>%
  ggplot() +
  geom_bar(aes(y = forcats::fct_reorder(common_name, Count, .desc = TRUE),
               x = Count,
               fill = human_induced), stat = "identity") +
  scale_fill_manual(values = c("#696969","#D3D3D3"), 
                    name = "Tactic driver",
                    guide = guide_legend(label.theme = element_text(face = "italic"))) +
  ylab("Species") +
  xlab("Number of cases") +
  theme_test() +
  theme(axis.title.y = element_text(margin = margin(t = 0, r = 20, b = 0, l = 0))) 


# Plot transmission direc

dataTable_transmission <- dataTable %>% 
  dplyr::filter(!is.na(transmission_direction),
                transmission_direction != "unknown",
putative_specialised_foraging_tactic == "yes") %>% 
  dplyr::mutate(transmission_short = ifelse(transmission_direction != "vertical" &
                                              transmission_direction != "horizontal", "multiple", transmission_direction))


dataTable_transmission %>%  
  group_by(common_name, transmission_short) %>%  
  summarize(Count = n()) %>% 
  ggplot() +
  geom_bar(aes(y = Count, x = transmission_short, fill = transmission_short), stat = "identity", position = "dodge") +
  scale_fill_manual(values = colorblind_safe_cat, 
                    name = "Transmission direction") +
  theme_test() +
  ylab("Number of cases") +
  xlab("Species") +
  theme(axis.title.y = element_text(margin = margin(t = 0, r = 20, b = 0, l = 0)),
        axis.title.x = element_text(margin = margin(t = 20, r = 0, b = 0, l = 0)))

descriptive_plots <- ggpubr::ggarrange(tactic_broad,tactic_specific, transmission_direction, tactic_driver)
ggsave("descriptive_plots.PNG", width = 240, height = 200, dpi = 600)

dataTable_transmission %>%  
  group_by(common_name, transmission_short) %>%  
  summarize(Count = n()) %>% 
  ggplot() +
  geom_bar(aes(y = common_name, x = Count, fill = transmission_short), stat = "identity", position = "dodge") +
  scale_fill_manual(values = colorblind_safe_cat, 
                    name = "Transmission direction") +
  theme_test() +
  ylab("Number of cases") +
  xlab("Species") +
  theme(axis.title.y = element_text(margin = margin(t = 0, r = 20, b = 0, l = 0)),
        axis.title.x = element_text(margin = margin(t = 20, r = 0, b = 0, l = 0)))