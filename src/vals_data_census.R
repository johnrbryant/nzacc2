

library(dplyr)
library(dembase)

vals_data_census <- readRDS("calc/out/census.rds") %>%
    as.data.frame(midpoints = "age") %>%
    as_tibble() %>%
    mutate(count = 1e-3 * count)

saveRDS(vals_data_census,
        file = "out/vals_data_census.rds")
