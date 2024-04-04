# Load required libraries
library(shiny)
library(ggplot2)

# Define UI
ui <- fluidPage(
  titlePanel("Line Graphs"),
  sidebarLayout(
    sidebarPanel(
      # Add any sidebar inputs if needed
    ),
    mainPanel(
      plotOutput("lineplot_loneliness"),
      plotOutput("lineplot_work")
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  # Print summary of loneliness_long dataset
  output$summary_loneliness <- renderPrint({
    summary(loneliness_long)
  })
  
  # Print summary of work_long dataset
  output$summary_work <- renderPrint({
    summary(work_long)
  })
  
  # Create line graph for loneliness_long dataset
  output$lineplot_loneliness <- renderPlot({
    ggplot(loneliness_long, aes(x = Time_Period, group = Time_Period)) +
      geom_line(aes(y = `Mean average`), color = "blue") +
      geom_line(aes(y = `Lower Interval`), color = "red", linetype = "dashed") +
      geom_line(aes(y = `Upper Interval`), color = "red", linetype = "dashed") +
      labs(title = "Loneliness", x = "Time Period", y = "Value") +
      theme_minimal()
  })
  
  
  # Create line graph for work_long dataset
  output$lineplot_work <- renderPlot({
    ggplot(work_long, aes(x = Interval_Type)) +
      geom_line(aes(y = `Mean average`), color = "blue") +
      geom_line(aes(y = `Lower Interval`), color = "red", linetype = "dashed") +
      geom_line(aes(y = `Upper Interval`), color = "red", linetype = "dashed") +
      labs(title = "Work", x = "Interval Type", y = "Value") +
      theme_minimal()
  })
  
}

# Run the application
shinyApp(ui = ui, server = server)

