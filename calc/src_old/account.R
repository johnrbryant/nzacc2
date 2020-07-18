
library(dembase)
library(dplyr)
library(magrittr)

set.seed(0)

census <- readRDS("out/census.rds")

reg_births <- readRDS("out/reg_births_age.rds") 
    
reg_deaths <- readRDS("out/reg_deaths.rds")

migration <- readRDS("out/migration.rds")


initial <- census %>%
    subarray(time == 2001) %>%
    multiply_by(1.05) %>%
    add(200) %>%
    toInteger(force = TRUE) %>%
    expandIntervals(dimension = "age", breaks = 0:105)

births <- (1.02 * reg_births) %>%
    toInteger(force = TRUE) %>%
    expandIntervals(dimension = "age", width = 1) %>%
    addDimension(name = "sex", labels = c("Female", "Male"),
                 scale = c(100 / 205, 105 / 205)) %>%
    toInteger(force = TRUE)

deaths <- reg_deaths %>%
    multiply_by(0.98) %>%
    toInteger(force = TRUE) %>%
    expandIntervals(dimension = "age", breaks = 0:105)

immigration <- migration %>%
    subarray(direction == "Arrivals") %>%
    multiply_by(1.02) %>%
    toInteger(force = TRUE) %>%
    expandIntervals(dimension = "age", breaks = 0:105)

emigration <- migration %>%
    subarray(direction == "Departures") %>%
    multiply_by(0.98) %>%
    toInteger(force = TRUE) %>%
    expandIntervals(dimension = "age", breaks = 0:105)


account <- derivePopulation(initial = initial,
                            births = births,
                            entries = list(immigration = immigration),
                            exits = list(deaths = deaths,
                                         emigration = emigration),
                            adjust = TRUE)

stopifnot(all(population(account) >= census))

saveRDS(account,
        file = "out/account.rds")
