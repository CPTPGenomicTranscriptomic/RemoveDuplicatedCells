#Increase size of upload files to 500 Mo
options(shiny.maxRequestSize=500*1024^2)
options(warn=-1)

if (!require("shiny"))
  install.packages("shiny")  

if (!require("shinyFiles"))
  install.packages('shinyFiles')

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

if (!require("flowCore"))
  BiocManager::install("flowCore")


library(shiny)
library(shinyFiles)
library(flowCore)


ui <- fluidPage(
  br(),
  tags$head(
    tags$style(".title {margin: auto; width: 800px; font-size-adjust: 1.3}")
  ),
  tags$div(class="title", titlePanel("Removes duplicated cells")),
  br(),
  headerPanel(
    list(HTML('<img src="Logo_cptp.png"/>'), HTML('<a href="https://www.cptp.inserm.fr/en/technical-platforms/genomic-and-transcriptomic/">Genomic and transcriptomic platform</a>'), HTML('<img src="Logo_inserm.png"/>')),
    windowTitle="My Title"
  ),
  br(),
  
  sidebarLayout(
    sidebarPanel(
      h3("Please choose your output directory:"),
      shinyDirButton("dir", "Choose output directory", "Select output directory"),
      h3("Please upload your *.fcs files:"),
      fileInput(inputId = "Files", label = "Select Samples", multiple = TRUE, accept = ".fcs"),
      br(),
      h3("Export data to a text file"),
      downloadButton("downloadData", "Download", icon("paper-plane"),
                     style="color: #fff; background-color: maroon; 
                     border-color: black")
    ),
    
    mainPanel(
      h4("Read FCS files and remove all duplicated cells. The duplicated cells have the same values for the Time parameter."),
      titlePanel("The results will be print here:"),br(),
      h4("Remember your input files were:"),
      verbatimTextOutput("inputFiles"), br(),
      h4("Remember your output directory was:"),
      verbatimTextOutput("dir2"), br(),
      h4("If the next line is in red ... it's your problem... not mine, YOUR'S... Good luck!"),
      verbatimTextOutput("Samples")
    )
  )
)
