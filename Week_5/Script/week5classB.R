###This is a script for class, I will practice with time data###
###Created by: Lindsay Fisher####
### Created on: 2022-02-24###

##Load Libraries##
library(tidyverse)
library(here)
library(lubridate)

##Load Data##
CondData<-read_csv(here("Week_5", "Data", "CondData.csv")) %>% #calls in Data
  mutate(datetime = mdy_hms(depth)) %>% #makes new column name calles datetime, changes date/time format from column depth
  drop_na()#gets rid of NAs



