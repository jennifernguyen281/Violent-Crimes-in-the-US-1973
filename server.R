
library(shiny)
library(dplyr)
library(ggplot2)

dat <- read.csv("USArrests.csv")
colnames(dat)[colnames(dat)=="X"] <- "State"

# Define server logic 
shinyServer(function(input, output){

  # generate a summary table for the state selected by user
  output$table <- renderTable({
    summary <- dat %>% select(-UrbanPop) %>%filter(State==input$state) 
    summary
  })
  
  # generate a plot based on user's selection of plot_type
  output$plot <- renderPlot({
    
    # add a new column to indicate which state should be highlighted in the graph
    dat_2 <- dat %>% mutate(ToHighlight = ifelse(State == input$state, "yes", "no" )) 
    # Show a plot of number of arrests per 100,000 residents by State, sorted from highest to lowest
    if (input$plot_type == "Crime rates of your choice across States") {
      # The plot changes based on user input of crime type
      if(input$crime == "Murder") {
        g <- ggplot(data = dat_2, aes(x = reorder(State, Murder), y = Murder, fill = ToHighlight))
        graph <- g + geom_bar(stat = "identity",color = "black") +labs(y = "Murder Arrests per 100,000 residents", x = "State") + coord_flip() +
          scale_fill_manual( values = c( "yes"="tomato", "no"="pink" ), guide = FALSE ) #guide = FALSE to hide the legend of colors
        graph
                                   
      } else if (input$crime == "Assault") {
        g <- ggplot(data = dat_2, aes(x = reorder(State, Assault), y = Assault, fill = ToHighlight))
        graph <- g + geom_bar(stat = "identity", color = "black") +labs(y = "Assault Arrests per 100,000 residents", x = "State") + coord_flip() +
          scale_fill_manual( values = c( "yes"="tomato", "no"="pink" ), guide = FALSE )
        graph
      } else {
        g <- ggplot(data = dat_2, aes(x = reorder(State, Rape), y = Rape, fill = ToHighlight))
        graph <- g + geom_bar(stat = "identity", color = "black") +labs(y = "Rape Arrests per 100,000 residents", x = "State") + coord_flip() +
          scale_fill_manual( values = c( "yes"="tomato", "no"="pink" ), guide = FALSE )
        graph
      }
    
      # Show a scatterplot to present relationship between crime rates and UrbanPop
    } else if (input$plot_type == "Crime Rates vs. Percentage of Urban Population"){
      

      if(input$crime == "Murder") {
        g <- ggplot(dat, aes(x = UrbanPop, y = Murder))
        graph <- g + geom_point(color = "red") + labs(x = "Percentage of Urban Population", y = "Murder Arrests per 100,000 residents")
        graph
      } else if(input$crime == "Assault"){
        g <- ggplot(dat, aes(x = UrbanPop, y = Assault))
        graph <- g + geom_point(color = "red") + labs(x = "Percentage of Urban Population", y = "Assault Arrests per 100,000 residents")
        graph
      } else {
        g <- ggplot(dat, aes(x = UrbanPop, y = Rape))
        graph <- g + geom_point(color = "red") + labs(x = "Percentage of Urban Population", y = "Rape Arrests per 100,000 residents")
        graph
      }
      
  }
})
  
})
  
