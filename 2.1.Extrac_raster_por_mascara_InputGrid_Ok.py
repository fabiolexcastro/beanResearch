# ---------------------------------------------------------------------------
# Autor: Antonio Pantoja
# Fecha: febrero 7  de 2011
# email: jesuspantoja@gmail.com
# Proposito: Extraer con mascara shp o raster, sirve para una sola carpeta ejemplo worldclim
# Nota: 
# ---------------------------------------------------------------------------

import arcgisscripting, os, sys, string
gp = arcgisscripting.create(9.3)
gp.CheckOutExtension("Spatial")
os.system('cls')


entrada = raw_input("\ncarpeta entrada ")
mascara = raw_input("\nentrar el archivo mascara, raster o shp con extension   ")
salida = raw_input("\ncarpeta salida ")


if not os.path.exists(salida):
	os.system('mkdir ' + salida)
	
gp.workspace = entrada 
rasters = gp.ListRasters("*","")
for raster in rasters:
	corte = salida + "\\" + raster
	if not gp.Exists(corte):
		gp.SnapRaster = raster        
		gp.ExtractByMask_sa(raster, mascara , corte)  
	else:
		print "ya existe --> " + corte
print "Proceso terminado !!!"    
