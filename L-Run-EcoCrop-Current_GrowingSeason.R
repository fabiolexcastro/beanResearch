# Set variables
src.dir <- "//dapadfs/workspace_cluster_6/VULNERABILITY_ANALYSIS_CC_SAM/ECOCROP_DEVELOPMENT_CC_SAM/_scripts"
cropParamFile <- "//dapadfs/workspace_cluster_6/VULNERABILITY_ANALYSIS_CC_SAM/ECOCROP_DEVELOPMENT_CC_SAM/ULI/Uli_crop-parameters/all_crops-param.csv"
cropDir <- "//dapadfs/workspace_cluster_6/VULNERABILITY_ANALYSIS_CC_SAM/ECOCROP_DEVELOPMENT_CC_SAM/ULI/Uli_modelling/all_cropsII"
cDir <- "//dapadfs/workspace_cluster_6/VULNERABILITY_ANALYSIS_CC_SAM/ECOCROP_DEVELOPMENT_CC_SAM/ULI/Uli_climate/current_cut_af/ascii_worldclim/Global_5min/extracted_5min"
#sowDat="//dapadfs/workspace_cluster_6/VULNERABILITY_ANALYSIS_CC_SAM/ECOCROP_DEVELOPMENT_CC_SAM/Growing_season/2000_sta_2.asc"
#harDat="//dapadfs/workspace_cluster_6/VULNERABILITY_ANALYSIS_CC_SAM/ECOCROP_DEVELOPMENT_CC_SAM/Growing_season/end_date.asc"
crop <- "af"


#######################################
#######          CURRENT         ######
#######################################

# Reading crop parameters from parameter file
cropPar <- read.csv(cropParamFile, header=T)
nTest <- ncol(cropPar) #Number of test into file crop parameters

for (n in 2:nTest){
  testName <- names(cropPar)[n]  #Name of the tests


#Source scripts and libraries
#stop("no")
library(raster);library(maptools);library(rgdal);library(sp)
source(paste(src.dir,"/src/EcoCrop-model_1.R",sep=""))#this script includes the GSsuit as well


if (!file.exists(paste(cropDir, "/analyses/runs/", crop, "_", testName, "_suitability.tif", sep=""))) {
  
  #Run principal function
  cat(paste("Processing : ", crop, " ", testName, "\n", sep=""))
  
  eco <- suitCalc(climPath=cDir, 
                  Gmin=cropPar[1,n], #Minimum lenght of the growing season 
                  Gmax=cropPar[2,n], #Maximum lenght of the growing season
                  Tkmp=cropPar[3,n], #Killing temperature  
                  Tmin=cropPar[4,n], #Minimum temperature
                  Topmin=cropPar[5,n], #Minimum optimum temperature
                  Topmax=cropPar[6,n], #Maximum optimum temperature
                  Tmax=cropPar[7,n], #Maximum temperature
                  Rmin=cropPar[8,n], #Minimum precipitation
                  Ropmin=cropPar[9,n], #Minimum optimum precipitation
                  Ropmax=cropPar[10,n], #Maximum optimum precipitation
                  Rmax=cropPar[11,n], #Maximum precipitation
                  outfolder = paste(cropDir, "/analyses/runs", sep=""),
                  #sowDat=sowDat,
                  #harDat=harDat,
                  cropname=paste(crop, "_", testName, sep=""))
  
  } else { cat(paste("Processed : ", crop, " ", testName, "\n", sep=""))}
}