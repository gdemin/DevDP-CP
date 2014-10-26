
shinyUI(fluidPage(title = "Clustering application",
  titlePanel("Clustering based on graph communality-detection algorithm"),
  helpText("Inspired by John W. Foreman book \"Data Smart\". Application designed for detection similar cases in data (clustering).
You can upload your own data: in drop-down \"Choose dataset:\" select \"your own data\" and then choose file in \"Upload file with data:\". 
Application computes pairwise distance between all cases. Before distance computation it is possible to scale data (set checkbox). 
You can choose type of distance in the appropriate drop-down. Cases with distance less than threshold value considered
           as connected nodes of the graph. You can set this threshold on slider in % of maximum distance between cases.
This graph is displayed on the right. Application runs different communalities-detection
            algorithm (you can choose it from appropriate drop-down box) on this graph. 
Different clusters displayed with different fill colors. You can select different layout for displaying graph (lowest drop-down box) .
           Nodes are marked according to rownames of the dataset. That's all. Try it!:)"),
  sidebarLayout(sidebarPanel(
      selectInput(inputId = "dataset", 
                  label = "Choose dataset:", 
                  choices = c("(your own data)","mtcars", "USArrests", "LifeCycleSavings"), 
                  selected = "mtcars",
                  selectize = TRUE),
      fileInput(inputId = "data_file", 
                label = "Upload file with data:", 
                multiple = FALSE),
      checkboxInput(inputId = "scale_data",
                    label = "Should we scale_data?",
                    value = TRUE),
      selectInput(inputId = "dist_type", 
                  label = "Choose type of distance beetween cases:", 
                  choices = c("euclidean", "maximum", "manhattan", "canberra", "binary","minkowski"), 
                  selected = "euclidean",
                  selectize = TRUE),
      sliderInput("connection_dist",
                  "Set threshold, % of maximum distance (0 - all nodes disconnected, 100 - all nodes connected):",
                  min = 0,
                  max = 100,
                  value = 30),
      selectInput(inputId = "comm_algo", 
                  label = "Choose community detection method:", 
                  choices = c("edge.betweenness.community", "fastgreedy.community", "label.propagation.community", "leading.eigenvector.community", "multilevel.community"), 
                  selected = "fastgreedy.community",
                  selectize = TRUE),
      selectInput(inputId = "layout", 
                  label = "Select layout for displaying graph:", 
                  choices = c("auto", "random", "circle",  "fruchterman.reingold", "kamada.kawai", "spring", "fruchterman.reingold.grid", "lgl", "graphopt", "svd"), 
                  selected = "auto",
                  selectize = TRUE)

    
    ),
    mainPanel(
      

        plotOutput("plot2D", width = 800, height = 800)
  
    )
  )))