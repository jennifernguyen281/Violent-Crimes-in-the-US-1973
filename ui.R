
library(shiny)

shinyUI(fluidPage(

    # Application title
    titlePanel("Violent Crime Rates by US State in 1973"),

    
    sidebarLayout(
        sidebarPanel(
          # a dropdown menu from which the user can select an US State
            selectInput("state",
                        "Choose a state: ",
                        choices = state.name, selected = "Alabama"),
          # User can choose which type of crime for the plot
            radioButtons("crime",
                         "Choose a type of crime: ",
                        c("Murder", "Assault","Rape")),
          # User can choose which plots she wants to see in the main panel
            radioButtons("plot_type",
                       "Choose a type of plot: ",
                       c("Crime rates of your choice across States", "Crime Rates vs. Percentage of Urban Population"))
            
        ),
        # Side panel code ENDS HERE
        # Main panel shows different tabs
        mainPanel(
          tabsetPanel(type = "tabs",
                      tabPanel("Description", p("This data set contains statistics, in arrests per 100,000 residents for assault,
                                                murder, and rape in each of the 50 US states in 1973. Also given is the percent of
                                                the population living in urban areas.")),
                      tabPanel("Summary", tableOutput("table")),
                      tabPanel("Plot", plotOutput("plot"))
                      
          )
        )
    )
))
