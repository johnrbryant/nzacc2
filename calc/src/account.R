
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
    subarray(time == 2001)

initial <- toInteger(initial + 100, force = TRUE)
births <- toInteger(1.02 * reg_births, force = TRUE)
immigration <- toInteger(1.02 * arrivals, force = TRUE)
deaths <- toInteger(reg_deaths, force = TRUE)
emigration <- toInteger(0.98 * departures, force = TRUE)

account <- derivePopulation(initial = initial,
                            births = births,
                            entries = list(immigration = immigration),
                            exits = list(deaths = deaths,
                                         emigration = emigration))


stopifnot(all(population(account) >= census))

saveRDS(account,
        file = "out/account.rds")
