

library(dplyr)
library(dembase)

vals_data_regbirths_age <- readRDS("calc/out/reg_births_age.rds") %>%
    as.data.frame(midpoints = "age") %>%
    as_tibble() %>%
    mutate(count = 1e-3 * count)

saveRDS(vals_data_regbirths_age,
        file = "out/vals_data_regbirths_age.rds")
