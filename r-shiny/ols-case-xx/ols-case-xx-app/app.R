
library(shiny)

# source("/../../r-scripts/regression_simulation.R")
# source("./r-scripts/regression_simulation.R")
source("regression_simulation.R")

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
                                    
                                    tags$div(HTML("
                                      <span style='font-size: 12pt;'>
                                      
                                        <hr>
                                      
                                        The data are generated by the following model
                                      
                                        \\begin{align}
                                        Y_{i} &= \\beta_{0} + \\beta_{1} X_{1i} + \\beta_{2} X_{2i} + u_{i} \\\\
                                        Y_{i} - \\beta_{1} X_{1i} &= \\beta_{0} + \\beta_{1} X_{1i} + u_{i} \\\\
                                        Y_{i}^{X_{2i}} &= \\beta_{0} + \\beta_{1} X_{1i} + u_{i}
                                        \\end{align}
                                        
                                        where \\(X_{2i}\\) is an omitted or unobserved variable and where \\(Y_{i}^{X_{2i}}\\) is \\(Y_{i}\\) without the effect of the omitted or unobservable variable. <br>
                                        
                                        Note, neither \\(X_{2i}\\) and thus, nor, \\(Y_{i}^{X_{2i}}\\) are observable to the econometrician. <br>
                                        
                                        <hr>
                                        
                                        The green dots are generated by the 'true' but 'not observable' relationship between \\(Y_{i}\\) and \\(X_{1i}\\), i.e., with controlling for \\(X_{2i}\\). <br>
                                        
                                        The red dots are generatey by the 'potentially false' but 'observable' relationship between \\(Y_{i}\\) and \\(X_{1i}\\), i.e., without controlling for \\(X_{2i}\\). <br>
                                        
                                        <hr>
                                        
                                        The green line is the fitted regression line to the green dots and represents the 'true' but 'not observable' relationship between \\(Y_{i}\\) and \\(X_{1i}\\), i.e., with controlling for \\(X_{2i}\\). <br>
                                        
                                        The red line is the fitted regression line to the red dots and represents 'potentially false' but 'observable' relationship between \\(Y_{i}\\) and \\(X_{1i}\\), i.e., without controlling for \\(X_{2i}\\). <br>

                                        <hr>
                                        
                                      </span>
                                    ")),
                                    
                                    tags$div(HTML("<span style='font-size: 14pt;'>Scatterplot Unobservable Residulas</span>")),
                                    
                                    plotOutput("Plot0102"),
                                    
                                    tags$div(HTML("
                                      <span style='font-size: 12pt;'>
                                      
                                        <hr>
                                      
                                        The scatterplots shows the unobservable residuals \\(u_{i}\\) (of the model above) of the regression of \\(Y_{i}\\) on \\(X_{1i}\\) without controlling for the unobserved effect of \\(X_{2i}\\). <br>
                                      
                                        This is the difference between the observable red dots and the potentially unobservable 'true' green regression line. <br>
                                      
                                        <hr>
                                      
                                      </span>
                                    ")),
                                    
                                    tags$div(HTML("<span style='font-size: 14pt;'>Scatterplot Instrucment</span>")),
                                    
                                    plotOutput("Plot0103"),
                                    
                                    withMathJax()
                                    
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

# source("./r-shiny/ols-case-xx/ols-case-xx-app/regression_simulation.R")
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
    
    # illustration
    plot(x = tmp.sim$x1, y = tmp.sim$y,
         xlab = "X", ylab = "Y/YX2",
         col = "red") # biased/observed relationship

    lines(x = tmp.sim$x1, y = (tmp.sim$y - b2 * tmp.sim$x2), type = "p", col = "darkgreen") # correct/unobserved relationship

    abline(a = summary(tmp.sim$fit.01)$coefficients[1,1], b = summary(tmp.sim$fit.01)$coefficients[2,1], lty = 2, col = "darkgreen", lwd = 2) # bh1 of correct/unobserved fit
    
    abline(a = summary(tmp.sim$fit.02)$coefficients[1,1], b = summary(tmp.sim$fit.02)$coefficients[2,1], lty = 2, col = "red", lwd = 2) # bh1 of biased/observed fit
    
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
    
    # illustration
    plot(x = tmp.sim$x1, y = tmp.sim$res.01,
         xlab = "X", ylab = "u",
         col = "black")
    
    abline(h = 0, lty = 2, lwd = 2)
    
    
  })
  
  # correlation between instrument (z) and endogenous regressor (x2)
  output$Plot0103 <- renderPlot({
    
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
    
    # illustration
    plot(x = tmp.sim$x1, y = tmp.sim$z,
         xlab = "X1", ylab = "Z",
         col = "black")
    
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
    
    # plot histogram of estimator
    hist(x = tmp.sim$b1h, freq = FALSE,
         xlim = c(-6, 6),
         ylim = c(0, 5),
         # main=paste("n=",N),
         main = "",
         xlab = "", 
         ylab = "Absolute Frequency")
    
    # line for mean population parameter
    abline(v = b1, lty = 2, col = "darkgreen", lwd = 2)
    abline(v = tmp.sim$b1h.boot.mea, lty = 2, col = "red", lwd = 2)
    
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
    
    # generate histogram of estimator
    h1 <- hist(x = tmp.sim$b1h.z, freq = FALSE)
    h2 <- hist(x = tmp.sim$b1h.z.ord, freq = FALSE)
    
    # plot histogram of estimator
    main <- c("")
    sub <- c("")
    xlab <- c("")
    ylab <- c("Relative Frequency")
    
    xlim <- c(-6, 6)
    ylim <- c(0, max(c(h2$density, 0.40)))

    plot.new()
    plot.window(xlim, ylim, "")
    title(main = main, sub = sub, xlab = xlab, ylab = ylab)
    axis(1)
    axis(2)
    
    # plot h1
    nB <- length(h1$breaks)
    rect(h1$breaks[-nB], 0, h1$breaks[-1L], h1$density, col = scales::alpha("darkgreen", 0.25))
    
    # plot h2
    nB <- length(h2$breaks)
    rect(h2$breaks[-nB], 0, h2$breaks[-1L], h2$density, col = scales::alpha("red", 0.25))
    
    # pdf for normal distribution
    curve(dnorm(x, mean = 0, sd = 1), -6, 6,
          xlim = c(-3,3), 
          ylim=c(0,0.6),
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

  output$Text01 <- renderText({
    
    note.01 <- paste0("<div style='text-decoration: none; font-size: 14pt'>",  
                      "<hr>",
                      "<p>This is a sctterplot of \\(N\\) realizations of \\(Y\\) and \\(X\\) from the linear regression model above with the corresponding fitted regression line.</p>",
                      "</div>")
    
  })
  
}

# Create Shiny app ----
shinyApp(ui, server)
