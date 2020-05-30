
library(dplyr)
library(dembase)
library(ggplot2)

levels_age <- c(0:89, "90+")
labels_age <- paste("Age", levels_age)

census <- readRDS("out/census.rds") %>%
    collapseIntervals(dimension = "age", breaks = seq(0, 90)) %>%
    as.data.frame() %>%
    mutate(count = 1e-3 * count) %>%
    mutate(age = factor(age, levels = levels_age, labels = labels_age))

idi <- readRDS("out/idi.rds") %>%
    as.data.frame() %>%
    mutate(count = 1e-3 * count) %>%
    mutate(age = factor(age, levels = levels_age, labels = labels_age))

plot_theme <- readRDS("out/plot_theme.rds")

census <- filter(census, age %in% labels_age[1:30])
idi <- filter(idi, age %in% labels_age[1:30])                 

p <- ggplot(census, aes(x = time, y = count, color = sex)) +
    facet_wrap(vars(age)) +
    geom_point(size = 0.5) +
    geom_line(data = idi) +
    scale_color_manual(values = c("darkblue", "darkorange")) +
    xlab("") +
    ylab("") +
    ylim(0, NA) +
    plot_theme


graphics.off()
pdf(file = "out/fig_census_idi.pdf",
    width = 7,
    height = 8)
plot(p)
dev.off()
    
    

