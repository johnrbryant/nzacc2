
library(tidyr)
library(dplyr)
library(dembase)
library(readr)

erp <- read_csv(file = "data/DPE403903_20211206_043504_84.csv",
                skip = 1,
                n_max = 1728) %>%
    rename(time = `...1`,
           age = `...3`) %>%
    select(-`...2`) %>%
    fill(time) %>%
    mutate(age = cleanAgeGroup(age)) %>%
    pivot_longer(cols = c(Male, Female), names_to = "sex", values_to = "count") %>%
    dtabs(count ~ age + sex + time) %>%
    Counts(dimscale = c(time = "Points")) %>%
    toInteger()


saveRDS(erp,
        file = "out/erp.rds")
