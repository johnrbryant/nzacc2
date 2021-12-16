
library(dplyr)
library(dembase)

vals_data_erp <- readRDS("calc/out/erp.rds") %>%
    as.data.frame(midpoints = "age") %>%
    as_tibble() %>%
    mutate(count = 1e-3 * count)

saveRDS(vals_data_erp,
        file = "out/vals_data_erp.rds")
