
library(demest)
library(dplyr)
library(tidyr)

vals_est_popn <- fetch("calc/out/model_base.est",
                        where = c("account", "population")) %>%
    collapseIterations(prob = c(0.025, 0.25, 0.5, 0.75, 0.975)) %>%
    as.data.frame(midpoints = "age") %>%
    as_tibble() %>%
    mutate(count = 1e-3 * count) %>%
    spread(key = quantile, value = count)

saveRDS(vals_est_popn,
        file = "out/vals_est_popn.rds")
