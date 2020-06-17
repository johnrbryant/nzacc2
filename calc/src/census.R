
library(tidyr)
library(dplyr)
library(readr)
library(dembase)


census <- read_csv("data/Age_by_sex/TABLECODE8001_Data_e35fb0f7-8ed5-4d62-86c4-269454dd04f4.csv") %>%
    select(age = "Age group", sex = Sex, time = Year, count = Value) %>%
    filter(time %in% c(2001, 2006, 2013)) %>%
    mutate(age = cleanAgeGroup(age)) %>%
    dtabs(count ~ age + sex + time) %>%
    Counts(dimscales = c(time = "Points"))

check_total <- read_csv("data/Age_by_sex/TABLECODE8001_Data_e35fb0f7-8ed5-4d62-86c4-269454dd04f4.csv") %>%
    filter(Year != 1996) %>%
    pull(Value) %>%
    sum()

stopifnot(all.equal(sum(census), check_total))

saveRDS(census,
        file = "out/census.rds")
