
library(methods)
library(tidyr)
library(dplyr)
library(dembase)
library(readr)

## Process data

idi <- read_csv("data/exp-pop-estimates-2007-16-csv.csv") %>%
    mutate(age = ifelse(age == 90, "90+", age)) %>%
    rename(time = year) %>%
    dtabs(idierp ~ age + sex + time) %>%
    Counts(dimscales = c(time = "Points"))

check_total <- read_csv("data/exp-pop-estimates-2007-16-csv.csv") %>%
    pull(idierp) %>%
    sum()

stopifnot(all.equal(sum(idi), check_total))


## Save

saveRDS(idi,
        file = "out/idi.rds")
