library(shiny)
library(tidyverse)
library(dplyr)
library(DT)
library(shinyWidgets)
library(rsconnect)

ikea <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-11-03/ikea.csv')
ikea <- ikea %>% mutate(discount = ifelse(old_price == "No old price", "On sale", "NOT on sale"))
ikea <- ikea %>% mutate(depth = ifelse(is.na(depth), "NA", depth),
                        height = ifelse(is.na(height), "NA", height),
                        width = ifelse(is.na(width), "NA", width))
price_range <- range(ikea$price)

# Define UI for application
ui <- fluidPage(


  tags$head(
    tags$link(
      rel = "stylesheet",
      href = "https://fonts.googleapis.com/css2?family=FuturaPress&display=swap" # Link to Google Fonts of Ikea font
    ),

    # Apply IKEA font and theme colour
    tags$style(
      HTML("
        body {
          background: linear-gradient(to bottom, #C5873A, #D19F61);
          font-family: 'FuturaPress', sans-serif;
        }

        /* Styling for the side panel */
    .sidebar {
      background-color: #eeeee4;
    }

    /* Styling for the data tables */
    .dataTables_wrapper {
      background-color: #eeeee4;
    }
      ")
    )
  ),

  titlePanel(tags$h1("IKEA Furniture - Browse Your Sweet Palace",
                     style = "color:  #21130d;
           font-weight: bold")),

  navbarPage("IKEA Furniture",
             tabPanel("Items",
                      sidebarLayout(
                        sidebarPanel(
                          # Drop-down list of categories to choose from
                          selectizeInput("category",
                                         label = "Select Category",
                                         choices = unique(ikea$category)),

                          # Select a price range for the items will be shown
                          sliderInput("slider",
                                      label = "Price",
                                      min = price_range[1],
                                      max = price_range[2],
                                      value = price_range,
                                      step = 1),

                          # Choose whether you want discounted item or not
                          radioGroupButtons("discount", "Select one",
                                            choices = c("On sale", "NOT on sale", "Show all"),
                                            checkIcon = list(yes = icon("check"), empty = icon("times"))),

                          # Show items regarding to all above selections
                          dataTableOutput("itemtable"),

                          # Select item based on the name in the chosen category
                          selectizeInput("selected_items", label = "Select Items",
                                         choices = NULL, multiple = TRUE),

                          # Select item ID based on the chosen category and item name
                          selectizeInput("selected_id", label = "Select ID",
                                         choices = NULL, multiple = TRUE)
                        ),

                        # show item regards to name and id
                        mainPanel(
                          dataTableOutput("comparison_table")


                        )
                      )),
             tabPanel("About",
                      uiOutput("about")))


)

# Define server logic
server <- function(input, output, session) {

  # filter ikea data regarding to inputs
  filtered_data <- reactive({
    category_filtered <- ikea %>%
      filter(category == input$category) %>%
      filter(price > input$slider[1], price < input$slider[2]) %>%
      filter(discount == ifelse(input$discount == "Show all", discount, input$discount)) %>%
      arrange(desc(price)) %>%
      select(item_id, name, price, discount)
    return(category_filtered)
  })

  # Update item names only shown in filtered data
  observe({
    updateSelectizeInput(session, "selected_items",
                         choices = unique(filtered_data()$name),
                         selected = NULL)
  })

  observe({
    item_id_choices <- ikea %>%
      filter(category == input$category,
             name %in% input$selected_items) %>%
      filter(price > input$slider[1], price < input$slider[2]) %>%
      filter(discount == ifelse(input$discount == "Show all", discount, input$discount)) %>%
      pull(item_id)

    updateSelectizeInput(session, "selected_id",
                         choices = item_id_choices,
                         selected = NULL)
  })

  # Render the item table on side panel
  output$itemtable <- renderDataTable({
    datatable(filtered_data(),
              options = list(pageLength = 5),
              colnames = c("Product ID", "Product Name", "Price", "Discount"))
  })

  # Render the comparison table based on selected items
  output$comparison_table <- renderDataTable({
    selected_items_filtered <- ikea %>%
      filter(category == input$category,
             name %in% input$selected_items,
             item_id %in% input$selected_id) %>%
      select(item_id, name, price, short_description, depth, height, width, link)

    datatable(selected_items_filtered,
              extensions = 'Buttons',
              options = list(pageLength = 5),
              colnames = c("Product ID", "Product Name", "Price", "Description", "Depth", "Height", "Width", "Link to product"))
  })

  output$about <- renderUI({

    knitr::knit("about.Rmd", quiet = TRUE) %>%
      markdown::markdownToHTML(fragment.only = TRUE) %>%
      HTML()

  })
}

# Run the application
shinyApp(ui = ui, server = server)
