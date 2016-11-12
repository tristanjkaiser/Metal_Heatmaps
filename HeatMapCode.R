# Tristan Kaiser
# Plotly Maps
# 10/11/2016
install.packages("plotly")

library(plotly)

dfWorks <- read.csv('C:/Users/Tristan/Desktop/RFiles/Heatmaps/Metal_Data.csv', header = TRUE, na.strings=c("", NA))

# This works to produce a map for just one column
dfWorks$Percentage <- as.numeric(sub("%", "", dfWorks$Percentage))

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
?add_trace
p <- plot_geo(dfWorks) %>%
  add_trace(
    z = ~Percentage, color = ~Percentage, zauto=FALSE, zmin = 1, colors = 'Reds', 
    text = ~Country, locations = ~CountryCode, marker = list(line = l,  margin = m)
  ) %>%
  colorbar(title = '123,000 tonnes', tickprefix = '%') %>%
  layout(
    title = '2014 Global Cobalt Production <br> Source: USGS & Kaiser Research',
    geo = g,
    margin = m
  )
p
