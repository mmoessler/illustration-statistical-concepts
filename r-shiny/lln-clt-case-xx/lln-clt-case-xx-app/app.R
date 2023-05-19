
library(shiny)

source("simulation.R")
source("plot_functions.R")

# Define UI for random distribution app ----
ui <- fluidPage(

  # App title ----
  # titlePanel("OLS: Case 1"),

  # Sidebar layout with input and output definitions ----
  sidebarLayout(

    # Sidebar panel for inputs ----
    sidebarPanel(

      # tags$hr(),
      
      # tags$h3("Change the inputs"),
      tags$div(HTML("<span style='font-size: 18pt'>Change the Inputs</span>")),
      
      tags$hr(),
      
      # sample size ----
      sliderInput(inputId = "nn",
                  label = withMathJax(
                    'Sample Size \\(N\\)'
                  ),
                  min = as.numeric(1),
                  max = as.numeric(100),
                  value = as.numeric(11),
                  step = 1),
      
      # minimum a ----
      sliderInput(inputId = "a",
                  label = withMathJax(
                    'Minimum \\(a\\)'
                  ),
                  # min = as.numeric(-10),
                  # max = as.numeric(-1),
                  min = as.numeric(1),
                  max = as.numeric(1),
                  value = as.numeric(1),
                  step = 1),
      
      # maximum b ----
      sliderInput(inputId = "b",
                  label = withMathJax(
                    'Maximum \\(b\\)'
                  ),
                  # min = as.numeric(1),
                  # max = as.numeric(10),
                  min = as.numeric(1.1),
                  max = as.numeric(100),
                  value = as.numeric(1.1),
                  step = 0.1)
      
    ),

    # Main panel for displaying outputs ----
    mainPanel(

      fluidRow(
        
        column(12,
               
               # blank line for vertical alignment
               tags$div(HTML("<span style='line-height: 5pt'>&nbsp;</span>")),
               
               tags$div(HTML("<span style='font-size: 18pt;'>Check the Effects</span>")),
               
               tags$hr(),
               
               # tabs
               tabsetPanel(type = "tabs",
                           tabPanel("Sample Draw",
                                    
                                    tags$br(),
                                    
                                    tags$div(HTML("<span style='font-size: 14pt;'>Histrogram Sample Draws</span>")),

                                    plotOutput("Plot01")
                                    
                                    ),
                           
                           tabPanel("Consistency",
                                    
                                    tags$br(),
                                    
                                    tags$div(HTML("<span style='font-size: 14pt;'>Histogram of the Sample Average \\(\\overline{Y}\\)</span>")),
                                    
                                    plotOutput("Plot02")
                                    
                                    ),
                           
                           tabPanel("Asymptotic Normality",
                                    
                                    tags$br(),
                                    
                                    tags$div(HTML("<span style='font-size: 14pt;'>Histogram of the Standardized Sample Average \\(z_{\\overline{Y}}\\)</span>")),
                                    
                                    plotOutput("Plot03")
                                    
                                    )
               )

        )
      )
    )
  )
)

# INPUTS FOR CHECKS! ----

# source("./r-shiny/lln-clt-case-xx/lln-clt-case-xx-app/simulation.R")
# 
# input <- list()
# rr <- 1000
# input$nn <- 100
# input$a <- -3
# input$b <- 3

# Define server logic for random distribution app ----
server <- function(input, output) {

  Sim <- reactive({
    
    # inputs
    rr <- 1000
    nn <- input$nn
    a <- input$a
    b <- input$b

    # simulation
    tmp.sim <- Y_bar_uni_sim_fun(RR = rr, NN = nn, a = a, b = b)
    
    tmp.sim
    
  })

  # plot 01 ----
  output$Plot01 <- renderPlot({
    
    # inputs
    rr <- 1000
    nn <- input$nn
    a <- input$a
    b <- input$b

    # reactive
    tmp.sim <- Sim()
    
    # fit linear model
    lm.tmp <- lm(tmp.sim$Y.sim ~ 1)
    
    # construct histogram
    x <- hist(x = tmp.sim$Y.sim,
              freq = FALSE,
              plot = FALSE)
    
    # plot histogram
    main <- c("")
    sub <- c("")
    xlab <- c("")
    ylab <- c("Relative Frequency")
    
    xlim <- c(-4, 4)
    ylim <- c(0, 1)
    
    plot.new()
    plot.window(xlim, ylim, "")
    title(main = main, sub = sub, xlab = xlab, ylab = ylab)
    axis(1)
    axis(2)
    
    grid()
    
    nbx <- length(x$breaks[which(x$counts > 0)])
    rect(x$breaks[c(which(x$counts > 0), which(x$counts > 0)[nbx] + 1)][-(nbx+1)], 0, x$breaks[c(which(x$counts > 0), which(x$counts > 0)[nbx] + 1)][-1L], x$density[which(x$counts > 0)],
         col = "grey")
    
    # add vertical line for mean
    abline(v = 1/2 * (a + b), lty = 2, col = "red", lwd = 2)
    
    # legend
    legend("topright",
           legend = c(expression("Value of "*mu)),
           lty = 2,
           lwd = 1,
           col = "red",
           inset = 0.05)
    
    # add blank rectangle
    rect.xleft.01 <- -3.5
    rect.xright.01 <- -2.5
    rect.ybottom.01 <- 0.75
    rect.ytop.01 <- 0.95
    
    rect(xleft = rect.xleft.01, ybottom = rect.ybottom.01, xright = rect.xright.01, ytop = rect.ytop.01, col = "white")
    
    # add mu text
    text.x.01 <- -3
    text.y.01 <- 0.9
    
    text(x = text.x.01, y = text.y.01,
         bquote(bar(Y) ~" " == .(format(round(summary(lm.tmp)$coefficients[1,1], 3), nsmall = 3))),
         cex = 1.25)
    
    # add sigma text
    text.x.02 <- -3
    text.y.02 <- 0.8
    
    text(x = text.x.02, y = text.y.02,
         bquote(widehat(sigma)[~bar(Y)] == .(format(round(summary(lm.tmp)$coefficients[1,2], 3), nsmall = 3))),
         cex = 1.25)
    
  })
  
  # plot 02 -----
  output$Plot02 <- renderPlot({
    
    # inputs
    rr <- 1000
    nn <- input$nn
    a <- input$a
    b <- input$b

    # reactive
    tmp.sim <- Sim()
    
    # generate histogram of estimator
    x <- hist(x = tmp.sim$Y.bar,
              freq = FALSE,
              plot = FALSE)
    
    # plot histogram of estimator
    main <- c("")
    sub <- c("")
    xlab <- c("")
    ylab <- c("Absolute Frequency")
    
    xlim <- c(-6, 6)
    ylim <- c(0, 8)
    
    plot.new()
    plot.window(xlim, ylim, "")
    title(main = main, sub = sub, xlab = xlab, ylab = ylab)
    axis(1)
    axis(2)
    
    grid()
    
    nbx <- length(x$breaks[which(x$counts > 0)])
    rect(x$breaks[c(which(x$counts > 0), which(x$counts > 0)[nbx] + 1)][-(nbx+1)], 0, x$breaks[c(which(x$counts > 0), which(x$counts > 0)[nbx] + 1)][-1L], x$density[which(x$counts > 0)],
         col = "grey")
    
    # add line for mean population parameter
    abline(v = 1/2 * (a + b), lty = 2, col = "red", lwd = 2)
    
    # legend
    legend("topright",
           # legend = "Probability of Success",
           legend = c(expression("Value of "*italic("p"))),
           lty = 2,
           lwd = 1,
           col = "red",
           inset = 0.05)
    
  })
  
  # plot 03 ----
  output$Plot03 <- renderPlot({
    
    # inputs
    rr <- 1000
    nn <- input$nn
    a <- input$a
    b <- input$b

    # reactive
    tmp.sim <- Sim()
    
    # construct histogram
    x <- hist(x = tmp.sim$Y.bar.z,
              freq = FALSE,
              plot = FALSE)
    
    # plot histogram
    main <- c("")
    sub <- c("")
    xlab <- c("")
    ylab <- c("Relative Frequency")
    
    xlim <- c(-6, 6)
    ylim <- c(0, 0.5)
    
    plot.new()
    plot.window(xlim, ylim, "")
    title(main = main, sub = sub, xlab = xlab, ylab = ylab)
    axis(1)
    axis(2)
    
    grid()
    
    nB <- length(x$breaks)
    rect(x$breaks[-nB], 0, x$breaks[-1L], x$density, col = scales::alpha("grey", 0.25))

    # add standard normal density curve
    curve(dnorm(x, mean = 0, sd = 1), -6, 6,
          xlim = c(-3,3), 
          ylim=c(0,0.6),
          lty = 2,
          lwd = 2, 
          xlab = "", 
          ylab = "",
          add = TRUE,
          col = "red")
    
    # legend
    legend("topright",
           legend = c(expression("pdf of "*italic("N")*"(0,1)")),
           lty = 2,
           lwd = 1,
           col = "red",
           inset = 0.05)
    
  })
  
}

# Create Shiny app ----
shinyApp(ui, server)
