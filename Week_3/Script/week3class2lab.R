##Today we are going to plot penguin data differently in lab###
## Created by: Lindsay Fisher ##
## Updated on: 2022-02-10 ##

##Load Libraries##
library(palmerpenguins)
library(tidyverse)
library(here)
library(beyonce)

##Load data##
glimpse(penguins)
penguins$year

ggplot(data=penguins,
      mapping = aes(x = as_factor(year),
                    y = body_mass_g,
                    group = species,
                    fill = species,))+
geom_boxplot()+
  labs(x ="Years",
       y = "Body Mass (g)")+
  #scale_color_viridis_d()
  scale_fill_manual(values = beyonce_palette(41))+
  ggtitle("Changes in body mass (g)")+
  theme_classic()+
  scale_y_continuous(limits = c(0,6000))+
ggsave(here("Week_3","output","lab_penguin.png"))

