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

server <- function(input, output) {
  #Increase size of upload files to 500 Mo
  options(shiny.maxRequestSize=500*1024^2)
  #Print input filenames
  output$inputFiles <- renderText({
    req(input$Files)
    print(input$Files$name)
  })
  
  #Choose output directory
  shinyDirChoose(input, 'dir', roots = c(rootWindows="C:/",currentDirectory='./',rootMAC="/", home="~/", workingDirectory=getwd()))
  dir <- reactive(input$dir)
  
  #Print output directory
  output$dir2 <- renderPrint({
    req(input$dir)
    if(input$dir$root[1] == "currentDirectory" || input$dir$root[1] == "workingDirectory"){
      firstBox="."
    }
    if(input$dir$root[1] == "rootMAC"){
      firstBox=""
    }
    if(input$dir$root[1] == "rootWindows"){
      firstBox="C:"
    }
    if(input$dir$root[1] == "home"){
      firstBox="~"
    }
    print(paste0(firstBox,paste0(input$dir$path,collapse="/")))
  })
  
  #Real processing
  output$Samples <- renderText({
    req(input$Files)
    req(input$dir)
    withProgress(message = 'Duplicated cleaning in progress:', value = 0, {
      i=1
      #Output directory
      if(input$dir$root[1] == "currentDirectory" || input$dir$root[1] == "workingDirectory"){
        firstBox="."
      }
      if(input$dir$root[1] == "rootMAC"){
        firstBox=""
      }
      if(input$dir$root[1] == "rootWindows"){
        firstBox="C:"
      }
      if(input$dir$root[1] == "home"){
        firstBox="~"
      }
      saveddirname=paste0(firstBox,paste0(input$dir$path,collapse="/"))
      print(paste0("The output directory is:",saveddirname))
      
      #Foreach of the input FCS file
      for (fcs in input$Files$datapath) {
        
        # Increment the progress bar, and update the detail text.
        incProgress(1/(length(input$Files$name)), detail = paste("", input$Files$name[i]))

        #ReadFCS file
        mydata = read.FCS(fcs, transformation = FALSE)
        write.FCS(flowFrame(exprs(mydata)[!duplicated(exprs(mydata)[,"Time"]),],parameters(mydata),description(mydata)),paste0("nodup.",input$Files$name[i]))

        i=i+1        
      }
      print("Finish!")
    })
  })
  output$downloadData <- downloadHandler(
    filename = function(){
      paste("output", "zip", sep=".")
    },
    content = function(file){
      files <- NULL;
      for(i in 1:length(input$Files$name)) {
        files <- c(paste0("nodup.",input$Files$name[i]),files)        }
      #create the zip file
      zip(file,files = files)
    },
    contentType = "application/zip"
  )
}
