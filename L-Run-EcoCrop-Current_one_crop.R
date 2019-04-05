# Set variables

src.dir <- "Z:/_Scripts/R/EcoCrop" 
cropParamFile <- "Z:/CDKN_CARIBE_CC_SAM/Jamaica/Modeling/EcoCrop/Crop_Parameters/cocoa_parameters.csv"
cropDir <- "Z:/CDKN_CARIBE_CC_SAM/Jamaica/Modeling/EcoCrop/Output/Current" 
cDir <- "Z:/CDKN_CARIBE_CC_SAM/Jamaica/ClimateData/_baseline"
crop <- "Cocoa"


#######################################
#######          CURRENT         ######
#######################################

# Reading crop parameters from parameter file
cropPar <- read.csv(cropParamFile, header=T)
nTest <- ncol(cropPar) #Number of test into file crop parameters
testName <- names(cropPar)[nTest] #Name of the last test

#Source scripts and libraries
stop("no")
library(raster);library(maptools);library(rgdal);library(sp)
source(paste(src.dir,"/src/EcoCrop-model.R",sep=""))

#if (!file.exists(paste(cropDir, "/analyses/runs/", crop, "_", testName, "_suitability.asc", sep=""))) {
if (!file.exists(paste(cropDir, "/", crop, "_", testName, "_suitability.asc", sep=""))) {
  
  #Run principal function
  cat(paste("Processing : ", crop, " ", testName, "/n", sep=""))
  
  eco <- suitCalc(climPath=cDir, 
                  Gmin=cropPar[1,nTest], #Minimum lenght of the growing season 
                  Gmax=cropPar[2,nTest], #Maximum lenght of the growing season
                  Tkmp=cropPar[3,nTest], #Killing temperature  
                  Tmin=cropPar[4,nTest], #Minimum temperature
                  Topmin=cropPar[5,nTest], #Minimum optimum temperature
                  Topmax=cropPar[6,nTest], #Maximum optimum temperature
                  Tmax=cropPar[7,nTest], #Maximum temperature
                  Rmin=cropPar[8,nTest], #Minimum precipitation
                  Ropmin=cropPar[9,nTest], #Minimum optimum precipitation
                  Ropmax=cropPar[10,nTest], #Maximum optimum precipitation
                  Rmax=cropPar[11,nTest], #Maximum precipitation
                  #outfolder = paste(cropDir, "/analyses/runs", sep=""),
                  outfolder = paste(cropDir, sep=""),
                  #sowDat=sowDat,
                  #harDat=harDat,
                  cropname=paste(crop, "_", testName, sep=""))
  
} else { cat(paste("Processed : ", crop, " ", testName, "/n", sep=""))}
