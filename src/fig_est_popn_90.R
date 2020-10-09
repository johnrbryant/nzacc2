
library(dplyr)
library(ggplot2)

plot_theme <- readRDS("out/plot_theme.rds")

palette <- readRDS("out/palette.rds")

data_census <- readRDS("out/vals_data_census.rds") %>%
    filter(age > 95)

data_est <- readRDS("out/vals_est_popn.rds") %>%
    filter(age > 95)



p <- ggplot(data_est, aes(x = age, linetype = sex)) +
    facet_wrap(vars(time)) +
    geom_ribbon(aes(ymin = `2.5%`, ymax = `97.5%`), fill = palette$quantiles[[1]]) +
    ## geom_ribbon(aes(ymin = `25%`, ymax = `75%`), fill = palette$quantiles[[2]]) +
    ## geom_line(aes(y = `50%`, x = age), size = 0.2, col = "white") +
    geom_line(aes(y = count, x = age), data = data_census, size = 0.3) +
    plot_theme +
    xlab("Age") +
    ylab("") +
    ylim(0, NA)


graphics.off()
file <- sprintf("out/fig_est_popn_%s.pdf", sex)
pdf(file = file,
    width = 7,
    height = 9)
plot(p)
dev.off()


exposure <- fetch("calc/out/model_base.est", c("a", "p")) %>%
    exposure(triangle = T)



census <- fetch("calc/out/model_base.est", c("datasets", "cens")) %>%
    as.array()
dimnames(census)[["time"]] <- c("2002", "2007", "2014")
census <- Counts(census)

deaths <- fetch("calc/out/model_base.est", c("datasets", "reg_deaths")) %>%
    as.array()
deaths <- Counts(deaths, dimscales = c(time = "Points"))
direct <- deaths / census

dr <- fetch("calc/out/model_base.est", c("sys", "de", "li", "ra")) %>%
    collapseDimension(dimension = "triangle", weights = exposure) %>%
    collapseIntervals(dim = "age", breaks = 0:100, weights = exposure) %>%
    subarray(time %in% dimnames(direct)$time)

dplot(~ age | time * sex,
      dr,
      subarray = age > 90,
      na.rm = TRUE,
      scales = list(y = list(log = T)),
      overlay = list(values = direct, col = "red"),
      midpoints = "age")
