
library(dembase)
library(dplyr)

set.seed(0)

census <- readRDS("out/census.rds")

reg_births <- readRDS("out/reg_births_age.rds") %>%
    expandIntervals(dimension = "age", width = 1) %>%
    addDimension(name = "sex", labels = c("Female", "Male"),
                 scale = c(100 / 205, 105 / 205)) %>%
    toInteger(force = TRUE)
    
reg_deaths <- readRDS("out/reg_deaths.rds")

migration <- readRDS("out/migration.rds")

arrivals <- migration %>%
    subarray(direction == "Arrivals") %>%
    expandIntervals(dimension = "age", breaks = 0:100)

departures <- migration %>%
    subarray(direction == "Departures") %>%
    expandIntervals(dimension = "age", breaks = 0:100)

initial <- census %>%
    subarray(time == 2001) + 100

account <- derivePopulation(initial = initial,
                            births = reg_births,
                            entries = list(immigration = arrivals),
                            exits = list(deaths = reg_deaths,
                                         emigration = departures))

saveRDS(account,
        file = "out/account.rds")
