
library(tidyr)
library(dplyr)
library(dembase)
library(readr)

reg_births_sex <- read_csv(file = "data/VSB357002_20200608_085016_54.csv",
                           skip = 3,
                           col_names = c("time", "Male", "Female"),
                           n_max = 17) %>%
    gather(key = sex, value = count, Male, Female) %>%
    dtabs(count ~ sex + time) %>%
    Counts(dimscale = c(time = "Intervals")) %>%
    toInteger()

check_total <- read_csv(file = "data/VSB357002_20200608_085016_54.csv",
                        skip = 3,
                        n_max = 17,
                        col_names = FALSE) %>%
    select(2:3) %>%
    unlist() %>%
    sum()

stopifnot(all.equal(sum(reg_births_sex), check_total))

saveRDS(reg_births_sex,
        file = "out/reg_births_sex.rds")
