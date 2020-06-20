
library(demest)
library(dplyr)
library(tidyr)

vals_width_popn <- fetch("calc/out/model_base.est",
                         where = c("account", "population")) %>%
    collapseIterations(prob = c(0.025, 0.5, 0.975)) %>%
    as.data.frame(midpoints = "age") %>%
    as_tibble() %>%
    spread(key = quantile, value = count) %>%
    mutate(width = (`97.5%` - `2.5%`)) %>%
    select(age, sex, time, width)

saveRDS(vals_width_popn,
        file = "out/vals_width_popn.rds")
