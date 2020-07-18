
library(dplyr)
library(dembase)
library(ggplot2)
library(dplyr)
library(docopt)
'
Usage:
fig_data_migration.R [options]

Options:
--direction (arrivals|departures) [default: arrivals]
' -> doc
opts <- docopt(doc)
direction <- opts$direction

plot_theme <- readRDS("out/plot_theme.rds")

palette <- readRDS("out/palette.rds")

data <- readRDS("out/vals_data_migration.rds") %>%
    filter(tolower(direction) == !!direction)
    
p <- ggplot(data, aes(x = age, y = count, color = sex)) +
    facet_wrap(vars(time), nrow = 3) +
    geom_line() +
    scale_color_manual(values = palette$sex) +
    xlab("Age") +
    ylab("Thousands") +
    ylim(0, NA) +
    plot_theme

graphics.off()
file <- sprintf("out/fig_data_migration_%s.pdf", direction)
pdf(file = file,
    width = 7,
    height = 5)
plot(p)
dev.off()
    
    

