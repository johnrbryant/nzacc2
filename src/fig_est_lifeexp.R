
library(dplyr)
library(ggplot2)

plot_theme <- readRDS("out/plot_theme.rds")

palette <- readRDS("out/palette.rds")

data <- readRDS("out/vals_est_lifeexp.rds")

p <- ggplot(data, aes(x = time)) +
    facet_grid(rows = vars(age), cols = vars(sex), scales = "free_y") +
    geom_ribbon(aes(ymin = `2.5%`, ymax = `97.5%`), fill = palette$quantiles[[1]]) +
    geom_ribbon(aes(ymin = `25%`, ymax = `75%`), fill = palette$quantiles[[2]]) +
    plot_theme +
    xlab("Year") +
    ylab("Years")


graphics.off()
pdf(file = "out/fig_est_lifeexp.pdf",
    width = 6,
    height = 5)
plot(p)
dev.off()
