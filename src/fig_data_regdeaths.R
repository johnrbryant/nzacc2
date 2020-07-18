
library(dplyr)
library(dembase)
library(ggplot2)

plot_theme <- readRDS("out/plot_theme.rds")

palette <- readRDS("out/palette.rds")

data <- readRDS("out/vals_data_regdeaths.rds")
    
p <- ggplot(data, aes(x = age, y = count, color = sex)) +
    facet_wrap(vars(time), nrow = 3) +
    geom_line() +
    scale_color_manual(values = palette$sex) +
    xlab("Age") +
    ylab("Thousands") +
    ylim(0, NA) +
    plot_theme

graphics.off()
pdf(file = "out/fig_data_regdeaths.pdf",
    width = 7,
    height = 5)
plot(p)
dev.off()
    
    

