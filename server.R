library(igraph)
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
        graph = graph.adjacency(graph_matrix, mode = "undirected")
        gr_layout = switch(input$layout,
                   auto = layout.auto(graph),
                   random = layout.random(graph),
                   circle = layout.circle(graph),
                   sphere = layout.sphere(graph),
                   fruchterman.reingold = layout.fruchterman.reingold(graph),
                   kamada.kawai = layout.kamada.kawai(graph),
                   spring = layout.spring(graph),
                   reingold.tilford = layout.reingold.tilford(graph),
                   fruchterman.reingold.grid = layout.fruchterman.reingold.grid(graph),
                   lgl = layout.lgl(graph),
                   graphopt = layout.graphopt(graph),
                   svd = layout.svd(graph)         
               )
        communit = switch(input$comm_algo,
            edge.betweenness.community = edge.betweenness.community (graph),
            fastgreedy.community = fastgreedy.community (graph),
            label.propagation.community = label.propagation.community (graph),
            leading.eigenvector.community = leading.eigenvector.community (graph),
            multilevel.community = multilevel.community (graph),
            optimal.community = optimal.community (graph),
            spinglass.community = spinglass.community (graph),
            walktrap.community. = walktrap.community. (graph)
           )
        igraph.options(arrow.mode = 0)
        plot(communit,graph, layout = gr_layout,
                 mark.border = NA)
    })        
    
    #     }
})