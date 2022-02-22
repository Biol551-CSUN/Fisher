###This is a script for class, I will practice with a new dataset###
###Created by: Lindsay Fisher####
### Created on: 2022-02-17###

##Load Libraries##
library(tidyverse)
library(here)

##Load Data##
ChemData<-read_csv(here("Week_4", "Data","chemicaldata_maunalua.csv"))#brings in dataset from folder
View(ChemData)
glimpse(ChemData)


ChemData_clean<-ChemData %>% #creates new set of clean data with no NA
  filter(complete.cases(.)) %>% #filters out everything that is not a complete case
  separate(col = Tide_time, #choose the tide time col
           into = c("Tide","Time"),# separate it into two columns Tide and Time
           sep = "_",#separate by _
           remove = FALSE) %>% #keep the original tide_time column
  unite(col = "Site_Zone",#the name of the new column
        c(Site,Zone), #the columns to unite
        sep = ".", #puts a . in the middle
        remove = FALSE) #keeps original data

ChemData_long<-ChemData_clean %>%
  pivot_longer(cols = Temp_in:percent_sgd,#the cols you want to pivot, This says select the temp to percent SGD cols
               names_to = "Variables", #the names of the new cols, with all the column names
               values_to = "Values")#names of the new column with all the values
ChemData_long %>%
  group_by(Variables, Site, Zone, Tide) %>% #group by everything we want
  summarise(Param_means = mean(Values, na.rm = TRUE),#get mean
            Param_vars = var(Values, na.rm = TRUE),#get variance
            Param_sd = sd(Values, na.rm = TRUE))#get Standard dev
ChemData_long %>%
  ggplot(aes(x = Site, y = Values))+
  geom_boxplot()+
  facet_wrap(~Variables, scales = "free")


ChemData_wide<-ChemData_long %>%
  pivot_wider(names_from = Variables, # column with the names for the new columns
              values_from = Values) # column with the values
ChemData_clean<-ChemData %>%
  pivot_longer(cols = Temp_in:percent_sgd, # the cols you want to pivot. This says select the temp to percent SGD cols
               names_to = "Variables", # the names of the new cols with all the column names
               values_to = "Values") %>%  # names of the new column with all the values
  group_by(Variables, Site, Time) %>%
  summarise(mean_vals = mean(Values, na.rm = TRUE)) %>%
  pivot_wider(names_from = Variables,
              values_from = mean_vals) %>%  # notice it is now mean_vals as the col name
  
  write.csv(here("Week_4","Output","summary.csv"))  # export as a csv to the right folder