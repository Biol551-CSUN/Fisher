###This is another class practicing coding plots###
###Created by: Lindsay Fisher####
### Created on: 2022-02-15###

##Load Libries##
library(palmerpenguins)
library(tidyverse)
library(here)

#Load Data##
glimpse(penguins)
head(penguins)

filter(.data = penguins, #extracts rows
       year == "2008" | year== "2009",
       island != "Dream",
       species == "Adelie" & species == "Gentoo")
filter(.data = penguins,species == "Adelie" & species == "Gentoo")
data2<-mutate(.data = penguins,
              # body_mas_kg = body_mass_g/1000,
              #bill_length_depth = bill_length_mm/bill_depth_mm,
              #after_2008 = ifelse(year>2008, "After 2008","Before 2008",labels anything after 2008n
              flipper_length = flipper_length_mm + body_mass_g,
              big = ifelse(body_mass_g>4000, "big", "small"))

View(data2)

data3<-penguins %>% #use penguin dataframe
  #filter(sex=="female")%>% #select females
  #mutate(log_mass = log(body_mass_g)) %>% #calculae log biomass b
  #select(Species = species , island, sex, log_mass)#selects columns and renames, can also use rename function
  #summarise(mean_flipper = mean(flipper_length_mm, na.rm=TRUE),
  #min_flipper = min(flipper_length_mm, na.rm=TRUE))#calculates the mean of the dataframe
  #group_by(island,sex) %>% #calculating by each group
  #summarise(mean_flipper = mean(flipper_length_mm, na.rm=TRUE),
  #min_flipper = min(flipper_length_mm, na.rm=TRUE))
  drop_na(sex) #drops rows with NAs from all rows missing data on sex
ggplot(aes(x = sex, y = flipper_length_mm))+ #no longer need to pipe
  geom_boxplot()

View(data3)