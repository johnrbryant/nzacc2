
library(dplyr)
library(dembase)
library(ggplot2)

plot_theme <- readRDS("out/plot_theme.rds")

reg_births_age <- readRDS("out/reg_births_age.rds") %>%
    as.data.frame(midpoints = "age")
    
p <- ggplot(reg_births_age, aes(x = age, y = count)) +
    facet_wrap(vars(time), nrow = 3) +
    geom_line() +
    xlab("Age of mother") +
    ylab("") +
    ylim(0, NA) +
    plot_theme

graphics.off()
pdf(file = "out/fig_reg_births_age.pdf",
    width = 7,
    height = 4)
plot(p)
dev.off()
    
    

