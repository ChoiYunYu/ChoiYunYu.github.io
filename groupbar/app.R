library(shiny)
library(ggplot2)
library(plotly)

library(readr)
cook_data <- read_csv("cooking_skills.csv")

# Define UI
ui <- fluidPage(
  titlePanel("Marital Status and Cooking Skills"),
  sidebarLayout(
    sidebarPanel(
      # Input: Checkboxes for marital status
      checkboxGroupInput("marital_status", "Marital Status:",
                         choices = c("Single", "Married", "Other"),
                         selected = c("Single", "Married", "Other"))
    ),
    mainPanel(
      # Output: Grouped bar chart
      plotlyOutput("grouped_bar_chart")
    )
  )
)

# Define server logic
server <- function(input, output) {
  # Function to generate grouped bar chart
  output$grouped_bar_chart <- renderPlotly({
    # Subset data based on selected marital status
    subset_data <- subset(cook_data, marital_status %in% input$marital_status)
    
    # Define custom colors
    colors <- c("Single" = "lightgreen", "Married" = "pink", "Other" = "yellow")
    
    # Create grouped bar chart with custom colors
    plot <- ggplot(subset_data, aes(x = factor(cookingskills), fill = factor(marital_status))) +
      geom_bar(position = "dodge", stat = "count") +
      scale_fill_manual(values = colors) +  # Set custom colors
      labs(x = "Cooking Skills", y = "Count", fill = "Marital Status") +
      ggtitle("Cooking Skills by Marital Status") +
      scale_y_continuous(breaks = seq(0, 60, by = 10))  # Set y-axis breaks
    
    # Convert ggplot object to plotly
    plotly_object <- ggplotly(plot)
    
    # Add hover info
    plotly_object <- plotly_object %>%
      layout(legend = list(orientation = "v", x = 1, y = 0.5)) %>%
      config(displayModeBar = FALSE)
    plotly_object
  })
}


# Run the application
shinyApp(ui = ui, server = server)
