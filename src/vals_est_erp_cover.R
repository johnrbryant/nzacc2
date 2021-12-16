
library(demest)
library(dplyr)
library(tidyr)


erp <- readRDS("calc/out/erp.rds")

est <- fetch("calc/out/model_base.est", c("account", "population"))

vals_est_erp_cover <- (erp / est) %>%
    collapseIterations(prob = c(0.025, 0.25, 0.5, 0.75, 0.975)) %>%
    as.data.frame(midpoints = "age") %>%
    as_tibble() %>%
    pivot_wider(names_from = quantile, values_from = value)

saveRDS(vals_est_erp_cover,
        file = "out/vals_est_erp_cover.rds")
