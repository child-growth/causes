# Note, this app can't be developed in bluevelvet.

rm(list=ls())

library(shiny)
library(tidyverse)
library(rsconnect)
library(xlsx)

# load data
data <- readRDS("all_forest_plot_RR.RDS") %>% filter()
keys <- read.xlsx("keys.xlsx", 1, header=FALSE)
df <- merge(x = data, 
            y = keys, 
            by.x = "intervention_variable", 
            by.y = "X1", all = T) %>%
  rename(intervention = intervention_variable,
         intervention_variable = X2)

# options shown in dropdown menu
intervention_options <- dplyr::count(df, intervention_variable, sort = TRUE)[1]
outcome_options <- dplyr::count(df, outcome_variable, sort = TRUE)[1]
age_options <- dplyr::count(df, agecat, sort = TRUE)[1]

ui <- fluidPage(
  titlePanel("Relative Risk Forest Plots"),
  
  sidebarLayout(
    sidebarPanel(
      
      selectizeInput(
        'exposure', 'Pick an exposure:', choices = intervention_options,
        options = list(
          placeholder = 'Please select an option below',
          onInitialize = I('function() { this.setValue(""); }')
        )
      ),
      selectizeInput(
        'outcome', 'Pick an outcome:', choices = outcome_options,
        options = list(
          placeholder = 'Please select an option below',
          onInitialize = I('function() { this.setValue(""); }')
        )
      ),
      selectizeInput(
        'age', 'Pick an age:', choices = age_options,
        options = list(
          placeholder = 'Please select an option below',
          onInitialize = I('function() { this.setValue(""); }')
        )
      ),
      
      h5("Note: No plot will be displayed with invalid inputs."),
      
      h5("Options in the dropdown menu are dynamically updated based on your variable selections. 
         To clear a selection, click in the box and hit the 'backspace' key")
    ),
    mainPanel(
      plotOutput("selected_plot")
    )
  )
)

server <- function(input, output, clientData, session) {
  
  #observes user's inputs and dynamically updates dropdown selection for variables without any inputs
  observe({
    
    # current_input
    c_exposure <- input$exposure
    c_outcome <- input$outcome
    c_age <- input$age

    if (c_exposure != "" & c_outcome == "" & c_age == "") {
      filtered_df <- df %>% filter(intervention_variable == c_exposure)

      updated_outcome_options <- dplyr::count(filtered_df, outcome_variable, sort = TRUE)[1]
      updated_age_options <- dplyr::count(filtered_df, agecat, sort = TRUE)[1]

      updateSelectizeInput(session, "outcome", choices = updated_outcome_options)
      updateSelectizeInput(session, "age", choices = updated_age_options)
    }

    if (c_exposure == "" & c_outcome != "" & c_age == "") {
      filtered_df <- df %>% filter(outcome_variable == c_outcome)

      updated_intervention_options <- dplyr::count(filtered_df, intervention_variable, sort = TRUE)[1]
      updated_age_options <- dplyr::count(filtered_df, agecat, sort = TRUE)[1]

      updateSelectizeInput(session, "exposure", choices = updated_intervention_options)
      updateSelectizeInput(session, "age", choices = updated_age_options)
    }

    if (c_exposure == "" & c_outcome == "" & c_age != "") {
      filtered_df <- df %>% filter(agecat == c_age)

      updated_outcome_options <- dplyr::count(filtered_df, outcome_variable, sort = TRUE)[1]
      updated_intervention_options <- dplyr::count(filtered_df, intervention_variable, sort = TRUE)[1]

      updateSelectizeInput(session, "outcome", choices = updated_outcome_options)
      updateSelectizeInput(session, "exposure", choices = updated_intervention_options)
    }

    if (c_exposure != "" & c_outcome != "" & c_age == "") {
      filtered_df <- df %>% filter(intervention_variable == c_exposure & outcome_variable == c_outcome)
      updated_age_options <- dplyr::count(filtered_df, agecat, sort = TRUE)[1]
      updateSelectizeInput(session, "age", choices = updated_age_options)
    }

    if (c_exposure != "" & c_outcome == "" & c_age != "") {
      filtered_df <- df %>% filter(intervention_variable == c_exposure & agecat == c_age)
      updated_outcome_options <- dplyr::count(filtered_df, outcome_variable, sort = TRUE)[1]
      updateSelectizeInput(session, "outcome", choices = updated_outcome_options)
    }

    if (c_exposure == "" & c_outcome != "" & c_age != "") {
      filtered_df <- df %>% filter(outcome_variable == c_outcome & agecat == c_age)
      updated_intervention_options <- dplyr::count(filtered_df, intervention_variable, sort = TRUE)[1]
      updateSelectizeInput(session, "exposure", choices = updated_intervention_options)
    }

  })
  
  # runs when inputs for all 3 variables are present
  datasetInput <- reactive({
    df %>% filter(intervention_variable == input$exposure & 
                    outcome_variable == input$outcome & 
                    agecat == input$age)
  })
  
  # outputs plot based on selected inputs
  output$selected_plot <- renderPlot({
    dataset <- datasetInput()
    dataset$plot
  })
}

shinyApp(ui, server)
