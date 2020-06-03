
library(tidyr)
library(dplyr)
library(readr)
library(dembase)


migration <- read_csv("data/ITM552105_20200603_110236_41.csv",
                      skip = 2,
                      n_max = 68) %>%
    rename(direction = X1, sex = X2, time = X3) %>%
    fill(direction, sex) %>%
    gather(key = age, value = count, `0 Years`:`90 Years and over`) %>%
    mutate(age = cleanAgeGroup(age)) %>%
    filter(age %in% c(0:89, "90+")) %>%
    dtabs(count ~ age + sex + time + direction) %>%
    Counts(dimscales = c(time = "Intervals"))

saveRDS(migration,
        file = "out/migration.rds")
