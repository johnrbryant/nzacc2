
library(tidyr)
library(dplyr)
library(dembase)
library(readr)

reg_births <- read_csv(file = "data/VSB355801_20181209_055056_66.csv",
                       skip = 1,
                       n_max = 35) %>%
    rename(age = X1) %>%
    gather(key = time, value = count, `2002`:`2018`) %>%
    mutate(age = recode(age, "Under 14 years" = "13", "47 years and over" = "47-49"),
           age = cleanAgeGroup(age)) %>%
    dtabs(count ~ age + time) %>%
    Counts(dimscale = c(time = "Intervals"))

check_total <- read_csv(file = "data/VSB355801_20181209_055056_66.csv",
                          skip = 1,
                          n_max = 35) %>%
    select(`2002`:`2018`) %>%
    unlist() %>%
    sum()

stopifnot(all.equal(sum(reg_births), check_total))

saveRDS(reg_births,
        file = "out/reg_births.rds")
