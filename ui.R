library(sna)

# library(shinyRGL)
shinyUI(fluidPage(
  titlePanel("Clustering app"),
  helpText("Help is here."),
  sidebarLayout(sidebarPanel(
      selectInput(inputId = "dataset", 
                  label = "Dataset:", 
                  choices = c("iris", "mtcars", "USArrests", "women","LifeCycleSavings"), 
                  selected = "mtcars",
                  selectize = TRUE),
      checkboxInput(inputId = "scale_data",
                    label = "Scale data",
                    value = TRUE),
      selectInput(inputId = "dist_type", 
                  label = "Distance:", 
                  choices = c("euclidean", "maximum", "manhattan", "canberra", "binary","minkowski"), 
                  selected = "euclidean",
                  selectize = TRUE),
      sliderInput("connection_dist",
                  "% of maximum distance",
                  min = 0,
                  max = 100,
                  value = 1),
      selectInput(inputId = "comm_algo", 
                  label = "Community detection method:", 
                  choices = c("edge.betweenness.community", "fastgreedy.community", "label.propagation.community", "leading.eigenvector.community", "multilevel.community"), 
                  selected = "fastgreedy.community",
                  selectize = TRUE),
      selectInput(inputId = "layout", 
                  label = "Layout:", 
                  choices = c("auto", "random", "circle",  "fruchterman.reingold", "kamada.kawai", "spring", "fruchterman.reingold.grid", "lgl", "graphopt", "svd"), 
                  selected = "auto",
                  selectize = TRUE)

    
    ),
    mainPanel(
      
#       webGLOutput("plot3D"),
        plotOutput("plot2D", width = 800, height = 800)
  
  
  
    )
  )))