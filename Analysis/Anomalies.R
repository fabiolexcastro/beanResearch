#Tomado de Antonio Pantoja (phyton)
#Analisis cambios futuro_presente
#################################################################################

base_dir <-"D:/Backup_JG/Bounderlands/EcoCrop/ouput/Colombia/"
output <- paste(base_dir,"Area/",sep="")

#################################################################################

#current = Raster(pathEntrada + "//" + carpe + "//current")
current = raster(paste0(base_dir, "Current/crop_yuca_suitability.tif", sep=""))

#future =  Raster(pathEntrada + "//" + carpe + "//fut_mean")
future = raster(paste0(base_dir, "2050/crop_yuca_suitability.tif", sep=""))

outCon1 = ((current >= 50) & (future  <  50)) #Areas nolong suitable (RED)
outCon1[!outCon1]=NA #Tells R to give all regions except specified region NA
outCon1[!is.na(outCon1)]=1 #Gives each region a value

outCon2 = (current >= 50) & (future >= 50) & ((future - current) < 0) #Areas suitable but less suitable inthe fut? (ORANGE)
outCon2[!outCon2]=NA
outCon2[!is.na(outCon2)]=2

outCon3 = (current >= 50) & (future >= 50) & ((future - current) == 0) #Areas suitable and same suitability in the future (YELLOW)
outCon3[!outCon3]=NA
outCon3[!is.na(outCon3)]=3

outCon4  = ((current < 50) & (future >= 50)) #New Areas of suitability (LIGHT GREEN)
outCon4[!outCon4]=NA
outCon4[!is.na(outCon5)]=4 

outCon5 = (current >= 50) & (future >= 50) & ((future - current) > 0) #Areas Suitable and more suitable in the fut (DARK GREEN)
outCon5[!outCon5]=NA
outCon5[!is.na(outCon5)]=5

###Merge Layers

pieced_fextent = merge(outCon1,outCon2,outCon3,outCon4,outCon5)
plot(pieced_fextent)
writeRaster(pieced_fextent,paste0(output,"Cassava.tiff"))
