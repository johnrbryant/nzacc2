
library(dplyr)
library(ggplot2)

plot_theme <- readRDS("out/plot_theme.rds")

palette <- readRDS("out/palette.rds")

data <- readRDS("out/vals_est_width_age.rds") %>%
    filter(time %in% c(2001, 2013))

p <- ggplot(data, aes(x = age, y = width, color = factor(time))) +
    geom_line() +
    plot_theme +
    xlab("Age") +
    ylab("") +
    ylim(0, NA)


graphics.off()
pdf(file = "out/fig_est_width_age.pdf",
    width = 7,
    height = 3.5)
plot(p)
dev.off()
