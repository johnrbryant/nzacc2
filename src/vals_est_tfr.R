
library(demest)
library(dplyr)
library(tidyr)

vals_est_tfr <- fetch("calc/out/model_base.est",
                      where = c("systemModels", "births", "likelihood", "rate")) %>%
    tfr() %>%
    collapseIterations(prob = c(0.025, 0.25, 0.5, 0.75, 0.975)) %>%
    as.data.frame() %>%
    as_tibble() %>%
    spread(key = quantile, value = count)

saveRDS(vals_est_tfr,
        file = "out/vals_est_tfr.rds")
