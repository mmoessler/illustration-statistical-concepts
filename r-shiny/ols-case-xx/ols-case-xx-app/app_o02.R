library(shiny)

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
      # tags$div(HTML("<span style='margin-top: 25pt; font-size: 18pt'>Change Inputs</span>")),
      tags$div(HTML("<span style='font-size: 18pt'>Change the Inputs</span>")),
      
      tags$hr(),
      
      # Input 1: Sample size ----
      sliderInput(inputId = "rho",
                  label = withMathJax(
                    ' \\(\\rho\\)'
                  ),
                  # label = "Variance of $X$",
                  min = as.numeric(-1),
                  max = as.numeric(1),
                  value = as.numeric(0.25),
                  step = 0.05),
      
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
                                    tags$div(HTML("<span style='font-size: 12pt;'>(Based on one sample draw of size \\(N\\)) on the DGP</span>")),
                                    plotOutput("Plot01"),
                                    htmlOutput("Text01"),
                                    withMathJax()
                                    ),
                           tabPanel("Consistency",
                                    tags$br(),
                                    tags$div(HTML("<span style='font-size: 14pt;'>Histogram of the OLS estimator for the slope coefficient \\(\\beta_1\\)</span>")),
                                    tags$div(HTML("<span style='font-size: 12pt;'>(Based on 1000 sample draw of size \\(N\\) on the DGP)</span>")),
                                    plotOutput("Plot02")
                                    ),
                           tabPanel("Asymptotic Normality",
                                    tags$br(),
                                    tags$div(HTML("<span style='font-size: 14pt;'>Histogram of the standardized OLS estimator for \\(\\beta_1\\)</span>")),
                                    tags$div(HTML("<span style='font-size: 12pt;'>(Based on 1000 sample draw of size \\(N\\) on the DGP)</span>")),
                                    plotOutput("Plot03")
                                    )
               )

        )#,
        
      #   # Output 1: non standardized ----
      #   column(12,
      #          # HTML("<hr>"),
      #          h3("Law of Large Number (LLN): Consistency"),
      #          h4("Sampling distribution of estimator"),
      #          h5("Slope coefficient"),
      #          plotOutput("Plot01", height = 350)),
      #   
      #   # Output 2: standardized ----
      #   column(12,
      #          HTML("<hr>"),
      #          h3("Central Limit Theorem (CLT): Asymptotic Normality"),
      #          h4("Sampling Distribution of Standardized Sample Average"),
      #          h5("Slope Coefficient"),
      #          plotOutput("Plot02", height = 350)),

      )

    )
  )
)

# Define server logic for random distribution app ----
server <- function(input, output) {

  Sim <- reactive({
    
    # function to simulate b0_hat and b1_hat ----
    bet_hat_sim_fun <- function(RR, NN,
                                b0, b1, b2,
                                X1.int, X2.int,
                                u.sd,
                                rho){
      
      # initialize vectors for simulation results
      b0h <- numeric(RR)
      b1h <- numeric(RR)
      
      var.b0 <- numeric(RR)
      var.b1 <- numeric(RR)
      
      b0h.z <- numeric(RR)
      b1h.z <- numeric(RR)
      
      for (ii in 1:RR) {
        
        X1 <- runif(NN, min = 0 - X1.int/2, max = 0 + X1.int/2)
        X2 <- runif(NN, min = 0 - X2.int/2, max = 0 + X2.int/2)
        
        X1.sd <- 1/12*((0 + X1.int/2) - (0 - X1.int/2))^2
        X2.sd <- 1/12*((0 + X2.int/2) - (0 - X2.int/2))^2
        
        # m.12 <- rho * (X2.sd/X1.sd)
        # X1 <- m.12 * X2 
        m.21 <- rho * (X1.sd/X2.sd)
        X2 <- m.21 * X1
        
        u <- rnorm(NN, mean = 0, sd = u.sd)
        Y1 <- b0 + b1 * X1 + b2 * X2 + u
        Y2 <- b0 + b1 * X1 + u
        
        tmp <- lm(Y1 ~ X1 + 1)
        
        # get estimates
        b0h[ii] <- tmp$coefficients[1]
        b1h[ii] <- tmp$coefficients[2]
        
        # compute the variance of beta_hat_0
        Hi <- 1 - mean(X1) / mean(X1^2) * X1
        var.b0[ii] <- var(Hi * u) / (NN * mean(Hi^2)^2)
        # compute the variance of hat_beta_1
        var.b1[ii] <- var( ( X1 - mean(X1) ) * u ) / ( NN * var(X1)^2 )
        
        # compute t-statistics
        b1h.z[ii] <- (b1h[ii] - b1) / sqrt(var.b1[ii])
        b0h.z[ii] <- (b0h[ii] - b0) / sqrt(var.b0[ii])
        
      }
      
      return(list(b0h = b0h, b1h = b1h,
                  Y1 = Y1, Y2 = Y2, X1 = X1, X2 = X2, u = u,
                  var.b0 = var.b0, var.b1 = var.b1,
                  b0h.z = b0h.z, b1h.z = b1h.z))
      
    }
    
    # inputs
    RR <- 1000
    NN <- 100
    b0 <- 0
    b1 <- 1
    b2 <- 10
    X1.int <- 20
    X2.int <- 20
    u.sd <- 5
    rho <- input$rho

    # simulation
    tmp.sim <- bet_hat_sim_fun(RR = RR, NN = NN,
                               b0 = b0, b1 = b1, b2 = b2,
                               X1.int = X1.int, X2.int = X2.int,
                               u.sd = u.sd,
                               rho = rho)
    
    tmp.sim
    
  })

  output$Plot01 <- renderPlot({
    
    # inputs
    RR <- 1000
    NN <- 100
    b0 <- 1
    b1 <- 1
    b2 <- 1
    X1.int <- 50
    X2.int <- 50
    u.sd <- 10
    rho <- input$rho
    
    # reactive
    tmp.sim <- Sim()
    
    # fit models
    lm.01.tmp <- lm(tmp.sim$Y1 ~ tmp.sim$X1 + 1)
    lm.02.tmp <- lm(tmp.sim$Y2 ~ tmp.sim$X1 + 1)
    
    # illustration
    plot(x = tmp.sim$X1, y = tmp.sim$Y1,
         xlab = "X", ylab = "Y",
         xlim = c(-20, 20), ylim = c(-50, 50), col = "red")
    
    lines(x = tmp.sim$X1, y = tmp.sim$Y2, type = "p", col = "darkgreen")
    
    abline(a = b0, b = b1, lty = 2, col = "black", lwd = 2)
    
    abline(a = summary(lm.01.tmp)$coefficients[1,1], b = summary(lm.01.tmp)$coefficients[2,1], lty = 2, col = "red", lwd = 2)
    abline(a = summary(lm.02.tmp)$coefficients[1,1], b = summary(lm.02.tmp)$coefficients[2,1], lty = 2, col = "darkgreen", lwd = 2)
    
  })
  
  output$Plot02 <- renderPlot({
    
    # inputs
    RR <- 1000
    NN <- 100
    b0 <- -2
    b1 <- 1
    b2 <- 1
    X1.int <- 10
    X2.int <- 10
    u.sd <- 10
    rho <- input$rho
    
    # reactive
    tmp.sim <- Sim()
    
    # illustration
    if (NN <= 2) {
     
      # see: https://statisticsglobe.com/plot-only-text-in-r
      plot(x = 0:1, # Create empty plot
           y = 0:1,
           ann = F,
           bty = "n",
           type = "n",
           xaxt = "n",
           yaxt = "n")
      text(x = 0.5, # Add text to empty plot
           y = 0.5,
           # "This is my first line of text!\nAnother line of text.\n(Created by Base R)", 
           "Choose a sample size greater than two!", 
           cex = 2)
      
    } else {
      
      # plot histogram of estimator
      hist(x = tmp.sim$b1h, freq = FALSE,
           xlim = c(-6, 6),
           ylim = c(0, 5),
           # main=paste("n=",N),
           main = "",
           xlab = "", 
           ylab = "Absolute Frequency")
      
      # line for mean population parameter
      abline(v = b1, lty = 2, col = "red", lwd = 2)
      
      # legend
      legend("topleft",
             legend = "Population coefficient",
             lty = 2,
             lwd = 1,
             col = "red",
             inset = 0.05)
    }
    
  })
  
  output$Plot03 <- renderPlot({
    
    # inputs
    RR <- 1000
    NN <- 100
    b0 <- -2
    b1 <- 1
    b2 <- 1
    X1.int <- 10
    X2.int <- 10
    u.sd <- 10
    rho <- input$rho
    
    # reactive
    tmp.sim <- Sim()
    
    # illustration
    if (NN <= 2) {
      
      # see: https://statisticsglobe.com/plot-only-text-in-r
      plot(x = 0:1, # Create empty plot
           y = 0:1,
           ann = F,
           bty = "n",
           type = "n",
           xaxt = "n",
           yaxt = "n")
      text(x = 0.5, # Add text to empty plot
           y = 0.5,
           # "This is my first line of text!\nAnother line of text.\n(Created by Base R)", 
           "Choose a sample size greater than two!", 
           cex = 2)
      
    } else {
      
      # generate histogram of estimator
      x <- hist(x = tmp.sim$b1h.z, freq = FALSE)
      
      # plot histogram of estimator
      main <- c("")
      sub <- c("")
      xlab <- c("")
      ylab <- c("Relative Frequency")
      
      xlim <- c(-6, 6)
      ylim <- c(0, max(c(x$density, 0.40)))

      plot.new()
      plot.window(xlim, ylim, "")
      title(main = main, sub = sub, xlab = xlab, ylab = ylab)
      axis(1)
      axis(2)
      
      nB <- length(x$breaks)
      rect(x$breaks[-nB], 0, x$breaks[-1L], x$density)

      
      
      # pdf for normal distribution
      curve(dnorm(x, mean = 0, sd = 1), -3, 3,
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
             legend = "Standard Normal PDF",
             lty = 2,
             lwd = 1,
             col = "red",
             inset = 0.05)
      
    }
    
  })

  output$Text01 <- renderText({
    
    # note.01 <- paste0("<div style='text-decoration: none; font-size: 16pt'>",
    #                   "<ul>",
    #                   "<li> Increasing the sample size \\(N\\). </li>",
    #                   "<li> ... </li>",
    #                   "</ul>",
    #                   "</div>")
    
    note.01 <- paste0("<div style='text-decoration: none; font-size: 14pt'>",  
                      "<p>",
                      "This is a sctterplot of \\(N\\) realizations of \\(Y\\) and \\(X\\) from the linear regression model above with the corresponding fitted regression line.",
                      "</p>",
                      "</div>")
    
    # note.01
    
    paste0(note.01, "<script>if (window.MathJax) MathJax.Hub.Queue(['Typeset', MathJax.Hub]);</script>")
    
  })
  
}

# Create Shiny app ----
shinyApp(ui, server)
