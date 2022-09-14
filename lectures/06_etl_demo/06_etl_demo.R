library(tidyverse)
library(leaflet)
library(maps)

alien_vault = 
  read.csv(file = 'https://reputation.alienvault.com/reputation.data', sep = '#', header = F) %>% 
  drop_na()

colnames(alien_vault) = c('ip', 'risk', 'reliability', 'activity', 'country', 'city', 'lat,long', 'unknown')

alien_vault = alien_vault %>% 
  separate(col = 'lat,long', into = c('lat', 'long'), sep = ',')

alien_vault = alien_vault %>% 
  mutate(across(.cols = activity:city, as.factor),
         across(.cols = c(lat,long), as.numeric))

# Overall Summary
summary(alien_vault)

# Counting the Data by Country and City
alien_group_counts = alien_vault %>% 
  group_by(country, city) %>% 
  count() %>% 
  mutate(perc = round(100*n/nrow(alien_vault), digits = 2))

# Counting the Data by Country and City
alien_vault_grp = alien_vault %>% 
  group_by(country, city) %>% 
  summarise(
    q1_unknown = quantile(x = unknown, probs = 0.25),
    median_risk = median(risk),
    median_reliability = quantile(x = reliability, prob = 0.5),
    max_risk = max(risk))

# Plotting the Stuff on a Map
world_map = map_data('world') %>% filter(region != "Antarctica")


# Map of the Coordinates
ggplot(data = world_map) +
  geom_polygon(aes(x= long, y = lat, group = group), fill = 'white', color = 'black') +
  geom_point(data = alien_vault, aes(x = long, y = lat, color = as.factor(risk), label = country),
             size = 1) +
  theme_minimal()

plotly::ggplotly()
