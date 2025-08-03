# load packages
library(tidyverse)
library(readxl)

# download from https://www150.statcan.gc.ca/n1/pub/34-25-0001/342500012025001-eng.htm

## load into R
PUMF2020 <- read_excel("2020/2020/Data - Données/PUMF_CCPI_IPEC_FMGD_2020.xlsx") 
PUMF2022 <- read_excel("2022/2022/Data/PUMF_CCPI_IPEC_FMGD_2022.xlsx")

## 2020 and 2022 subset
#keep roads where the condition assessment of arterial roads was very poor or very good
#remove cases where the municipal calss is NA
road2020 = subset(PUMF2020, PUMF2020$Cellid %in% c("C5F06102","C5F06502") &
                    PUMF2020$`Municipal class` != "N/A")

road2022 = subset(PUMF2022, PUMF2022$Cellid %in% c("C5F06102","C5F06502") &
                    PUMF2022$`Municipal class` != "N/A")


## add year variables
road2020$year = "2020"
road2022$year = "2022"

## give context to cell ID
road2020$road_condition = ifelse(road2020$Cellid == "C5F06102", "VeryPoor", "VeryGood")
road2022$road_condition = ifelse(road2022$Cellid == "C5F06102", "VeryPoor", "VeryGood")

## select cities to keep for analysis (use Canadian Census Division later to keep more places)
urban = c("CITY OF ABBOTSFORD", "CORPORATION OF THE DISTRICT OF WEST VANCOUVER", "CITY OF VANCOUVER", "CITY OF NORTH VANCOUVER")
rural = c("RESORT MUNICIPALITY OF WHISTLER", "DISTRICT OF HOPE")


## only keep subset of places
road2020 = subset(road2020, road2020$Name %in% c(urban, rural))
road2022 = subset(road2022, road2022$Name %in% c(urban, rural))

## save file
write.csv(road2020, "pump_road_2020.csv", row.names = F)
write.csv(road2022, "pump_road_2022.csv", row.names = F)
