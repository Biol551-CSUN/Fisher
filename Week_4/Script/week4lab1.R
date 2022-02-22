###This is a script for lab, I will practice filtering data and creating ggplots###
###Created by: Lindsay Fisher####
### Created on: 2022-02-15###

##Load Libraries##
library(palmerpenguins)
library(tidyverse)
library(here)
library(calecopal)
names(cal_palettes)

##Load Data##
glimpse(penguins)

data1<- penguins %>% #pipe allows to add on layers
  group_by(species,
           island,
           sex) %>% #separates each group by category
  summarise(mean_mass = mean(body_mass_g, na.rm=TRUE), #calculates the mean of body mass
            min_mass = min(body_mass_g, na.rm=TRUE),
            variance_mass = var(body_mass_g, na.rm=TRUE)) %>% #calculates the variance of body mass
  drop_na(sex) #gets rid of N/A values under sex

View(data1) #pulls up data1 table

penguinlogmass<- penguins %>% #calling to penguins dataset
  filter(sex=="female") %>% #filtering out males from dataset
  mutate(log_mass = log(body_mass_g)) %>% #sets rows, calculates the log of body mass
  select(Species = species,
         island,
         sex,
         log_mass) %>% #selects columns for species, island, sex and log of body mass
  ggplot(aes(x = sex,
             y = log_mass,
             fill = Species))+ #sets ggplot x and y axis
  geom_boxplot()+ #cretes boxplot for data in ggplot
  labs(x = "Sex",
       y = "Log_Mass")+ #labels x and y axes
  scale_fill_manual(values = cal_palette("collinsia"))+ #manually changes plot color to specific color palette
  ggtitle("Log mass of female penguins")+ #manually changes colors to pallete from beyonce library
  theme_classic()+#changes the theme to have no grid or grey
  theme(axis.title = element_text(size = 15))+ #changes title size
  ggsave(here("Week_4","output","lab_penguinmass.png")) #saves plot to output folder
penguinlogmass