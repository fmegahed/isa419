# Class 06: The AV IP Reputation Dataset

pacman::p_load(tidyverse, plotly)


av = read.csv('data/reputation.data', sep = '#', header = F)
colnames(av) = c('ip',  'risk',  'reliability',  'activity',  'country',  'city',
                 'lat,long', 'unknown')

glimpse(av)



# * Step 1: Separate the lat,long column ----------------------------------
av = separate(av, col = `lat,long`, into = c('lat', 'long'), sep = ',',
              convert = T)
glimpse(av)


# * Step 2: Technically correct -------------------------------------------
av$risk = as.factor(av$risk)
av = av %>% 
  mutate(across(.cols = c(reliability, unknown), .fns = as.factor),
         across(.cols = where(is.character), .fns = as.factor))


# * Step 3: The Summary of the Dataset ------------------------------------
summary(av)


# * Step 4: Count Num and Percent of Malicious Host by Country and --------
av_grouped = av %>% 
  group_by(country, city) %>% 
  summarise(n = n(),
            perc = 100*n/nrow(av)) %>% 
  mutate(perc1 = 100*n/nrow(av) )

av_grouped1 = av %>% 
  group_by(country, city) %>% 
  count()


# * Step 5 ----------------------------------------------------------------
# median and max of risk and reliability based on the country and city grouping

av_grouped =
  av %>% 
  group_by(country, city) %>% 
  mutate(risk = as.integer(risk),
         reliability = as.integer(reliability),
         unknown = as.integer(unknown)) %>% 
  summarise(
    n = n(),
    perc = 100*n/nrow(av),
    q1_unknown = quantile(unknown, probs = 0.25),
    q2_reliability = quantile(reliability, probs = 0.5),
    q4_reliability = quantile(reliability, probs = 1),
    median_risk = median(risk),
    max_risk = max(risk)
    )

av_grouped



# * Step6: Map  -----------------------------------------------------------
world_map = map_data('world') # comes from ggplot2 (through maps)

ggplot() +
  geom_polygon(data = world_map,
               mapping = aes(x = long, y = lat, group = group),
               fill = 'white', color = 'black') +
  geom_point(data = av, 
             mapping = aes(x = long, y = lat, label = country),
             size = 2, color = 'red')

ggplotly()
