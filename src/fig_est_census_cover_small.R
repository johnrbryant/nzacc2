
library(dplyr)
library(ggplot2)


times_plot <- c(2001, 2013)

palette <- readRDS("out/palette.rds")

data <- readRDS("out/vals_est_census_cover.rds") %>%
    filter(time %in% times_plot)


p <- ggplot(data, aes(x = age)) +
    facet_grid(rows = vars(sex), cols = vars(time)) +
    geom_ribbon(aes(ymin = `2.5%`, ymax = `97.5%`), fill = palette$quantiles[[1]]) +
    geom_ribbon(aes(ymin = `25%`, ymax = `75%`), fill = palette$quantiles[[2]]) +
    geom_hline(yintercept = 1, linetype = "dashed") +
    xlab("Age") +
    ylab("")


graphics.off()
pdf(file = "out/fig_est_census_cover_small.pdf",
    width = 7,
    height = 3.5)
plot(p)
dev.off()
