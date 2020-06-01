
library(dplyr)
library(dembase)
library(ggplot2)

plot_theme <- readRDS("out/plot_theme.rds")

census <- readRDS("out/census.rds") %>%
    as.data.frame() %>%
    mutate(age = recode(age, "100+" = "100"),
           age = as.integer(age)) %>%
    mutate(count = 1e-3 * count)
    
p <- ggplot(census, aes(x = age, y = count, color = sex)) +
    facet_wrap(vars(time)) +
    geom_line() +
    scale_color_manual(values = c("darkblue", "darkorange")) +
    xlab("") +
    ylab("") +
    ylim(0, NA) +
    plot_theme
p

graphics.off()
pdf(file = "out/fig_census.pdf",
    width = 7,
    height = 3)
plot(p)
dev.off()
    
    

