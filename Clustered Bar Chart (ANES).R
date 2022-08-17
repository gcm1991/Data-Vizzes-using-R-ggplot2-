rm(list = ls())
setwd("C:/Users/cayde/OneDrive/Graduate Studies/Misc/TA/Lab 102/Data Sets")

library(dplyr)
library(ggplot2)
library(tidyr)

anes <- read.csv("anes_timeseries_2016.csv") 

unique(anes$party_of_registration) #Check to see how many political parties are in the data set

feelings<- select(anes, c("party_of_registration", contains("feeling"))) %>% #creates a subset of the data which only includes party of registration and feelings variables
              filter(party_of_registration != "4. Other") %>% #eliminates the non-major parties
              na.omit() #eliminates NAs

feelings_party <- feelings %>% #Simply creates an aggregated version of the previously subsetted data
                    group_by(party_of_registration) %>%
                    summarise_at(vars(names(feelings)[2:7]), mean) #finding the mean feelings for each group

feelings_party_long <- gather(feelings_party, "group", "feelings", names(feelings_party[2:7])) #reorganizing the aggregated dataset to a long version for graphing


ggplot(feelings_party_long, aes(group, feelings, fill = party_of_registration)) + #basic graph
  geom_bar(position = "dodge", stat = "identity")



graph_labels <- c("feeling_bill_clinton" =  "Bill Clinton", #Creates labels for the graph
                  "feeling_dem_cand" = "Democratic Candidate",
                  "feeling_dem_party" = "Democratic Party",
                  "feeling_prev_pres" = "Barack Obama",
                  "feeling_rep_cand" = "Republican Candidate",
                  "feeling_rep_party" = "Republican Party")

ggplot(feelings_party_long, aes(group, feelings, fill = party_of_registration)) + #final graph
  geom_bar(position = "dodge", stat = "identity") + 
  scale_fill_manual(labels = c("Democrat", "Republican", "Independent"), values = c("blue", "red", "gray")) +
  guides(fill = guide_legend("Party of Registration")) +
  scale_x_discrete(name = "", labels = graph_labels) +
  ylab("Mean Feeling Score (0-100)") +
  ggtitle("Feeling Thermometers for Political Figures/Candidates")


