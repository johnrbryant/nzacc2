
library(dembase)
library(dplyr)

vals_data_migration <- readRDS("calc/out/migration.rds") %>%
    as.data.frame(midpoints = "age") %>%
    as_tibble() %>%
    mutate(count = 1e-3 * count)

saveRDS(vals_data_migration,
        file = "out/vals_data_migration.rds")

