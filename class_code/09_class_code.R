# clustering code


# * Required Packages -----------------------------------------------------
pacman::p_load(
  tidyverse, # for manipulating data in R
  NbClust, # this is the state-of-the-art clustering package in R (allows for opt num clusters based on 30 indices)
  factoextra, # visualizing the cluster outcomes (it will not always be pretty)
  cluster # for the function called daisy for the gower distance (mixing numeric and fact)
)

library(factoextra)


# * Simple Example --------------------------------------------------------

df = read_csv('data/cluster_mock_data.csv') # 7 obs and 2 variables

results = NbClust(
  data = df, # is your matrix or dataset
  distance = 'euclidean', # default value for distance (and they have other distance measures)
  min.nc = 2, # minimum num of clusters = 2
  max.nc = 4, #
  method = 'kmeans', # we will use kmeans similar to what you will do 401/491
  index = 'all' # default (26 indices see ?NbClust for more detail)
)

cluster_label = results$Best.partition # extracting the cluster_labels
class(cluster_label)

# * Visualizing Cluster Results (ALL Columns are Numeric) -----------------
res_list = list(data = df, cluster = cluster_label)

fviz_cluster(object = res_list) + theme_bw()



# * Reexamine the PortMap dataset -----------------------------------------

portmap = read.csv('data/Portmap.csv', nrows = 1000) 

portmap = portmap %>% 
  select(Flow.Duration, Total.Backward.Packets, Total.Fwd.Packets,
         Active.Mean, Label) %>% 
  tibble()

portmap$Label = as.factor(portmap$Label)

summary(portmap) # lets rescale the numeric variables

# Lets write a func for z transformation
ztran = function(x){
  (x - mean(x))/sd(x)
}

scale01 = function(x){
  (x - min(x))/range(x)
}


portmap_scaled = 
  portmap %>% 
  # apply our custom function to the four columns
  # we used the : since the columns in a row
  mutate(across(Flow.Duration:Active.Mean, .fns = ztran))


summary(portmap_scaled) # a sanity check for our ztran function


# * NBClust with the Label (as a way of cheating and introducing a --------

gower_distance = 
  daisy(x = portmap_scaled,
        metric = 'gower')

portmap_results = NbClust(diss = gower_distance,
                          distance = NULL,
                          method = 'complete',
                          max.nc = 5,
                          index = 'dunn')

# you would never do this in practice since you have no label to use
# for a class exercise, this gives you insights about how the label and cluster results
# are matching
table(portmap_results$Best.partition, portmap_scaled$Label)
