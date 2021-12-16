
library(dplyr)
library(ggplot2)

plot_theme <- readRDS("out/plot_theme.rds")

palette <- readRDS("out/palette.rds")

data <- readRDS("out/vals_est_erp_cover.rds") %>%
    filter(time %in% c(2001, 2004, 2009, 2013, 2018))


p <- ggplot(data, aes(x = age)) +
    facet_grid(rows = vars(time), cols = vars(sex)) +
    geom_ribbon(aes(ymin = `2.5%`, ymax = `97.5%`), fill = palette$quantiles[[1]]) +
    geom_ribbon(aes(ymin = `25%`, ymax = `75%`), fill = palette$quantiles[[2]]) +
    geom_hline(yintercept = 1, linetype = "dotted") +
    plot_theme +
    xlab("Age") +
    ylab("")


graphics.off()
pdf(file = "out/fig_est_erp_cover.pdf",
    width = 7,
    height = 10)
plot(p)
dev.off()
