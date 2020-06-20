
library(demest)
library(dplyr)

## Census + PES

census_counts <- readRDS("out/census.rds")

net_undercount <- readRDS("out/net_undercount.rds")

percent_undercount <- net_undercount %>%
    filter(variable == "percent") %>%
    dtabs(value ~ age + time) %>%
    Values()  %>%
    makeCompatible(census_counts)

mean <- (1 - percent_undercount / 100)

percent_error <- net_undercount %>%
    filter(variable == "error") %>%
    dtabs(value ~ age + time) %>%
    Values() %>%
    makeCompatible(census_counts)

sd <- ((percent_error / 100) * census_counts / 1.96) %>% 
    Values()

census <- Model(census ~ NormalFixed(mean = mean, sd = sd, useExpose = TRUE),
                series = "population")


## Registered births and deaths

reg_births_age <- Model(reg_births_age ~ PoissonBinomial(prob = 0.98),
                        series = "births")

reg_births_sex <- Model(reg_births_sex ~ PoissonBinomial(prob = 0.98),
                        series = "births")

reg_deaths <- Model(reg_deaths ~ Round3(),
                    series = "deaths")


## Arrivals and departures

arrivals <- Model(arrivals ~ PoissonBinomial(prob = 0.95),
                  series = "immigration")

departures <- Model(departures ~ PoissonBinomial(prob = 0.95),
                    series = "emigration")



## Save

data_models <- list(census = census,
                    reg_births_age = reg_births_age,
                    reg_births_sex = reg_births_sex,
                    reg_deaths = reg_deaths,
                    arrivals = arrivals,
                    departures = departures)

saveRDS(data_models,
        file = "out/data_models.rds")
