library(sna)
# library(shinyRGL)
data(mtcars)
data(iris)


shinyServer(function(input, output) {
    
    # Expression that generates a rgl scene with a number of points corresponding
    # to the value currently set in the slider.
    #     if (input$use3D) {
    #         output$plot3D = renderWebGL({
    #             gplot3d(rgws(1,5,3,1,0.2))
    #         })
    #     } else {

    output$plot2D = renderPlot({
        ds = input$dataset
        dat = mtcars #data(list = ds)
#         print (input$dataset)
#         print (str(dat))
        dat = dat[,sapply(dat,is.numeric), drop = FALSE]
print(str(dat))
        if(input$scale_data) dat = scale(dat) 
        dist_matrix = as.matrix(dist(dat,method = input$dist_type))
        dist_matrix = dist_matrix/max(dist_matrix,na.rm = TRUE)
        dist_matrix[is.na(dist_matrix)] = 0
        graph_matrix = dist_matrix>(as.numeric(input$connection_dist)/100)
        gplot(graph_matrix,
              label = rownames(dat),
              mode = input$layout,
              usearrows = FALSE)
    })        
    
    #     }
})