
library(dembase)
library(dplyr)

census <- readRDS("out/census.rds")

reg_births_age <- readRDS("out/reg_births_age.rds")

reg_births_sex <- readRDS("out/reg_births_sex.rds")

reg_deaths <- readRDS("out/reg_deaths.rds")

migration <- readRDS("out/migration.rds")

arrivals <- migration %>%
    subarray(direction == "Arrivals")

departures <- migration %>%
    subarray(direction == "Departures")

oldest <- readRDS("out/oldest.rds")


datasets <- list(census = census,
                 reg_births_age = reg_births_age,
                 reg_births_sex = reg_births_sex,
                 reg_deaths = reg_deaths,
                 arrivals = arrivals,
                 departures = departures,
                 oldest = oldest)

saveRDS(datasets,
        file = "out/datasets.rds")
