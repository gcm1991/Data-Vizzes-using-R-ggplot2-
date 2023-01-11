rm(list = ls())
setwd("C:/Users/cayde/OneDrive/Graduate Studies/Misc/TA/Lab 102/Data Sets")

library(ggplot2)

anes <- read.csv("anes_timeseries_2016.csv") 

###################
#Scatterplot
###################

anes_feel <- subset(anes, select = c('feeling_dem_party', 'feeling_dem_cand', 
                                     'party_of_registration'))

anes_feel <- na.omit(anes_feel)

ggplot(data = anes_feel, mapping = aes(x = feeling_dem_party, y = feeling_dem_cand)) + 
  geom_point(aes(color = party_of_registration)) +
  scale_color_manual(values = c("blue", "red", "purple", "gray"), 
                     name = "Party of Registration", 
                     labels = c("Democratic Party", "Republican Party", "None or Independent", "Other")) +
  xlab("Feeling towards Democratic Party") +
  ylab("Feeling towards Republican Party") 


