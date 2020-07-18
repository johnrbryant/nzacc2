
library(demest)
library(dplyr)
library(tidyr)

vals_est_width_age <- fetch("calc/out/model_base.est",
                             where = c("account", "population")) %>%
    collapseDimension(dimension = "sex") %>%
    collapseIntervals(dimension = "age", breaks = 0:100) %>%
    collapseIterations(prob = c(0.025, 0.975)) %>%
    as.data.frame(midpoints = "age") %>%
    as_tibble() %>%
    spread(key = quantile, value = count) %>%
    mutate(width = (`97.5%` - `2.5%`)) %>%
    select(age, time, width)

saveRDS(vals_est_width_age,
        file = "out/vals_est_width_age.rds")
