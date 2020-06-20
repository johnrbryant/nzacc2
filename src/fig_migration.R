
library(dplyr)
library(dembase)
library(ggplot2)
library(dplyr)
library(docopt)

'
Usage:
fig_migration.R [options]

Options:
--direction (arrivals|departures) [default: arrivals]
' -> doc
opts <- docopt(doc)
direction <- opts$direction

plot_theme <- readRDS("out/plot_theme.rds")

palette <- readRDS("out/palette.rds")

migration <- readRDS("calc/out/migration.rds") %>%
    as.data.frame(midpoints = "age") %>%
    filter(tolower(direction) == !!direction)
    
p <- ggplot(migration, aes(x = age, y = count, color = sex)) +
    facet_wrap(vars(time), nrow = 3) +
    geom_line() +
    scale_color_manual(values = palette$sex) +
    xlab("Age") +
    ylab("") +
    ylim(0, NA) +
    plot_theme

graphics.off()
file <- sprintf("out/fig_migration_%s.pdf", direction)
pdf(file = file,
    width = 7,
    height = 5)
plot(p)
dev.off()
    
    

