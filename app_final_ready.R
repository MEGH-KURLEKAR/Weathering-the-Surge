options(shiny.maxRequestSize = 50*1024^2)

library(shiny)
library(tidyverse)
library(lubridate)
library(arrow)
library(readxl)

ui <- fluidPage(
  titlePanel("Energy Demand Forecast - Shiny App"),
  sidebarLayout(
    sidebarPanel(
      fileInput("file", "Upload Excel File (.xlsx)"),
      numericInput("n", "Number of rows to display:", 10),
      dateRangeInput("date_range", "Select Date Range:",
                     start = Sys.Date() - 30, end = Sys.Date() + 1),
      helpText("Note: The model predicts hourly energy usage (in kWh) based on input features such as temperature, square footage, and appliance data. Use the plot to understand how temperature influences consumption.")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Data Preview", tableOutput("data_head")),
        tabPanel("Driver Visualization", plotOutput("energy_plot")),
        tabPanel("Predictions",
                 downloadButton("downloadData", "Download Predictions"),
                 tableOutput("pred_table"),
                 plotOutput("prediction_plot")
        )
      )
    )
  )
)

server <- function(input, output) {
  
  data <- reactive({
    req(input$file)
    df <- read_excel(input$file$datapath) %>%
      rename(
        temp = `Dry Bulb Temperature [°C]`,
        energy = `out.total.energy`,
        sqft = in.sqft,
        occupants = in.occupants,
        stories = in.geometry_stories,
        hour = Hour,
        county = county
      ) %>%
      mutate(
        date_time = as.POSIXct(date_time),
        county = as.factor(county),
        hour = as.integer(hour)
      )
    return(df)
  })
  
  output$data_head <- renderTable({
    df <- data()
    head(df, input$n)
  })
  
  output$energy_plot <- renderPlot({
    df <- data()
    df_filtered <- df %>%
      filter(date_time >= input$date_range[1], date_time <= input$date_range[2])
    ggplot(df_filtered, aes(x = temp, y = energy)) +
      geom_point(alpha = 0.4, color = "blue") +
      geom_smooth(method = "loess", color = "red") +
      labs(title = "Energy Usage vs Temperature", x = "Temperature", y = "Energy Usage")
  })
  
  model <- reactive({
    readRDS("model.rds")
  })
  
  predictions <- reactive({
    df <- data()
    predict(model(), newdata = df)
  })
  
  output$pred_table <- renderTable({
    df <- data()
    df$Predicted_Energy <- predictions()
    df %>%
      select(temp, sqft, occupants, stories, hour, county, Predicted_Energy) %>%
      head(20)
  })
  
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("predictions-", Sys.Date(), ".csv", sep = "")
    },
    content = function(file) {
      df <- data()
      df$Predicted_Energy <- predictions()
      write.csv(df %>%
                  select(temp, sqft, occupants, stories, hour, county, Predicted_Energy),
                file, row.names = FALSE)
    }
  )
  
  output$prediction_plot <- renderPlot({
    df <- data()
    df$Predicted_Energy <- predictions()
    ggplot(df, aes(x = hour, y = Predicted_Energy)) +
      geom_point(alpha = 0.3, color = "purple") +
      geom_smooth(method = "loess", color = "black") +
      labs(title = "Predicted Energy Usage by Hour", x = "Hour of Day", y = "Predicted Energy (kWh)")
  })
}

shinyApp(ui = ui, server = server)