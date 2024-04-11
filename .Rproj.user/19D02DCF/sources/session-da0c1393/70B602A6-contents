library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)

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
      plotlyOutput("scatterplot")
    )
  )
)

# Define server logic
server <- function(input, output) {
  output$scatterplot <- renderPlotly({
    filtered_data <- subset(cook_data, age >= input$age_range[1] & age <= input$age_range[2])
    
    # Check if filtered_data is not empty
    if(nrow(filtered_data) == 0) {
      return(NULL)
    }
  
      
    # Create the scatter plot with plot_ly
    p <- plot_ly(data = filtered_data, x = ~cookingskills, y = ~age, color = ~Gender, text = ~paste("Gender: ", Gender, "<br>Age: ", age, "<br>Cooking Skills: ", cookingskills)) %>%
      add_markers() %>%
      layout(title = "Cooking Skills and Age by Gender",
             xaxis = list(title = "Cooking Skills"),
             yaxis = list(title = "Age"),
             hoverlabel = list(bgcolor = "white", font = list(size = 12)),
             margin = list(l = 100, r = 100, b = 100, t = 100),
             legend = list(x = 0.9, y = 0.9)) # Adjust legend position
    
    # Return the plotly object
    p
  })
}

# Run the application
shinyApp(ui = ui, server = server)


