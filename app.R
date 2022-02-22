# Note, this app can't be developed in bluevelvet.

rm(list=ls())

library(shiny)
library(tidyverse)

d <- readRDS("/figures/risk-factor/figure-data/all_forest_plot_RR.RDS")
df <- d %>% filter()

intervention_options <- dplyr::count(df, intervention_variable, sort = TRUE)[1]
outcome_options <- dplyr::count(df, outcome_variable, sort = TRUE)[1]
age_options <- dplyr::count(df, agecat, sort = TRUE)[1]

ui <- fluidPage(
  titlePanel("Relative risk forest plots"),
  
  sidebarLayout(
    sidebarPanel(
      
      selectInput(
        "exposure", "Pick an exposure: ", intervention_options,
      ),
      selectInput(
        "outcome", "Pick an outcome: ", outcome_options,
      ),
      selectInput(
        "age", "Pick an age: ", age_options,
      ),
      
      h5("Note: No plot will be displayed with invalid inputs.")
      
    ),
    mainPanel(
      
      plotOutput("selected_plot")
      
    )
  )
)

server <- function(input, output, session) {
  
  datasetInput <- reactive({
    df %>% filter(intervention_variable == input$exposure & 
                    outcome_variable == input$outcome & 
                    agecat == input$age)
  })
  
  output$selected_plot <- renderPlot({
    dataset <- datasetInput()
    dataset$plot
  })
}

shinyApp(ui, server)
