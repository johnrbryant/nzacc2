
library(dplyr)
library(dembase)
library(ggplot2)

plot_theme <- readRDS("out/plot_theme.rds")

palette <- readRDS("out/palette.rds")

reg_births <- readRDS("out/reg_deaths.rds") %>%
    as.data.frame(midpoints = "age")
    
p <- ggplot(reg_births, aes(x = age, y = count, color = sex)) +
    facet_wrap(vars(time), nrow = 3) +
    geom_line() +
    scale_color_manual(values = palette$sex) +
    xlab("Age") +
    ylab("") +
    ylim(0, NA) +
    plot_theme

graphics.off()
pdf(file = "out/fig_reg_deaths.pdf",
    width = 7,
    height = 5)
plot(p)
dev.off()
    
    

