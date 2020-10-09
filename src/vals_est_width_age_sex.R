
library(demest)
library(dplyr)
library(tidyr)

vals_est_width_age_sex <- fetch("calc/out/model_base.est",
                                where = c("account", "population")) %>%
    collapseIntervals(dimension = "age", breaks = 0:100) %>%
    collapseIterations(prob = c(0.025, 0.5, 0.975)) %>%
    as.data.frame(midpoints = "age") %>%
    pivot_wider(names_from = quantile, values_from = count) %>%
    mutate(width_abs = (`97.5%` - `2.5%`),
           width_rel = width_abs / `50%`) %>%
    select(age, sex, time, width_abs, width_rel)

saveRDS(vals_est_width_age_sex,
        file = "out/vals_est_width_age_sex.rds")

