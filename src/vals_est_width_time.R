
library(demest)
library(dplyr)
library(tidyr)

vals_est_width_time <- fetch("calc/out/model_base.est",
                             where = c("account", "population")) %>%
    collapseDimension(margin = "time") %>%
    collapseIterations(prob = c(0.025, 0.975)) %>%
    as_tibble() %>%
    spread(key = quantile, value = count) %>%
    mutate(width = (`97.5%` - `2.5%`)) %>%
    select(time, width)

saveRDS(vals_est_width_time,
        file = "out/vals_est_width_time.rds")
