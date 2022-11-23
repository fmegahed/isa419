pacman::p_load(tidyverse,
               lubridate)



# * Reading the Data and Assigning it Proper Names ------------------------

# we used read_delim to get a tidy_df which prints better and it can guess SOME
# of the column types correctly
df = read_delim(file = 'http://web.stanford.edu/class/cs259d/hw/server-log.txt',
                col_names = F) %>% 
  select(-c(1))

# column names based on the slide
colnames(df) = c('start_date', 'start_time', 
                 'duration', 'server', 
                 'source_port', 'dest_port',
                 'source_ip', 'dest_ip')
glimpse(df) # printing the col types and the first few observations



# * Logic/Questions to Ask ------------------------------------------------

# How many unique values for cols 4:8 do I have and what are they?

df %>% select(4:8) %>% map(.f = table) -> freq_list
table(df$start_date) # you can also do this for each col

# When we looked at the server applications, some of these were "obscure"
table(df$server)


# * Lets make our data behave in the way we want --------------------------

# simplify the ask and we will only focus on the first day of data
day1_df = df %>% filter(start_date =='06/03/2014') %>% 
  mutate(duration= lubridate::hms(duration)) %>% # 
  mutate(server = case_when(
    str_detect(server, pattern = 'ecr') ~ 'ecr',
    str_detect(server, pattern = 'auth') ~ 'auth',
    str_detect(server, pattern = 'eco') ~ 'eco',
    str_detect(server, pattern = 'finger') ~ 'finger',
    str_detect(server, pattern = 'ftp') ~ 'ftp',
    str_detect(server, pattern = 'http') ~ 'http',
    str_detect(server, pattern = 'ntp/u') ~ 'ntp',
    str_detect(server, pattern = 'smtp') ~ 'smtp',
    str_detect(server, pattern = 'telnet') ~ 'telnet',
    str_detect(server, pattern = 'domain') ~ 'domain'
  ))



day1_df %>% 
  ggplot(aes(x = start_time, y = duration, color = index)) +
  geom_point(size = 2)



