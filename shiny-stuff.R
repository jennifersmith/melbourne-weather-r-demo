source('step5-make-it-look-good.R')
library(shiny)
# Global variables can go here
n <- 200


# Define the UI
ui <- bootstrapPage(
  numericInput('n', 'Month', n),
  plotOutput('plot')
)


# Define the server code
server <- function(input, output) {
  output$plot <- renderPlot({
    show.month(input$n)
  })
}

# Return a Shiny app object
shinyApp(ui = ui, server = server)