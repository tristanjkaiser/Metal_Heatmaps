# Tristan Kaiser
# Plotly Maps
# 11/11/2016

library(tidyverse)
library(plotly)
library(RColorBrewer)

read_csv("Metal_Data.csv") %>% 
  mutate(Percentage = as.numeric(sub("%", "", Percentage)),
         Percentage_log = ifelse(Percentage == 0, 0, log(Percentage))) -> dfWorks

l <- list(color = toRGB("grey"), width = 0.5)

g <- list(
  showframe = TRUE,
  showcoastlines = FALSE,
  showcountries = TRUE,
  projection = list(type = 'Mercator'),
  showocean = TRUE,
  oceancolor = "#c6dbef"
)

m <- list(
  l = 10,
  r = 10
)

p <- plot_geo(dfWorks) %>%
  add_trace(
    z = ~Percentage, 
    color = ~Percentage_log, 
    zauto = FALSE, 
    zmin = 1, 
    colors = c("white", "#fb6a4a", "#ef3b2c", "#67000d"),
    text = ~Country, 
    locations = ~CountryCode, 
    marker = list(line = l,  margin = m)
  ) %>%
  colorbar(title = '123,000 tonnes', tickprefix = '%') %>%
  layout(
    title = '2014 Global Cobalt Production <br> Source: USGS & Kaiser Research',
    geo = g,
    margin = m
  )
p
