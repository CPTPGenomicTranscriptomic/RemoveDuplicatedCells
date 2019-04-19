RemoveDuplicatedCells
========
Remove duplicated cells using a Rshiny interface.

*****

Launch RemoveDuplicatedCells directly from R and GitHub (preferred approach)

User can choose to run RemoveDuplicatedCells installed locally for a more preferable experience.

**Step 1: Install R and RStudio**

Before running the app you will need to have R and RStudio installed (tested with R 3.5.3 and RStudio 1.1.463).  
Please check CRAN (<a href="https://cran.r-project.org/" target="_blank">https://cran.r-project.org/</a>) for the installation of R.  
Please check <a href="https://www.rstudio.com/" target="_blank">https://www.rstudio.com/</a> for the installation of RStudio.  

**Step 2: Install the R Shiny package and other packages required by RemoveDuplicatedCells**

Start an R session using RStudio and run this line:  
```
if (!require("shiny")){install.packages("shiny")}  
```

**Step 3: Start the app**  

Start an R session using RStudio and run this line:  
```
shiny::runGitHub("RemoveDuplicatedCells", "CPTPGenomicTranscriptomic")
```
This command will download the code of RemoveDuplicatedCells from GitHub to a temporary directory of your computer and then launch the RemoveDuplicatedCells app in the web browser. Once the web browser was closed, the downloaded code of RemoveDuplicatedCells would be deleted from your computer. Next time when you run this command in RStudio, it will download the source code of RemoveDuplicatedCells from GitHub to a temporary directory again. 


## Step 4: Choose your analysis set up  

**1. Choose your output directory:**

Choose the operating system (Windows pr MAC) in the top rigth corner.

The from root select the output directory.

The application can crash (everything in grey, no interactivity) if you choose the wrong operating system, if you choose a directory where you haven't some rigths and others...

Experts can try others Volumes (as currentDirectory, home, etc...) but they have to use the application on local.


**2. Upload your FCS files:**

You can upload from one to multiple \*.fcs files.

The files must have the .fcs extension to appear in the selection browser.

Be aware that The application is limited to 500Mo of RAM.

Multiple runs can be preferable in case of big data analyses.

The blue progress bar should move until the message \"upload complete\" appears.


**3. Wait for the computation:**

Once the upload competed a progress boxe should appears in the rigth-bottom corner. It indicates that the application is running and which input file is processed.


**4. The results:**

Once the progress box has disappeared.

The inputs files should be listed below \"Remember your input files were:\".

The ouput directory should appears below \"Remember your output directory was\".

This message \"Finish!\" should be print below \"If the next line is in red ... it's your problem... not mine, YOUR'S... Good luck!\".

If any Red word or line appears the apllication has encountered an error. Don't hesitate to look at the Rstudio console to track the problem.

The results should be located at the output directory.

**5. Export data to a zip file:

The button will create a zip file corresponding to all the deduplicated input files.

The webpage should look like this!

![alt text](https://github.com/CPTPGenomicTranscriptomic/RemoveDuplicatedCells/blob/master/RemovesDuplicatedCells_interface.png)
