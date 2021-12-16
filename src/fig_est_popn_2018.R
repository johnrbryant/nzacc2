
library(dplyr)
library(ggplot2)

plot_theme <- readRDS("out/plot_theme.rds")

palette <- readRDS("out/palette.rds")

data_est <- readRDS("out/vals_est_popn.rds") %>%
    filter(time == "2018") %>%
    rename(Estimate = count)

data_raw <- readRDS("out/vals_data_erp.rds") %>%
    filter(time == "2018") %>%
    rename(ERP = count)

data <- merge(


p <- ggplot(data_est, aes(x = age)) +
    facet_wrap(vars(sex)) +
    geom_ribbon(aes(ymin = `2.5%`, ymax = `97.5%`), fill = "blue") +
    geom_ribbon(aes(ymin = `25%`, ymax = `75%`), fill = palette$quantiles[[2]]) +
    geom_line(aes(y = `50%`, x = age), size = 0.2, col = "white") +
    geom_line(aes(y = count, x = age), data = data_raw, size = 0.3) +
    plot_theme +
    xlab("Age") +
    ylab("") +
    ylim(0, NA)


graphics.off()
file <- sprintf("out/fig_est_popn_%s.pdf", sex)
pdf(file = file,
    width = 7,
    height = 9)
plot(p)
dev.off()
