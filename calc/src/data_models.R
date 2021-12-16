
library(demest)
library(dplyr)

## Census + PES

net_undercount <- readRDS("out/net_undercount.rds")

census_counts <- readRDS("out/census.rds")

percent_undercount <- net_undercount %>%
    filter(variable == "percent") %>%
    dtabs(value ~ age + time) %>%
    Values() 

mean <- (1 - percent_undercount / 100) %>%
    makeCompatible(census_counts)

percent_error <- net_undercount %>%
    filter(variable == "error") %>%
    dtabs(value ~ age + time) %>%
    Values()

sd_relative <- ((percent_error / 100) / 1.96) %>% 
    Values()

sd_abs <- sd_relative * census_counts

## multiply by 5 to take account of fact that
## coverage rates can vary within age groups
## and that the PES did not include all sources
## of uncertainty

sd <- Values(5 * sd_abs)

census <- Model(census ~ NormalFixed(mean = mean, sd = sd),
                series = "population")
                                     

## People aged 105+

oldest <- Model(oldest ~ PoissonBinomial(prob = 0.5),
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
                    oldest = oldest,
                    reg_births_age = reg_births_age,
                    reg_births_sex = reg_births_sex,
                    reg_deaths = reg_deaths,
                    arrivals = arrivals,
                    departures = departures)

saveRDS(data_models,
        file = "out/data_models.rds")
