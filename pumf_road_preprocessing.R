# load packages
library(tidyverse)
library(readxl)
library(stringr)
library(tidyr)

## set wd

# download from https://www150.statcan.gc.ca/n1/pub/34-25-0001/342500012025001-eng.htm
## load into R
road2020 <- read_excel("2020/2020/Data - Données/PUMF_CCPI_IPEC_FMGD_2020.xlsx") 
road2022 <- read_excel("2022/2022/Data/PUMF_CCPI_IPEC_FMGD_2022.xlsx")

## only keep local roads condition assemsment (from data dictionary)
local = c("C5F06104", "C5F06204", "C5F06304", "C5F06404", "C5F06504", "C5F06604")

road2020 = subset(road2020, road2020$Cellid %in% c(local))
road2022 = subset(road2022, road2022$Cellid %in% c(local))

## add year variables
road2020$year = "2020"
road2022$year = "2022"

## extract firt digist from cd
road2020$province = str_sub(road2020$CD, start=1, end=2)
road2022$province = str_sub(road2022$CD, start=1, end=2)

## edit province names
road2020$province_name = case_when(
  road2020$province == 10 ~ "Newfoundland and Labrador",
  road2020$province == 11 ~ "Prince Edward Island",
  road2020$province == 12 ~ "Nova Scotia",
  road2020$province == 13 ~ "New Brunswick",
  road2020$province == 24 ~ "Quebec",
  road2020$province == 35 ~ "Ontario",
  road2020$province == 46 ~ "Manitoba",
  road2020$province == 47 ~ "Saskatchewan",
  road2020$province == 48 ~ "Alberta",
  road2020$province == 59 ~ "British Columbia",
  road2020$province == 60 ~ "Yukon",
  road2020$province == 61 ~ "Northwest Territories",
  road2020$province == 62 ~ "Nunavut"
  )

road2022$province_name = case_when(
  road2022$province == 10 ~ "Newfoundland and Labrador",
  road2022$province == 11 ~ "Prince Edward Island",
  road2022$province == 12 ~ "Nova Scotia",
  road2022$province == 13 ~ "New Brunswick",
  road2022$province == 24 ~ "Quebec",
  road2022$province == 35 ~ "Ontario",
  road2022$province == 46 ~ "Manitoba",
  road2022$province == 47 ~ "Saskatchewan",
  road2022$province == 48 ~ "Alberta",
  road2022$province == 59 ~ "British Columbia",
  road2022$province == 60 ~ "Yukon",
  road2022$province == 61 ~ "Northwest Territories",
  road2022$province == 62 ~ "Nunavut"
)

## give context to cell ID from data dictionary
road2020$road_condition = case_when(
  road2020$Cellid == "C5F06104" ~ "very poor",
  road2020$Cellid == "C5F06204" ~ "poor",
  road2020$Cellid == "C5F06304" ~ "fair",
  road2020$Cellid == "C5F06404" ~ "good",
  road2020$Cellid == "C5F06504" ~ "very good",
  road2020$Cellid == "C5F06604" ~ "do not know"
)

road2022$road_condition = case_when(
  road2022$Cellid == "C5F06104" ~ "very poor",
  road2022$Cellid == "C5F06204" ~ "poor",
  road2022$Cellid == "C5F06304" ~ "fair",
  road2022$Cellid == "C5F06404" ~ "good",
  road2022$Cellid == "C5F06504" ~ "very good",
  road2022$Cellid == "C5F06604" ~ "do not know"
)


## save file
write.csv(road2020, "pumf_road_2020.csv", row.names = F)
write.csv(road2022, "pumf_road_2022.csv", row.names = F)
