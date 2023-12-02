#
# This is a modified default shiny app using the old faithful geyser data. It was made for the 2023 Cold Spring Harbor Laboratory Computational Genomics Workshop.

library(shiny)
library(ggplot2)
library(bslib)

# Define UI for application that draws a histogram
ui <- fluidPage(theme = bs_theme(version = 4, bootswatch = "minty"),

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
      
      #ggplot instead of base R
      ggplot(data=faithful, aes(x=waiting, stat="identity")) +
        geom_histogram(bins = input$bins, fill="darkgrey") +
        xlab("Waiting time to next eruption (min)") +
        ylab("Frequency") +
        theme(axis.text = element_text(size=18),
              axis.title = element_text(size=18),
              panel.background = element_rect(fill = "white"),
              panel.border = element_rect(colour = "black", fill=NA),
              panel.grid.major = element_line(size = 0.25, linetype = 'solid',
                                              colour = "grey"))

    })
}

# Run the application 
shinyApp(ui = ui, server = server)
