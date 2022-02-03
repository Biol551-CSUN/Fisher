####################################################
### This is my first script. I am learning how to import data.
### Created by: Lindsay Fisher
### Created on: 2022-02-03
#####################################

### load libraries ########
library(tidyverse)
library(here)

### Read in data ######
weightdata<-read_csv(here("Week_2","Data","weightdata.csv"))# weight data

### Data analysis ######
head(weightdata) #looks at top 6 lines
tail(weightdata) #looks at bottom 6 lines
view(weightdata) #opens new window to view whole data set
