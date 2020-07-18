
library(dplyr)
library(dembase)
library(ggplot2)

plot_theme <- readRDS("out/plot_theme.rds")

data <- readRDS("out/vals_data_regbirths_age.rds")
    
p <- ggplot(data, aes(x = age, y = count)) +
    facet_wrap(vars(time), nrow = 3) +
    geom_line() +
    xlab("Age of mother") +
    ylab("Thousands") +
    ylim(0, NA) +
    plot_theme

graphics.off()
pdf(file = "out/fig_data_regbirths_age.pdf",
    width = 7,
    height = 4)
plot(p)
dev.off()
    
    

