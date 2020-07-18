

library(dplyr)
library(dembase)

vals_data_regbirths_sex <- readRDS("calc/out/reg_births_sex.rds") %>%
    as.data.frame() %>%
    as_tibble() %>%
    mutate(count = 1e-3 * count)

saveRDS(vals_data_regbirths_sex,
        file = "out/vals_data_regbirths_sex.rds")
