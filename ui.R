library(sna)

# library(shinyRGL)
shinyUI(fluidPage(
  titlePanel("Clustering app"),
  sidebarLayout(sidebarPanel(
      selectInput(inputId = "dataset", 
                  label = "Dataset:", 
                  choices = c("mtcars", "iris"), 
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
      selectInput(inputId = "layout", 
                  label = "Layout", 
                  choices = c("circle", "fruchtermanreingold", "kamadakawai"), 
                  selected = "fruchtermanreingold",
                  selectize = TRUE)

    
    ),
    mainPanel(
      
#       webGLOutput("plot3D"),
        checkboxInput(inputId = "use3D",
                      label = "Use 3D rendering. Your browser should support WebGL.",
                      value = FALSE),
        plotOutput("plot2D", width = 800, height = 800)
  
  
  
    )
  )))