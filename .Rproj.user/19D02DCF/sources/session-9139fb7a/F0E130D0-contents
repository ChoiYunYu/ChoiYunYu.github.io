library(shiny)
library(ggplot2)

# Define UI
ui <- fluidPage(
  titlePanel("Cooking Skills Density Plot by Gender"),
  sidebarLayout(
    sidebarPanel(
      # Add any input widgets if needed
    ),
    mainPanel(
      plotOutput("density_plot")
    )
  )
)

# Define server logic
server <- function(input, output) {
  # Render the density plot
  output$density_plot <- renderPlot({
    # Assuming 'cook_data' is your dataset
    ggplot(cook_data, aes(x = `cooking skills`, fill = Gender)) +
      geom_density(alpha = 0.5) +  # Adjust transparency for better visualization
      labs(title = "Density Plot of Cooking Skills by Gender",
           x = "Cooking Skills", y = "Density") +  # Add titles and axis labels
      scale_fill_manual(values = c("blue", "red")) +  # Adjust fill colors for each gender
      theme_minimal()  # Apply a minimal theme for better readability
  })
}

# Run the Shiny app
shinyApp(ui = ui, server = server)

