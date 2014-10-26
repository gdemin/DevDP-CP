library(igraph)




shinyServer(function(input, output) {
    

    output$plot2D = renderPlot({
        session = getDefaultReactiveDomain()
        progress <- shiny::Progress$new(session, min=1, max=6)
        on.exit(progress$close())
        progress$set(value=1,message = 'Loading data...')
        rownames(iris) = paste0(iris$Species,rownames(iris)) 
        if (input$dataset!="(your own data)"){
            dat = switch(input$dataset,
                iris = iris,
                mtcars = mtcars,
                USArrests = USArrests,
                women = women,
                LifeCycleSavings = LifeCycleSavings
                )
        } else {
            fdata = input$data_file
            if (is.null(fdata)){
                plot(1:3,1:3, type="n",xlab = "", ylab="",axes=FALSE)
                text (x=2,y=2,'Please, upload your data - "Choose file" item.')
                return()
            } else {
                if (fdata$size>10000){
                    plot(1:3,1:3, type="n",xlab = "", ylab="",axes=FALSE)
                    text (x=2,y=2,'File should be less than 10000 bytes.')
                    return()
                }
                dat = read.csv(fdata$datapath,header=TRUE,sep = ",",na.string = "")
               }
            
        }
        progress$set(value=2,message = 'Building graph...')
        dat = dat[,sapply(dat,is.numeric), drop = FALSE]
        if (ncol(dat)<1){
            plot(1:3,1:3, type="n",xlab = "", ylab="",axes=FALSE)
            text (x=2,y=2,'There is no numeric columns in this file.')
            return()
        }
        if(input$scale_data) dat = scale(dat) 
        dist_matrix = as.matrix(dist(dat,method = input$dist_type))
        dist_matrix = dist_matrix/max(dist_matrix,na.rm = TRUE)
        dist_matrix[is.na(dist_matrix)] = 0
        graph_matrix = dist_matrix<(as.numeric(input$connection_dist)/100)
        diag(graph_matrix) = FALSE
        graph = graph.adjacency(graph_matrix, mode = "undirected")
        progress$set(value=3,message = 'Building layout...')
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
        progress$set(value=4,message = 'Detecting community...')
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
        progress$set(value=5,message ='Plotting result...')
        plot(communit,graph, layout = gr_layout,
                 mark.border = NA)
        progress$set(value=6,message = 'Finishing...')
    })        
    
})