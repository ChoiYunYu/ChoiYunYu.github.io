library(shiny)
library(ggplot2)

library(readr)
cook_data <- read_csv("cooking_skills.csv")

ui <- fluidPage(
  titlePanel("Cooking Skills Density Plot by Gender"),
    mainPanel(
      plotOutput("density_plot")
    )
  )

server <- function(input, output) {
  
  output$density_plot <- renderPlot({
    
    ggplot(cook_data, aes(x = `cookingskills`, fill = Gender)) +
      geom_density(alpha = 0.5) +  
      labs(title = "Density Plot of Cooking Skills by Gender",
           x = "Cooking Skills", y = "Density",
           caption = "Date taken from Kaggle",
           subtitle = "The density plot suggests more women self-assess their cooking skills higher") + 
      scale_fill_manual(values = c("green", "grey")) +
      theme_minimal() 
  })
}

shinyApp(ui = ui, server = server)
