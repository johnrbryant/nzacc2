
library(dplyr)
library(dembase)
library(ggplot2)

plot_theme <- readRDS("out/plot_theme.rds")

time_keep <- seq(from = 2002, to = 2018, by = 2)

reg_births <- readRDS("out/reg_births.rds") %>%
    as.data.frame(midpoints = "age") %>%
    filter(time %in% time_keep)
    
p <- ggplot(reg_births, aes(x = age, y = count)) +
    facet_wrap(vars(time)) +
    geom_line() +
    xlab("Age of mother") +
    ylab("") +
    ylim(0, NA) +
    plot_theme

graphics.off()
pdf(file = "out/fig_reg_births.pdf",
    width = 5,
    height = 5)
plot(p)
dev.off()
    
    

