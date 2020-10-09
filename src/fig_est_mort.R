
library(dplyr)
library(ggplot2)

palette <- readRDS("out/palette.rds")

data_direct <- readRDS("out/vals_direct_mort.rds") %>%
    filter(time == 2014)

data_model <- readRDS("out/vals_est_mort.rds") %>%
    filter(time == 2014)

p <- ggplot(data_model, aes(x = age)) +
    facet_wrap(vars(sex), nrow = 1) +
    geom_ribbon(aes(ymin = `2.5%`, ymax = `97.5%`), fill = palette$quantiles[[1]]) +
    geom_point(data = data_direct, aes(x = age, y = rate), size = 0.1) +
    scale_y_log10(labels = function(x) format(x, scientific = FALSE)) + 
    xlab("Age") +
    ylab("Rate")

graphics.off()
pdf(file = "out/fig_est_mort.pdf",
    width = 7,
    height = 3.5)
plot(p)
dev.off()
    



