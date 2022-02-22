###This is a script for lab, I will practice with a new dataset###
###Created by: Lindsay Fisher####
### Created on: 2022-02-17###

##Load Libraries##
library(tidyverse)
library(here)
library(calecopal)
names(cal_palettes)

##Load Data##
ChemData<-read_csv(here("Week_4", "Data","chemicaldata_maunalua.csv"))
View(ChemData)
glimpse(ChemData)

ChemData_new <-ChemData %>% #creates new set of clean data with no NA
  filter(complete.cases(.),#filters out everything that is not a complete case
         Season == "SPRING", #filters out all other seasons except spring
         Site == "W") %>% #filters out all other sites except W
  separate(col = Tide_time,#separates the existing column Tide_time
           into = c("Tide","Time"),#separates the column into two columns
           sep = "_")#separates by _
ChemData_better <-ChemData_new %>% #creates new set of data
  pivot_longer(cols = Temp_in:percent_sgd,#the cols you want to pivot, This says select the temp to percent SGD cols
               names_to = "Variables",#the names of the new cols, with all the column names
               values_to = "Values") %>% #names of the new column with all the values
  group_by(Variables, Values, Site, Time) %>% #setting up groups that we want, from groups we don't want
  summarise(Param_means = mean(Values, na.rm=TRUE),#gets mean
            Param_sd = sd(Values, na.rm=TRUE), #gets standard dev
            Param_vars = var(Values, na.rm=TRUE))#gets variance
ChemData_better %>% #start new set for ggplot, should not be under same section as data
  ggplot(aes(x = Time,#sets x axis
             y = Values,#sets y axis
             fill = Time))+ #fills the figures differently by time
  geom_bar(stat = "identity")+ #makes a bar graph, need the stat=identity because default stat counts values and changes the data
  facet_wrap(~Variables, scales = "free")+ #separates the plot into smaller sections by variable, 'free' makes each have its own value scale
  theme_classic()+ #removes grey and grid from plot
  ggtitle("Spring Water Chemical Data for Site W")+ #sets title
  theme(axis.title = element_text(size = 13), #sets title size
        axis.title.x = element_blank(), #removes overall x axis title for clarity since there are many small plots
        axis.title.y = element_blank())+ #removes overall y axis title
  scale_fill_manual(values = cal_palette("tidepool"))+ #changes color to the tidepool color palette
  ggsave(here("Week_4", "output", "lab_waterchemdata.png"))#saves the plot as a png to the output file

write.csv(here ("Week_4", "Output", "labwaterdata.csv"))#writes a .csv file to the output folder




