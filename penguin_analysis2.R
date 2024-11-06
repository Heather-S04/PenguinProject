#loading libraries
library(tidyverse)
library(palmerpenguins)
library(janitor)
library(here)

#loading our function file
source(here("functions", "cleaning.R"))

#load the raw data 
penguins_raw <- read.csv(here("data", "penguins_raw.csv"))

#using our functions from the functions script
cleaning_penguin_columns <- function(raw_data){
  print("Cleaned names, removed comments, removed empty rows and cols, removed delta")
  raw_data %>%
    clean_names() %>%
    shorten_species() %>%
    remove_empty(c("rows", "cols")) %>%
    select(-comments) %>%
    select(-starts_with("delta")) 
}

#looking at the changes
colnames(penguins_raw)
penguins_clean <- cleaning_penguin_columns(penguins_raw)
colnames(penguins_clean)

#initialise renv (do this in the console)
install.packages("renv")
renv::init()
renv::diagnostics()
renv::snapshot()
rev::install("table1")

#this will install everything they need to install
renv::restore()
#uses the renv folder to install all the right libraries

#make a box plot to look a flippers
species_colours <- c("Adelie" = "darkorange",
                     "Chinstrap" = "purple",
                     "Gentoo" = "cyan4")


flipper_boxplot <- ggplot(
  data = penguins_flippers, 
  aes(x = species,
      y = flipper_length_mm)) + 
  geom_boxplot(
    aes(colour = species),
    width = 0.3,
    show.legend = FALSE) +
  geom_jitter(aes(colour = species),
              alpha = 0.3,
              show.legend = FALSE,
              position = position_jitter(
                width = 0.2,
                seed = 0))  +
  scale_colour_manual(values = species_colours)
  labs(x = "Penguin species",
        y = "Flipper length (mm)") +
  theme_bw()
  
flipper_boxplot

#error message because there are NAs
#should only remove missing values in columns that we are working in because might delete big parts of the other data
#then edited to change penguins_clean to penguins_flippers

#subsetting the coloumns and getting rid of nas using piping to not overwrite
penguins_flippers <- penguins_clean %>%
  select(species, flipper_length_mm) %>%
  drop_na()



