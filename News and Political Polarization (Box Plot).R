rm(list = ls())

setwd("C:/Users/cayde/OneDrive/Graduate Studies/Misc/TA/Lab 102/Data Sets")

library(ggplot2)
library(dplyr)

anes <- read.csv("anes_timeseries_2016.csv")

anes_polar <- subset(anes, select = c("attn_to_news", "feeling_rep_party", "feeling_dem_party")) %>%
  na.omit()

anes_polar$polarization <- abs(anes_polar$feeling_rep_party - anes_polar$feeling_dem_party)

ggplot(anes_polar, aes(x = attn_to_news, y = polarization)) +
  geom_boxplot() +
  xlab("Pay Attention to News") +
  ylab("Affective Polarization") +
  ggtitle("The News and Political Polarization")
