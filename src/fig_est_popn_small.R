
library(dplyr)
library(ggplot2)
library(docopt)
'
Usage:
fig_est_popn_small.R [options]
Options:
--sex (female|male) [default: female]
' -> doc
opts <- docopt(doc)
sex <- opts$sex

plot_theme <- readRDS("out/plot_theme.rds")

palette <- readRDS("out/palette.rds")

times_plot <- c(2001, 2008, 2013, 2018)

data_est <- readRDS("out/vals_est_popn.rds") %>%
    filter(tolower(sex) == !!sex) %>%
    filter(time %in% times_plot)

data_raw <- readRDS("out/vals_data_census.rds") %>%
    filter(tolower(sex) == !!sex) %>%
    filter(time %in% times_plot)

p <- ggplot(data_est, aes(x = age)) +
    facet_wrap(vars(time), nrow = 2) +
    geom_ribbon(aes(ymin = `2.5%`, ymax = `97.5%`), fill = "blue") +
    geom_line(aes(y = count, x = age), data = data_raw, size = 0.2) +
    xlab("Age") +
    ylab("Thousands") +
    ylim(0, NA)


graphics.off()
file <- sprintf("out/fig_est_popn_small_%s.pdf", sex)
pdf(file = file,
    width = 7,
    height = 3.5)
plot(p)
dev.off()
