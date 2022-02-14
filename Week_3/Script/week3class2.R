##Today we are going to plot penguin data###
## Created by: Lindsay Fisher ##
## Updated on: 2022-02-10 ##

##Load Libraries##
library(palmerpenguins)
library(tidyverse)
library(here)
library(beyonce)

##Load data##
glimpse(penguins)

plot1<-ggplot(data=penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species,
                     color = species))+
       geom_point()+
       geom_smooth()+
  labs(x = "Bill depth (mm)",
       y = "Bill length (mm)")+
####scale_color_viridis_d()+
  #scale_x_continuous(limits = c(0,20)) + # set x limits from 0 to 20
  #scale_y_continuous(limits = c(0,50))
  
##scale_x_continuous(breaks = c(14, 17, 21),
                    #labels = c("low", "medium", 
  
scale_color_manual(values = beyonce_palette(41))+
  #coord_flip()#flips x and y axes
  #coord_fixed()
#coord_polar("x")#spiral

#Theme_dark
#Theme_mininal
#Theme_classic
#Theme_void
theme_bw()+#make background of lines black and white
#can use library(ggthemes) to make it look like different plots 
  theme(axis.title = element_text(size = 20,
                                  color = "blue"),
        panel.background = element_rect(fill = "linen"))
ggsave(here("Week_3","output","penguin.png"),
       width = 7, height = 5) # in inches
