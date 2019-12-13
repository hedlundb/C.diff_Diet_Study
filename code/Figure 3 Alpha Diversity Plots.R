# This script will produce alpha diversity plots represented in Figure 3 and Supplementary Figure S1.
# Activate the required R libraries for the analysis
library("phyloseq")
library("grid")
library("RColorBrewer")
library("vegan")
library("ggplot2")
library("dplyr")
library("data.table")
library("knitr")
library("tidyverse")
library("broom")



# The map file contains precalculated alpha diversity indices.
# reordering the diet
map$Diet = factor((map$Diet), levels = c("Standard(-CDI)","Standard","HighCarb","HighFat","HighProtein"))
map$Day = as.character(map$Day)


# Observed_otus diversity plot
obs <- ggplot(map, aes(x=Day, y=Observed_otus,fill=Diet)) + geom_boxplot() + facet_grid('Diet~.') +  scale_x_discrete(limits=c("0","3","10","13","17","18","19","20","21","22","30","47")) 

obs + theme(axis.text.x = element_text(angle = 90, hjust = 1, color='black',face = "bold"), axis.text.y = element_text(hjust = 1, color='black',face = 'bold')) +
  scale_fill_manual(values=c("#b24b01","#6e01b2", "#00B0F0","#9BBB59","#FF0000"))


# Shannon diversity plot
shannon <- ggplot(map, aes(x=Day, y=Shannon,fill=Diet)) + geom_boxplot() + facet_grid('Diet~.') +  scale_x_discrete(limits=c("0","3","10","13","17","18","19","20","21","22","30","47")) 

shannon + theme(axis.text.x = element_text(angle = 90, hjust = 1, color='black',face = "bold"), axis.text.y = element_text(hjust = 1, color='black',face = 'bold')) +
  scale_fill_manual(values=c("#b24b01","#6e01b2", "#00B0F0","#9BBB59","#FF0000"))


# Simpson diversity plot
simpson <- ggplot(map, aes(x=Day, y=Simpson,fill=Diet)) + geom_boxplot() + facet_grid('Diet~.') +  scale_x_discrete(limits=c("0","3","10","13","17","18","19","20","21","22","30","47")) 

simpson + theme(axis.text.x = element_text(angle = 90, hjust = 1, color='black',face = "bold"), axis.text.y = element_text(hjust = 1, color='black',face = 'bold')) +
  scale_fill_manual(values=c("#b24b01","#6e01b2", "#00B0F0","#9BBB59","#FF0000"))


