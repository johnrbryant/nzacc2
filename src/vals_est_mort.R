
library(demest)
library(dplyr)
library(tidyr)

exposure <- fetch("calc/out/model_base.est",
                  where = c("account", "population")) %>%
    exposure(triangles = TRUE)

vals_est_mort <- fetch("calc/out/model_base.est",
                       where = c("systemModels", "deaths", "likelihood", "rate")) %>%
    collapseDimension(dimension = "triangle", weights = exposure) %>%
    collapseIntervals(dimension = "age", breaks = 0:100, weights = exposure) %>%
    collapseIterations(prob = c(0.025, 0.25, 0.75, 0.975), na.rm = TRUE) %>%
    as.data.frame(midpoints = "age") %>%
    as_tibble() %>%
    spread(key = quantile, value = value)

saveRDS(vals_est_mort,
        file = "out/vals_est_mort.rds")
