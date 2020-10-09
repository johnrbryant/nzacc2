
library(dplyr)
library(ggplot2)

times_plot <- c(2001, 2008, 2013, 2018)
sex_plot <- "Male"

data <- readRDS("out/vals_est_width_age_sex.rds") %>%
    filter(time %in% times_plot) %>%
    filter(sex == sex_plot)

p <- ggplot(data, aes(x = age, y = width_abs)) +
    facet_wrap(vars(time), nrow = 2) +
    geom_line() +
    xlab("Age") +
    ylab("") +
    ylim(0, NA)

graphics.off()
pdf(file = "out/fig_est_width_age_sex.pdf",
    width = 7,
    height = 3.5)
plot(p)
dev.off()
