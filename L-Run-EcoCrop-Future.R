# Set variables
src.dir <- "D:/Backup_JG/Bounderlands/EcoCrop/scripts"
cropParamFile <- "D:/Backup_JG/Bounderlands/EcoCrop/crop_parameters/all_Ecuador.csv"
cropDir <- "D:/Backup_JG/Bounderlands/EcoCrop/ouput/Ecuador"
#cDir <- "//dapadfs/workspace_cluster_3/vulnerability-analysis/EcoCrop-development/climate/world_10min/_asciis"
#sowDat="//dapadfs/workspace_cluster_3/vulnerability-analysis/EcoCrop-development/Growing_season/2000_sta_2.asc"
#harDat="//dapadfs/workspace_cluster_3/vulnerability-analysis/EcoCrop-development/Growing_season/end_date.asc"
crop <- "crop"
fDir <- "D:/Backup_JG/Bounderlands/Climate/CMIP3/ecu_area/2050"


########################################
########          FUTURE         #######
########################################

#Source scripts and libraries
stop("no")
library(raster);library(maptools);library(rgdal);library(sp)
source(paste(src.dir,"/src/futureRuns.tmp.R",sep=""))
source(paste(src.dir,"/src/impacts.R",sep=""))
source(paste(src.dir,"/src/uncertainty.R",sep=""))


#Global climate models (SRES_A1B)
gls <- c("bccr_bcm2_0","cccma_cgcm3_1_t47","cnrm_cm3","csiro_mk3_0","csiro_mk3_5","gfdl_cm2_0","gfdl_cm2_1",
         "giss_model_er","ingv_echam4","inm_cm3_0","ipsl_cm4","miroc3_2_medres","miub_echo_g",
         "mpi_echam5","mri_cgcm2_3_2a","ncar_ccsm3_0","ncar_pcm1","ukmo_hadcm3","ukmo_hadgem1")

# Reading crop parameters from parameter file
cropPar <- read.csv(cropParamFile, header=T)
nTest <- ncol(cropPar) #Number of test into file crop parameters



#############  Projection onto future  ##################
#Run principal function for each GCM
cat("Calculate Suitability projected onto future/n")

#########################################################
############ Loop through the tests #####################
for (n in 2:nTest){
  testName <- names(cropPar)[n] #Name of the last test
  cat(paste("Processing : ", crop, " ", testName, "/n", sep=""))

#Loop aroudn GCMs
for (gcm in gls) {
  
  rDir <- paste(cropDir, "/analyses/runs-future/", gcm, sep="") #Output folder for each GCM
  aDir <- paste(fDir, "/", gcm, sep="")  #Folder of future climate data

  
  
  if (!file.exists(paste(rDir, "/", crop, "_", testName, "_suitability.asc", sep=""))) {
    
    cat("/tFutSuitCalc ", gcm, "/n")
    
    #Run the function
    fut <- suitCalc(climPath = aDir, 
                    Gmin=cropPar[1,n],
                    Gmax=cropPar[2,n],
                    Tkmp=cropPar[3,n],
                    Tmin=cropPar[4,n],
                    Topmin=cropPar[5,n],
                    Topmax=cropPar[6,n],
                    Tmax=cropPar[7,n],
                    Rmin=cropPar[8,n],
                    Ropmin=cropPar[9,n],
                    Ropmax=cropPar[10,n],
                    Rmax=cropPar[11,n],
                    outfolder = rDir, 
                    sowDat="NA",
                    harDat="NA",
                    cropname = paste(crop, "_", testName, sep=""))
    
  } else { cat("/tFutSuitCalc", crop, " ", testName, "/t", gcm, "/tdone/n")}      
 }			
}