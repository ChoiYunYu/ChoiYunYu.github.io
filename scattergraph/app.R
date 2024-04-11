library(shiny)
library(ggplot2)
library(dplyr)
library(readr)

# Load data
cook_data <- read_csv("cooking_skills.csv")

# Define UI
ui <- fluidPage(
  titlePanel("Cooking Skills and Age by Gender"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("age_range", "Select Age Range:", min = 18, max = 50, value = c(18, 50))
    ),
    mainPanel(
      plotOutput("scatterplot")
    )
  )
)

# Define server logic
server <- function(input, output) {
  output$scatterplot <- renderPlot({
    filtered_data <- cook_data %>%
      filter(age >= input$age_range[1] & age <= input$age_range[2])
    
    # Scatter plot
    ggplot(filtered_data, aes(x = cookingskills, y = age, color = Gender)) +
      geom_point() +
      scale_x_continuous(breaks = seq(1, 10, by = 1)) + 
      scale_y_continuous(breaks = seq(18, 50, by = 2)) + 
      labs(
        x = "Cooking Skills",
        y = "Age",
        subtitle = "Younger women generally rate their cooking skills above average compared to their male counterparts.",
        caption = "Data taken from Kaggle"
      ) +
      scale_color_manual(values = c("Male" = "blue", "Female" = "red")) + 
      theme_minimal()
  })
}

# Run the application
shinyApp(ui = ui, server = server)


