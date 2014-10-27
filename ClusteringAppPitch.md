Clustering based on graph community-detection algorithm
========================================================
transition: fade


Theorethical background
========================================================

Inspired by John W. Foreman book "Data Smart". 

<small>Clustering - detection groups of similar cases in data. Classical apporach is to compute pairwise distanses between cases and with various method combine nearest cases. Above mentioned book suppose approach when we considered our data as graph. If distance between two cases is less than threshold value than these two cases considered as connected nodes. Further we could apply to this graph various methods of communalities detection. Each discovered communality is our cluster. So we have following algorithm</small>:

- Compute pairwise distanse
- Build adjacency matrix - (matrix with 0/1 values - connected this cases/disconnected)
- Build graph with adjacency matrix
- Detect communality on this graph
 

Computation example
========================================================

```{r}
library(igraph)
dat = mtcars # we use data about automobile
dat = scale(dat) # scale data
dist_matrix = as.matrix(dist(dat,method = "euclid")) #compute pairwise distance
dist_matrix = dist_matrix/max(dist_matrix,na.rm = TRUE) # normalize distance (max = 1)
graph_matrix = dist_matrix<(30/100) # points with distance less than 30% of maximum considered connected
diag(graph_matrix) = FALSE # we don't need self-connected node
graph = graph.adjacency(graph_matrix, mode = "undirected") # build graph
communities = fastgreedy.community (graph)
```
***
```{r, echo=FALSE, fig.width=480, fig.height =480}
plot(communities,graph, mark.border=NA)
```

Clustering results
========================================================




Application
========================================================
You can try application here: https://gdemin.shinyapps.io/ClusteringApp/

Main features: