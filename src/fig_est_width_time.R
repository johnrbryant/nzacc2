
library(dplyr)
library(ggplot2)

plot_theme <- readRDS("out/plot_theme.rds")

palette <- readRDS("out/palette.rds")

data <- readRDS("out/vals_est_width_time.rds")

p <- ggplot(data, aes(x = time, y = width)) +
    geom_line() +
    geom_vline(xintercept = c(2001, 2006, 2013), linetype = "dotted") +
    plot_theme +
    xlab("Year") +
    ylab("")


graphics.off()
pdf(file = "out/fig_est_width_time.pdf",
    width = 5,
    height = 2)
plot(p)
dev.off()
