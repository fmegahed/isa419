pacman::p_load(tidyverse, DataExplorer)


# * Reading the data and ggplot -------------------------------------------
df = read_csv('data/Portmap.csv') %>% 
  slice_head(n=1000)

glimpse(df)

df %>% 
  # creates a canvas where 
  # the `Avg Bwd Segment Size` is encoded using the x position
  # and the `Avg Fwd Segment Size` is encoded using the y position
  ggplot(aes(x = `Avg Bwd Segment Size` , y = `Avg Fwd Segment Size`, color = Label)) +
  geom_point(size = 2, alpha = 0.6) + # use a dot/point to show every obs
  theme_bw() +
  geom_vline(xintercept = 45.86, color ='red') +
  theme(legend.position = 'bottom')

manual_colors = c('#FB4F14', 'black')
names(manual_colors) = c('Portmap', 'BENIGN')

df %>% 
  ggplot(aes(x = `Avg Bwd Segment Size`, color = Label)) +
  geom_histogram(bins = 20, fill = 'white', size = 2) +
  scale_color_manual(values = manual_colors)
  #scale_color_brewer(palette = 'Dark2')

summary(df$`Avg Bwd Segment Size`)
