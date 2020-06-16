
library(dplyr)
library(dembase)
library(ggplot2)

plot_theme <- readRDS("out/plot_theme.rds")

palette <- readRDS("out/palette.rds")

reg_births_sex <- readRDS("out/reg_births_sex.rds") %>%
    as.data.frame()
    
p <- ggplot(reg_births_sex, aes(x = time, y = count, color = sex)) +
    geom_line() +
    scale_color_manual(values = palette$sex) +
    xlab("Year") +
    ylab("") +
    ylim(0, NA) +
    plot_theme

graphics.off()
pdf(file = "out/fig_reg_births_sex.pdf",
    width = 5,
    height = 3)
plot(p)
dev.off()
    
    

