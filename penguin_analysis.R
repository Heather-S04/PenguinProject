#load libraries
library(tidyverse)
library(palmerpenguins)
library(janitor)
library(here)

#here will tell you where we are
here()

#show first 6 rows
head(penguins_raw)

#show column names
colnames(penguins_raw)
#issues with white spaces, brackets, capitalization all over the place, clutter
#data cleaning should be done in the script so you can keep track of the changes made

#write data to csv using here
write.csv(penguins_raw, here("data", "penguins_raw.csv"))

#load raw data again after issues
penguins_raw <- read.csv(here("data", "penguins_raw.csv"))
colnames(penguins_raw)

#using piping to remove comments and delta columns
penguins_clean <- penguins_raw %>%
  select(-Comments)%>%
  select(-starts_with("Delta")) %>%
  clean_names()

colnames(penguins_clean)
#clean_names got rid of capital letters, spaces, slashes etc etc using janitor packages

#create a new function
cleaning_penguin_columns <- function(raw_data){
  raw_data %>%
    clean_names() %>%
    remove_empty(c("rows", "cols")) %>%
    select(-starts_with("delta")) %>%
    select(-comments)
}

#clean all the names up first so that all of the capital letters are gone first
#nothing will happen because all we've done is define a function

#loading the raw data again
penguins_raw <- read.csv(here("data", "penguins_raw.csv"))

#check the columns name
colnames(penguins_raw)

#running the function
penguins_clean <- cleaning_penguin_columns(penguins_raw)

#check the columns
colnames(penguins_clean)

#write the clean data to a csv using here
write.csv(penguins_clean, here("data", "penguins_clean.csv"))


#---------------
#loading libraries
library(tidyverse)
library(palmerpenguins)
library(janitor)
library(here)
#loading our function file
source(here("functions", "cleaning.R"))
#load the raw data
penguins_raw <- read.csv(here("data", "penguins_raw.csv"))
#making a function of all the other 


#save the clean data

#check the output