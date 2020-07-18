

library(dplyr)
library(dembase)

vals_data_regdeaths <- readRDS("calc/out/reg_deaths.rds") %>%
    as.data.frame(midpoints = "age") %>%
    as_tibble() %>%
    mutate(count = 1e-3 * count)

saveRDS(vals_data_regdeaths,
        file = "out/vals_data_regdeaths.rds")
