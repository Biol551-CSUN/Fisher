###This is a script for lab, I will practice with time data###
###Created by: Lindsay Fisher####
### Created on: 2022-02-24###

##Load Libraries##
library(tidyverse)
library(here)
library(lubridate)
library(calecopal)
names(cal_palettes)

##Read in Data ##
CondData <- read_csv(here("Week_5","Data", "CondData.csv"))#reads in CondData frame
DepthData <- read_csv(here("Week_5", "Data", "DepthData.csv"))#reads in DapthDAta frame

##Data Analysis##
CondData_clean<-CondData %>% #assigns CondData a new name/frame
  mutate(datetime = mdy_hms(depth)) %>% #makes a new column called datetime with correct time format
  drop_na() %>% #gets rid of any NA's in this dataframe
  mutate(datetime = round_date(datetime, "10 seconds")) %>% #rounds the dates in the column datetime to the nearest 10 seconds
  select(TempInSitu, datetime, SalinityInSitu_1pCal)#selects for these three columns, gets rid of old date column

DepthData_clean<-DepthData %>% #assigns DepthData to a new name/frame
  mutate(datetime = ymd_hms(date)) %>% #creates the column datetime, to have in common with the above dataframe
  drop_na() %>% #gets rid of all NA's in the frame
  mutate(datetime = round_date(datetime, "10 seconds")) %>% #rounds the datetime column to the nearest 10 secs
  select(AbsPressure, Depth, datetime)#selects for these thee column names

CondData_joined<-inner_join(CondData_clean, DepthData_clean, by = "datetime") %>% #inner joins the frames for Cond and Depth by datetime, keeps all columns selected for
  mutate(hours = hour(datetime)) %>% #extracts the hours from datetime
  mutate(minutes = minute(datetime)) %>% #extracts the minutes from datetime
  unite(col = "Hours_Mins", #unites them into the column called "Hours_Mins"
        c(hours, minute),#creates vector that separates hours and minutes in this column
        sep = ":",#separates by :
        remove = TRUE)#reoves the old column data

Summary<-CondData_joined %>% #creates new combined dataframe called summary
  group_by(Hours_Mins) %>% #group by selects column to analyze data in
  summarise_at(c("TempInSitu", "datetime", "SalinityInSitu_1pCal", "Depth"), mean) #takes the mean of all of these columns into hours_Mins
  
  Summary %>% #calls to Summary dataframe
  ggplot(aes(x = SalinityInSitu_1pCal,#creates new ggplot with the data, X = salinity column
             y = Depth,#creates the y axis as depth
             color = Depth))+ #assigns color by depth on the y axis
    geom_point()+ #creates plot where data is modeled with individual points
    theme_dark()+ #adds datk background to the plot
    ggtitle("Salinity by Depth")+ #assigns title to the plot 
    theme(axis.title = element_text(size = 15))+ #sets the size of the title
    ggsave(here("Week_5","Output","SalinityvsDepth.png"))#saves plot to output s a .png
    
    
 
  

