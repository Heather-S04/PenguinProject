
plot_boxplot <- function(data, 
                         x_column,
                         y_column,
                         x_label,
                         y_label,
                         colour_mapping) {
  data <- data %>% 
    drop_na({{y_column}})
  flipper_boxplot <- ggplot(
    data = data, 
    aes(x = {{x_column}},
        y = {{y_column}},
        colour = {{x_column}})) + 
    geom_boxplot(
      width = 0.3,
      show.legend = FALSE) +
    geom_jitter(aes(colour = species),
                alpha = 0.3,
                show.legend = FALSE,
                position = position_jitter(
                  width = 0.2,
                  seed = 0))  +
    scale_colour_manual(values = colour_mapping)
    labs(x = x_label,
       y = y_label) +
    theme_bw()
  flipper_boxplot
}

species_colours <- c("Adelie" = "darkorange",
                     "Chinstrap" = "purple",
                     "Gentoo" = "cyan4")

plot_boxplot(penguins_clean, "species", "flipper_length_mm", "Penguin Species", "Flipper Length (mm)")
#look up working code afterwards 



