
library(dembase)
library(dplyr)
library(tidyr)

datasets <- readRDS("calc/out/datasets.rds")

exposure <- datasets$census %>%
    subarray(time %in% c(2001, 2013)) %>%
    as.data.frame(midpoints = "age") %>%
    mutate(time = time + 1) %>%
    rename(exposure = count)

deaths <- datasets$reg_deaths %>%
    subarray(time %in% c(2002, 2014)) %>%
    as.data.frame(midpoints = "age") %>%
    mutate(time = as.numeric(time)) %>%
    rename(deaths = count)

vals_direct_mort <- inner_join(exposure, deaths, by = c("time", "age", "sex")) %>%
    mutate(rate = deaths / exposure)

saveRDS(vals_direct_mort,
        file = "out/vals_direct_mort.rds")
