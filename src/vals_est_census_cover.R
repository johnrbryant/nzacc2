
library(demest)
library(dplyr)
library(tidyr)

vals_est_census_cover <- fetchCoverage("calc/out/model_base.est", "census") %>%
    collapseIterations(prob = c(0.025, 0.25, 0.5, 0.75, 0.975)) %>%
    as.data.frame(midpoints = "age") %>%
    as_tibble() %>%
    spread(key = quantile, value = value)

saveRDS(vals_est_census_cover,
        file = "out/vals_est_census_cover.rds")
