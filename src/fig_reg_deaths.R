
library(dplyr)
library(dembase)
library(ggplot2)

plot_theme <- readRDS("out/plot_theme.rds")

time_keep <- seq(from = 2002, to = 2018, by = 2)

reg_births <- readRDS("out/reg_deaths.rds") %>%
    as.data.frame(midpoints = "age") %>%
    filter(time %in% time_keep)
    
p <- ggplot(reg_births, aes(x = age, y = count, color = sex)) +
    facet_wrap(vars(time)) +
    geom_line() +
    scale_color_manual(values = c("darkblue", "darkorange")) +
    xlab("Age") +
    ylab("") +
    ylim(0, NA) +
    plot_theme

graphics.off()
pdf(file = "out/fig_reg_deaths.pdf",
    width = 6,
    height = 6)
plot(p)
dev.off()
    
    

