
library(dplyr)
library(dembase)
library(ggplot2)

plot_theme <- readRDS("out/plot_theme.rds")

palette <- readRDS("out/palette.rds")

census <- readRDS("calc/out/census.rds") %>%
    as.data.frame(midpoints = "age") %>%
    mutate(count = 1e-3 * count)
    
p <- ggplot(census, aes(x = age, y = count, color = sex)) +
    facet_wrap(vars(time)) +
    geom_line() +
    scale_color_manual(values = palette$sex) +
    xlab("Age") +
    ylab("Thousands") +
    ylim(0, NA) +
    plot_theme

graphics.off()
pdf(file = "out/fig_census.pdf",
    width = 7,
    height = 3)
plot(p)
dev.off()
    
    

