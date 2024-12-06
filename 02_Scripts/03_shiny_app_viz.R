library(tidyverse)
library(tidyr)
library(ggplot2)
library(dbplyr)
library(broom)
library(lubridate)
library(countrycode)
library(sf)
library(rnaturalearth)
library(openxlsx)
library(plotly)

# Reading in data
unemp_dem <- read.csv("ACLED-unemployment-annual-1997-2023.csv") 
sub_region <- read.xlsx('sub_region_code.xlsx')

sub_region_simplified <- sub_region %>%
  select(sub_region_name, country_code)

# Merge datasets
merged_data <- unemp_dem %>%
  left_join(sub_region_simplified, by = "country_code")

# Download world map
world_map <- ne_download(scale = 110, type = "countries", category = "cultural", returnclass = "sf")

# Merge the datasets
map_data <- world_map %>%
  left_join(merged_data, by = c("ISO_A3" = "country_code"))

# Aggregating data for the line chart
sub_region_trend <- merged_data %>%
  group_by(sub_region_name, year) %>%
  summarise(
    incidents_per100k = mean(num_incidents_per100k_people, na.rm = TRUE),
    deaths_per100k = mean(num_deaths_per100k_people, na.rm = TRUE),
    unemployment_value = mean(unemployment_value, na.rm = TRUE),
    .groups = "drop"
  )

# UI
ui <- fluidPage(
  titlePanel("Sub-Region Heatmap and Line Chart"),
  sidebarLayout(
    sidebarPanel(
      helpText("Select filters to view data."),
      selectInput("sub_region", "Select Sub-Region:", 
                  choices = unique(merged_data$sub_region_name), 
                  selected = unique(merged_data$sub_region_name)[1]),
      selectInput("data_type", "Select Data Type:", 
                  choices = c("Unemployment" = "unemployment_value", 
                              "Incidents" = "num_incidents_per100k_people", 
                              "Deaths" = "num_deaths_per100k_people"), 
                  selected = "num_incidents_per100k_people"),
      sliderInput("year", "Select Year:", 
                  min = min(merged_data$year), 
                  max = max(merged_data$year), 
                  value = max(merged_data$year), 
                  step = 1, 
                  sep = "")
    ),
    mainPanel(
      plotlyOutput("heatmap"),
      plotlyOutput("line_chart")
    )
  )
)

server <- function(input, output) {
  
  # Title helper function
  get_friendly_title <- function(data_type, sub_region, year) {
    type_label <- switch(data_type,
                         unemployment_value = "Unemployment",
                         num_incidents_per100k_people = "Incidents",
                         num_deaths_per100k_people = "Deaths"
    )
    return(paste("Heatmap of", type_label, "in", sub_region, "for", year))
  }
  
  output$heatmap <- renderPlotly({
    # Filter data by sub-region, year, and selected data type
    filtered_data <- merged_data %>%
      filter(
        sub_region_name == input$sub_region,
        year == input$year
      ) %>%
      group_by(country_name) %>%
      summarise(
        avg_value = mean(!!sym(input$data_type), na.rm = TRUE), # Dynamically select data type
        .groups = "drop"
      )
    
    # Merge filtered data with world map geometries
    map_data <- world_map %>%
      left_join(filtered_data, by = c("ADMIN" = "country_name"))
    
    # Create the map plot
    map_plot <- ggplot(map_data) +
      geom_sf(aes(
        fill = avg_value,
        text = paste("Country:", ADMIN,
                     "<br>Avg Value:", round(avg_value, 2))
      ), color = "white", lwd = 0.2) +
      scale_fill_viridis_c(option = "C", na.value = "grey50") +
      theme_minimal() +
      labs(
        title = get_friendly_title(input$data_type, input$sub_region, input$year),
        fill = "Value"
      )+
      theme(
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.grid = element_blank(),
        plot.title = element_text(hjust = 0.5) 
      )
    
    ggplotly(map_plot, tooltip = "text")
  })
  
  
  
  output$line_chart <- renderPlotly({
    # Filter the data for the selected sub-region
    region_data <- sub_region_trend %>%
      filter(sub_region_name == input$sub_region)
    
    # Create the line chart directly with Plotly
    plot_ly(region_data, x = ~year) %>%
      add_lines(y = ~incidents_per100k, name = "Incidents per 100k", line = list(color = "blue")) %>%
      add_lines(y = ~deaths_per100k, name = "Deaths per 100k", line = list(color = "red")) %>%
      add_lines(y = ~unemployment_value, name = "Unemployment Rate", yaxis = "y2", line = list(dash = "dash", color = "green")) %>%
      layout(
        title = paste("Time Trend for Sub-Region:", input$sub_region),
        xaxis = list(title = ""), 
        yaxis = list(title = "Incidents and Deaths per 100k"),
        yaxis2 = list(
          title = "Unemployment Rate",
          overlaying = "y",
          side = "right"
        ),
        legend = list(
          orientation = "v", 
          x = 1.1, 
          y = 0.5,
          xanchor = "left"
        )
      )
  })
  
  
}


# Run the app
shinyApp(ui, server)
