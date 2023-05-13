
library(shiny)

# source("/../../r-scripts/regression_simulation.R")
# source("./r-scripts/regression_simulation.R")
source("regression_simulation.R")
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
      
      # slope coefficient of included variable ----
      sliderInput(inputId = "b1",
                  label = withMathJax(
                    'Slope coefficient \\(\\beta_1\\)'
                  ),
                  min = as.numeric(1),
                  max = as.numeric(3),
                  value = as.numeric(2),
                  step = 0.5),
      
      # sample size ----
      sliderInput(inputId = "nn",
                  label = withMathJax(
                    'Sample Size \\(N\\)'
                  ),
                  min = as.numeric(1),
                  max = as.numeric(100),
                  value = as.numeric(11),
                  step = 1),
      
      # standard deviation of x1 ----
      sliderInput(inputId = "x1.sd",
                  label = withMathJax(
                    'Standard deviation of \\(X_1\\)'
                  ),
                  min = as.numeric(1),
                  max = as.numeric(20),
                  value = as.numeric(10),
                  step = 1),
      
      # standard deviation of u ----
      sliderInput(inputId = "u.sd",
                  label = withMathJax(
                    'Standard deviation of of \\(u\\)'
                  ),
                  min = as.numeric(1),
                  max = as.numeric(20),
                  value = as.numeric(10),
                  step = 1),

      tags$div(HTML("<span style='font-size: 14pt'>Omitted variable bias</span>")),
      
      # standard deviation of x2 ----
      sliderInput(inputId = "x2.sd",
                  label = withMathJax(
                    'Standard deviation of \\(X_2\\)'
                  ),
                  min = as.numeric(1),
                  max = as.numeric(20),
                  value = as.numeric(10),
                  step = 1),
      
      # slope coefficient of omitted variable ----
      sliderInput(inputId = "b2",
                  label = withMathJax(
                    'Slope coefficient \\(\\beta_2\\)'
                  ),
                  min = as.numeric(-3),
                  max = as.numeric(3),
                  value = as.numeric(1),
                  step = 1),
      
      # correlation between x2 and x1 ----
      sliderInput(inputId = "rho.21",
                  label = withMathJax(
                    'Correlation \\(\\rho_{X_2 X_1}\\)'
                  ),
                  min = as.numeric(-0.9),
                  max = as.numeric(0.9),
                  value = as.numeric(0),
                  step = 0.1),
      
      tags$div(HTML("<span style='font-size: 14pt'>Heteroskedasticity</span>")),
      
      # heteroskedasticity x1 and u ----
      sliderInput(inputId = "g0",
                  label = withMathJax(
                    'Heteroskedasticity \\(\\gamma_{0}\\)'
                  ),
                  min = as.numeric(-1),
                  max = as.numeric(1),
                  value = as.numeric(0),
                  step = 0.1),
      
      # heteroskedasticity x1 and u ----
      sliderInput(inputId = "g1",
                  label = withMathJax(
                    'Heteroskedasticity \\(\\gamma_{1}\\)'
                  ),
                  min = as.numeric(-1),
                  max = as.numeric(1),
                  value = as.numeric(0),
                  step = 0.1),
      
      tags$div(HTML("<span style='font-size: 14pt'>Instrument Variable Regression</span>")),
      
      # standard deviation of z ----
      sliderInput(inputId = "z.sd",
                  label = withMathJax(
                    'Standard deviation of \\(Z\\)'
                  ),
                  min = as.numeric(1),
                  max = as.numeric(20),
                  value = as.numeric(10),
                  step = 1),
      
      # correlation between x1 and z ----
      sliderInput(inputId = "rho.z1",
                  label = withMathJax(
                    'Instrument relevance \\(\\rho_{Z X_1}\\)'
                  ),
                  min = as.numeric(-1),
                  max = as.numeric(1),
                  value = as.numeric(0),
                  step = 0.05)
      
    ),

    # Main panel for displaying outputs ----
    mainPanel(

      fluidRow(
        
        column(12,
               
               # tags$hr(),

               # Blank line for vertical alignment
               tags$div(HTML("<span style='line-height: 5pt'>&nbsp;</span>")),
               
               tags$div(HTML("<span style='font-size: 18pt;'>Check the Effects</span>")),
               
               tags$hr(),
               
               # Output: Tabset
               tabsetPanel(type = "tabs",
                           tabPanel("Sample Draw",
                                    tags$br(),
                                    
                                    tags$div(HTML("<span style='font-size: 14pt;'>Scatterplot Sample Draw</span>")),
                                    
                                    plotOutput("Plot0101"),
                                    
                                    tags$div(HTML("<span style='font-size: 14pt;'>Scatterplot Unobservable Residulas</span>")),
                                    
                                    plotOutput("Plot0102"),
                                    
                                    ),
                           
                           tabPanel("Consistency",
                                    
                                    tags$br(),
                                    
                                    tags$div(HTML("<span style='font-size: 14pt;'>Histogram of the OLS estimator for the slope coefficient \\(\\beta_1\\)</span>")),
                                    
                                    plotOutput("Plot02")
                                    
                                    ),
                           
                           tabPanel("Asymptotic Normality",
                                    
                                    tags$br(),
                                    
                                    tags$div(HTML("<span style='font-size: 14pt;'>Histogram of the standardized OLS estimator for \\(\\beta_1\\)</span>")),
                                    
                                    plotOutput("Plot03")
                                    
                                    )
               )

        )
      )
    )
  )
)

# INPUTS FOR CHECKS! ----

# # source("./r-shiny/ols-case-xx/ols-case-xx-app/regression_simulation.R")
# source("regression_simulation.R")
# 
# input <- list()
# rr <- 1000
# input$nn <- 100
# b0 <- 1
# input$b1 <- 2
# input$b2 <- 1
# input$x1.sd <- 10
# input$x2.sd <- 10
# input$z.sd <- 10
# input$u.sd <- 10
# input$rho.21 <- 0
# input$rho.z1 <- 0
# input$g0 <- 0
# input$g1 <- 0

# Define server logic for random distribution app ----
server <- function(input, output) {

  Sim <- reactive({
    
    # inputs
    rr <- 1000
    nn <- input$nn
    b0 <- 1
    b1 <- input$b1
    b2 <- input$b2
    x1.sd <- input$x1.sd
    x2.sd <- input$x2.sd
    z.sd <- input$z.sd
    u.sd <- input$u.sd
    rho.21 <- input$rho.21
    rho.z1 <- input$rho.z1
    g0 <- input$g0
    g1 <- input$g1

    # simulation
    tmp.sim <- bet_hat_sim_fun(rr = rr, nn = nn,
                               b0 = b0, b1 = b1, b2 = b2,
                               x1.sd = x1.sd, x2.sd = x2.sd, z.sd = z.sd, u.sd = u.sd,
                               rho.21 = rho.21, rho.z1 = rho.z1,
                               g0 = g0, g1 = g1)
    
    tmp.sim
    
  })

  output$Plot0101 <- renderPlot({
    
    # inputs
    rr <- 1000
    nn <- input$nn
    b0 <- 1
    b1 <- input$b1
    b2 <- input$b2
    x1.sd <- input$X1.int
    x2.sd <- 20
    z.sd <- 1
    u.sd <- input$u.sd
    ux.sd <- input$ux.sd
    rho.21 <- input$rho.21
    rho.z1 <- input$rho.z1
    g0 <- input$g0
    g1 <- input$g1
    
    # reactive
    tmp.sim <- Sim()
    
    # prepare plot
    x.axi.tic.01 <- seq(-30, 30, 5)
    x.axi.tic.02 <- seq(-30, 30, 5)
    
    y.axi.tic.01 <- seq(-70, 70, 10)
    y.axi.tic.02 <- seq(-70, 70, 5)
    
    main <- ""
    sub <- ""
    xlab <- ""
    ylab <- ""
    x.mar <- 0
    y.mar <- 0
    par.inp <- NULL
    
    plot_new_fun_xx(x.axi.tic.01, x.axi.tic.02, y.axi.tic.01, y.axi.tic.02,
                    main = "", sub = "", xlab = "", ylab = "",
                    x.mar = 0, y.mar = 0,
                    par.inp = NULL, date = FALSE)
    
    lines(x = tmp.sim$x1, y = tmp.sim$y, type = "p", col = "red")
    
    lines(x = tmp.sim$x1, y = (tmp.sim$y - b2 * tmp.sim$x2), type = "p", col = "darkgreen") # correct/unobserved relationship
    
    fun_01 <- function(x) {
      y <- tmp.sim$fit.01$coefficients[1] + tmp.sim$fit.01$coefficients[2] * x
      y[which(y <= min(c(y.axi.tic.01, y.axi.tic.02)))] <- NA
      y[which(y >= max(c(y.axi.tic.01, y.axi.tic.02)))] <- NA
      y
    }
    
    curve(fun_01, from = min(c(x.axi.tic.01, x.axi.tic.02)), to = max(c(x.axi.tic.01, x.axi.tic.02)), lty = 2, col = "darkgreen", lwd = 2, add = TRUE)

    fun_02 <- function(x) {
      y <- tmp.sim$fit.02$coefficients[1] + tmp.sim$fit.02$coefficients[2] * x
      y[which(y <= min(c(y.axi.tic.01, y.axi.tic.02)))] <- NA
      y[which(y >= max(c(y.axi.tic.01, y.axi.tic.02)))] <- NA
      y
    }
    
    curve(fun_02, from = min(c(x.axi.tic.01, x.axi.tic.02)), to = max(c(x.axi.tic.01, x.axi.tic.02)), lty = 2, col = "red", lwd = 2, add = TRUE)
    
  })
  
  # population residuals
  output$Plot0102 <- renderPlot({
    
    # inputs
    rr <- 1000
    nn <- input$nn
    b0 <- 1
    b1 <- input$b1
    b2 <- input$b2
    x1.sd <- input$X1.int
    x2.sd <- 20
    z.sd <- 1
    u.sd <- input$u.sd
    ux.sd <- input$ux.sd
    rho.21 <- input$rho.21
    rho.z1 <- input$rho.z1
    g0 <- input$g0
    g1 <- input$g1
    
    # reactive
    tmp.sim <- Sim()
    
    # prepare plot
    x.axi.tic.01 <- seq(-30, 30, 5)
    x.axi.tic.02 <- seq(-30, 30, 5)

    y.axi.tic.01 <- seq(-30, 30, 10)
    y.axi.tic.02 <- seq(-30, 30, 5)

    main <- ""
    sub <- ""
    xlab <- ""
    ylab <- ""
    x.mar <- 0
    y.mar <- 0
    par.inp <- NULL
    
    plot_new_fun_xx(x.axi.tic.01, x.axi.tic.02, y.axi.tic.01, y.axi.tic.02,
                    main = "", sub = "", xlab = "", ylab = "",
                    x.mar = 0, y.mar = 0,
                    par.inp = NULL, date = FALSE)
    
    lines(x = tmp.sim$x1, y = tmp.sim$res.01, type = "p", col = "red")
    
    lines(c(min(c(x.axi.tic.01, x.axi.tic.02)), max(c(x.axi.tic.01, x.axi.tic.02))), c(0, 0), lty = 2, lwd = 2)
    
    fun_03 <- function(x) {
      y <- tmp.sim$fit.05$coefficients[1] + tmp.sim$fit.05$coefficients[2] * x
      y[which(y <= min(c(y.axi.tic.01, y.axi.tic.02)))] <- NA
      y[which(y >= max(c(y.axi.tic.01, y.axi.tic.02)))] <- NA
      y
    }
    
    curve(fun_03, from = min(c(x.axi.tic.01, x.axi.tic.02)), to = max(c(x.axi.tic.01, x.axi.tic.02)), lty = 2, col = "red", lwd = 2, add = TRUE)
    
  })
  
  output$Plot02 <- renderPlot({
    
    # inputs
    rr <- 1000
    nn <- input$nn
    b0 <- 1
    b1 <- input$b1
    b2 <- input$b2
    x1.sd <- input$x1.sd
    x2.sd <- input$x2.sd
    z.sd <- input$z.sd
    u.sd <- input$u.sd
    rho.21 <- input$rho.21
    rho.z1 <- 0
    g0 <- input$g0
    g1 <- input$g1
    
    # reactive
    tmp.sim <- Sim()
    
    # prepare plot
    x.axi.tic.01 <- seq(-6, 6, 1.0)
    x.axi.tic.02 <- seq(-6, 6, 0.5)
    
    y.axi.tic.01 <- seq(0, 5, 0.5)
    y.axi.tic.02 <- seq(0, 5, 1)
    
    main <- ""
    sub <- ""
    xlab <- ""
    ylab <- ""
    x.mar <- 0
    y.mar <- 0
    par.inp <- NULL
    
    plot_new_fun_xx(x.axi.tic.01, x.axi.tic.02, y.axi.tic.01, y.axi.tic.02,
                    main = "", sub = "", xlab = "", ylab = "",
                    x.mar = 0, y.mar = 0,
                    par.inp = NULL, date = FALSE)
    
    h1 <- hist(x = tmp.sim$b1h, freq = FALSE, plot = FALSE)
    
    # plot h1
    nB <- length(h1$breaks)
    rect(h1$breaks[-nB], 0, h1$breaks[-1L], h1$density, col = scales::alpha("red", 0.25))
    
    # line for mean population parameter
    lines(c(b1, b1), c(min(c(y.axi.tic.01, y.axi.tic.02)), max(c(y.axi.tic.01, y.axi.tic.02))), lty = 2, col = "darkgreen", lwd = 2)
    
    lines(c(tmp.sim$b1h.boot.mea, tmp.sim$b1h.boot.mea), c(min(c(y.axi.tic.01, y.axi.tic.02)), max(c(y.axi.tic.01, y.axi.tic.02))), lty = 2, col = "red", lwd = 2)
    
    # legend
    legend("topleft",
           legend = "Population coefficient",
           lty = 2,
           lwd = 1,
           col = "red",
           inset = 0.05)

  })
  
  output$Plot03 <- renderPlot({
    
    # inputs
    rr <- 1000
    nn <- input$nn
    b0 <- 1
    b1 <- input$b1
    b2 <- input$b2
    x1.sd <- input$x1.sd
    x2.sd <- input$x2.sd
    z.sd <- input$z.sd
    u.sd <- input$u.sd
    rho.21 <- input$rho.21
    rho.z1 <- input$rho.z1
    g0 <- input$g0
    g1 <- input$g1
    
    # reactive
    tmp.sim <- Sim()
    
    # prepare plot
    x.axi.tic.01 <- seq(-5, 5, 1.0)
    x.axi.tic.02 <- seq(-5, 5, 0.5)
    
    y.axi.tic.01 <- seq(0, 0.5, 0.10)
    y.axi.tic.02 <- seq(0, 0.5, 0.05)
    
    main <- ""
    sub <- ""
    xlab <- ""
    ylab <- ""
    x.mar <- 0
    y.mar <- 0
    par.inp <- NULL
    
    plot_new_fun_xx(x.axi.tic.01, x.axi.tic.02, y.axi.tic.01, y.axi.tic.02,
                    main = "", sub = "", xlab = "", ylab = "",
                    x.mar = 0, y.mar = 0,
                    par.inp = NULL, date = FALSE)
        
    # generate histogram of estimator
    h1 <- hist(x = tmp.sim$b1h.z, freq = FALSE, plot = FALSE)
    h2 <- hist(x = tmp.sim$b1h.z.ord, freq = FALSE, plot = FALSE)
    
    # plot h1
    nB <- length(h1$breaks)
    rect(h1$breaks[-nB], 0, h1$breaks[-1L], h1$density, col = scales::alpha("darkgreen", 0.25))
    
    # plot h2
    nB <- length(h2$breaks)
    rect(h2$breaks[-nB], 0, h2$breaks[-1L], h2$density, col = scales::alpha("red", 0.25))
    
    # pdf for normal distribution
    curve(dnorm(x, mean = 0, sd = 1), -5, 5,
          lty = 2,
          lwd = 2, 
          xlab = "", 
          ylab = "",
          add = TRUE,
          col = "black")
    
    # legend
    legend("topright",
           legend = c("Standard Normal PDF"),
           lty = c(2, 2),
           lwd = c(1, 1),
           col = c("darkgreen"),
           inset = 0.05)
    
    
  })
  
}

# Create Shiny app ----
shinyApp(ui, server)
