
library(demest)
library(ggplot2)
library(dplyr)

vals_model_popn <- fetch("calc/out/model_base.est",
              where = c("account", "population")) %>%
    collapseIterations(prob = c(0.025, 0.25, 0.5, 0.75, 0.975)) %>%
    as.data.frame() %>%
    as_tibble()

saveRDS(vals_model_popn,
        file = "out/vals_model_popn.rds")
