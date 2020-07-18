
library(demest)
library(demlife)
library(dplyr)
library(tidyr)

vals_est_lifeexp <- fetch("calc/out/model_base.est",
                          where = c("systemModels", "deaths", "likelihood", "rate")) %>%
    collapseDimension(dimension = "triangle", weight = 1) %>%
    LifeTable() %>%
    lifeTableFun("ex") %>%
    subarray(age %in% c(0, 65)) %>%
    collapseIterations(prob = c(0.025, 0.25, 0.5, 0.75, 0.975)) %>%
    as.data.frame() %>%
    as_tibble() %>%
    mutate(age = paste("Age", age)) %>%
    spread(key = quantile, value = value)

saveRDS(vals_est_lifeexp,
        file = "out/vals_est_lifeexp.rds")
