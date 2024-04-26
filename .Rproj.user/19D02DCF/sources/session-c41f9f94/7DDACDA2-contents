library(shiny)
library(ggplot2)
library(plotly)

library(readr)
cook_data <- read_csv("cooking_skills.csv")

ui <- fluidPage(
  titlePanel("Marital Status and Cooking Skills"),
  sidebarLayout(
    sidebarPanel(
      #Checkboxes for marital status
      checkboxGroupInput("marital_status", "Marital Status:",
                         choices = c("Single", "Married", "Other"),
                         selected = c("Single", "Married", "Other")),
      #Checkboxes for gender
      checkboxGroupInput("gender", "Gender:",
                         choices = c("Male", "Female"),
                         selected = c("Male", "Female"))
    ),
    mainPanel(
      # Output: Grouped bar chart
      plotlyOutput("grouped_bar_chart")
    )
  )
)


server <- function(input, output) {
  #generate grouped bar chart
  output$grouped_bar_chart <- renderPlotly({
    # Subset data
    subset_data <- cook_data %>%
      filter(marital_status %in% input$marital_status, Gender %in% input$gender)
    
    # Define colors
    colors <- c("Single" = "lightgreen", "Married" = "pink", "Other" = "yellow")
    
    #grouped bar chart
    plot <- ggplot(subset_data, aes(x = factor(cookingskills), fill = factor(marital_status))) +
      geom_bar(position = "dodge", stat = "count") +
      scale_fill_manual(values = colors) +  # Set custom colors
      labs(x = "Cooking Skills", y = "Count", fill = "Marital Status") +
      ggtitle("Cooking Skills by Marital Status") +
      scale_y_continuous(breaks = seq(0, 60, by = 10))  # Set y-axis breaks
    
    plotly_object <- ggplotly(plot)
    
    #hover menu
    plotly_object <- plotly_object %>%
      layout(legend = list(orientation = "v", x = 1, y = 0.5)) %>%
      config(displayModeBar = FALSE)
    
    plotly_object
  })
}


shinyApp(ui = ui, server = server)
