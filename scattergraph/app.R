library(shiny)
library(ggplot2)
library(dplyr)
library(tidyr)
library(tidyverse)
library(readr)

cook_data <- read_csv("cooking_skills.csv")
View(cook_data)

ui <- fluidPage(
  titlePanel("Cooking Skills and Age by Gender"),
  sidebarLayout(
    sidebarPanel(sliderInput("age_range", "Select Age Range:",
                  min = 18, max = 50, value = c(18, 50))),
    mainPanel(plotOutput("scatterplot"))
  )
)

server <- function(input, output) {
  output$scatterplot <- renderPlot({
    
    filtered_data <- subset(cook_data, age >= input$age_range[1] & age <= input$age_range[2])
    
    #scatter plot
    ggplot(filtered_data, aes(y = age, x = cookingskills, color = Gender)) +
      geom_point() +
      scale_x_continuous(breaks = seq(1, 10, by = 1)) + 
      scale_y_continuous(breaks = seq(18, 50, by = 2)) + 
      labs(y = "Age", x = "Cooking Skills",
           subtitle = "Younger women generally rate their cooking skills above average compared to their male counterparts.",
           caption = "data taken from Kaggle") +
      scale_color_manual(values = c("Male" = "blue", "Female" = "red")) + 
      theme_minimal()
  })
}

shinyApp(ui = ui, server = server)

