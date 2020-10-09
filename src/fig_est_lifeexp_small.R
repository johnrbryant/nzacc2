
library(dplyr)
library(ggplot2)

palette <- readRDS("out/palette.rds")

data <- readRDS("out/vals_est_lifeexp.rds") %>%
    filter(age == "Age 0")

p <- ggplot(data, aes(x = time)) +
    facet_wrap(vars(sex), nrow = 1) +
    geom_ribbon(aes(ymin = `2.5%`, ymax = `97.5%`), fill = palette$quantiles[[1]]) +
    geom_ribbon(aes(ymin = `25%`, ymax = `75%`), fill = palette$quantiles[[2]]) +
    xlab("Year") +
    ylab("Years")


graphics.off()
pdf(file = "out/fig_est_lifeexp_small.pdf",
    width = 7,
    height = 3.5)
plot(p)
dev.off()
