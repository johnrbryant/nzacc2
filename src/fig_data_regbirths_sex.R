
library(dplyr)
library(dembase)
library(ggplot2)

plot_theme <- readRDS("out/plot_theme.rds")

palette <- readRDS("out/palette.rds")

data <- readRDS("out/vals_data_regbirths_sex.rds")
    
p <- ggplot(data, aes(x = time, y = count, color = sex)) +
    geom_line() +
    scale_color_manual(values = palette$sex) +
    xlab("Year") +
    ylab("Thousands") +
    ylim(0, NA) +
    plot_theme

graphics.off()
pdf(file = "out/fig_data_regbirths_sex.pdf",
    width = 5,
    height = 3)
plot(p)
dev.off()
    
    

