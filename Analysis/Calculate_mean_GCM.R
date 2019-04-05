#### GCM's Calculate mean to analysis

require(raster);require(rgdal)

cropDir = ("\\pinta\scarmona\Cauca\Ecocrop\Output\2050")
            
gcmlist <- list.files("\\pinta\scarmona\Cauca\Ecocrop\Output\2050")

    crop1 = list.files(paste0(cropDir, "/",gcmlist, sep=""), recursive=TRUE, full.names=TRUE) #"recursive" means that the gcmlist is in folders, "full.names=TRUE" tells R that we are looking at full names
    crop2 = crop1[grep(pattern ="crop_Cassava_suitability.tif", crop1)] #Tells R to take the named file only
    crop3 = lapply(crop2, FUN=raster) #Tells R that we are working with Rasters
    crop = stack(crop3)
    plot(crop[[1]])
    crop_mean = mean(crop)
    plot(crop_mean)   

writeRaster(crop_mean,paste0(cropDir,"crop_Cassva_suitability.tif", sep=""))

summary(crop1)
