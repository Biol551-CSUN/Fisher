###This is a script for class, I will practice with a new joins###
###Created by: Lindsay Fisher####
### Created on: 2022-02-22###

##Load Libraries##
library(tidyverse)
library(here)
library(wesanderson)

##Load Data##
#Environmantal Data from each site
EnviroData<-read_csv(here("Week_5", "Data", "site.characteristics.data.csv"))
#Thermal performance data
TPCData<-read_csv(here("Week_5", "Data", "Topt_data.csv"))

glimpse(EnviroData)
glimpse(TPCData)

EnviroData_wide<-EnviroData %>% 
  pivot_wider(names_from = parameter.measured,#pivot the data wider
              values_from = values) %>% 
  arrange(site.letter)#arranges by the column
FullData_left<-left_join(TPCData, EnviroData_wide) %>% ## Joining, by = "site.letter"
  relocate(where(is.numeric), .after = where(is.character)) %>%  # relocate all the numeric data after the character data
  pivot_longer(cols = E:substrate.cover,
               names_to = "Variables",
               values_to = "Values") %>%
  group_by(Variables, Values, fragment.ID, name) %>% 
  summarise(Param_means = mean(Values, na.rm=TRUE),
            Param_vars = var(Values, na.rm=TRUE))

#sum<-FullData_left
#group_by(site.letter)
#summarise_if(is.numeric, list(mean = mean, var = var), na.rm=TRUE)
#or
#summarise_at(vars(E:substrate.cover), list(mean = mean, var = var)
  
T1<-tibble(Site.ID = c("A", "B", "C","D"),
           Temperature = c(14.2, 16.5, 17.3, 15.4))
T1

T2<-tibble(Site.ID = c("A", "B", "D","E"),
           pH = c(7, 14, 12, 3))
T2

#right_join
#left_join
#inner_join(T1,T2)# flipping x and y keeps right data that doesnt match instead of left
#full_join
#semi_join
#anti_join



FullData_left %>% 
  ggplot(aes(x = name,
             y = Values,
             fill = name))+
  geom_bar(stat = "identity")+
  facet_wrap(~Variables, scales = "free")+
  theme_bw()+
  ggtitle("Thermal Data")+
  theme(axis.title = element_text(size = 10),
        axis.title.y = element_blank())+
  scale_fill_manual(values = wes_palette("IsleofDogs1"))



  

