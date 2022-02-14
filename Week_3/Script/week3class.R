##################################
### This is my first script working with ggplot
### Created by: Lindsay Fisher
### Created on: 2022-02-08 
##################################

### install packages###
### (palmerpenguins) is a package with pre-existing penguin data to make a plot

## load libraries ##
library(palmerpenguins)#calling palmerpenguins from the tidyverse
library(tidyverse) #needed to run the glimpse function, have to re-run every time

### Data analysis  ####
glimpse(penguins) #pulls up penguin data from palmerpenguins package

### Starting with the penguin dataframe ###
ggplot(data=penguins)

## Penguin dataframe ##
ggplot(data=penguins,
       mapping = aes(x = bill_depth_mm,# citing a column name
                     y = bill_length_mm, 
                     color = species,
                     shape = species,
                     size = body_mass_g,
                     alpha = flipper_length_mm))+ # differentiates each species by color on plot, "+" sign creates layers
  
geom_point()+ labs(title = "Bill depth and length", #labels the plot
                  subtitle = "Dimensions of the penguins",
                  x = "Bill depth (mm)", y = "Bill length (mm)", #labels axes
                  color = "Species",
                  shape = "Species",
                  caption = "Source: Palmer Station LTER / palmerpenguins package")+#adds a caption to the plot

scale_color_viridis_d()+ #color blind friendly plot colors
  
facet_grid(species~sex)+#separates species by sex, 2D grid with rows~columns
##facet_wrap is another option that separates the data by columns, can specify number of columns
guides(color = FALSE)#gets rid of color from the legend to make it simple


