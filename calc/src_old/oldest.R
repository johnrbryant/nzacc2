
library(dembase)
library(dplyr)
library(magrittr)


n_living <- 0L

vals_time <- readRDS("out/reg_deaths.rds") %>%
    dimnames() %>%
    extract2("time")
vals_time <- c(min(as.integer(vals_time)) - 1, vals_time)

n_time <- length(vals_time)

oldest <- array(rep(n_living, times = n_time),
                dim = c(1, n_time),
                dimnames = list(age = "105+",
                                time = vals_time)) %>%
    Counts(dimscales = c(time = "Points"))

saveRDS(oldest,
        file = "out/oldest.rds")

