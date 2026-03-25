#install.packages("jsonlite")# necessary for download data from GBIF
library(jsonlite)
library (dismo)

occ_raw <- gbif(genus="Myrceugenia",species="bananalensis",download=TRUE)

occ_clean <- subset(occ_raw,(!is.na(lat))&(!is.na(lon)))

(occ_clean) <- ~ lon + lat
myCRS3 <- CRS("+init=epsg:3413") # WGS 84 / NSIDC Sea Ice Polar Stereographic North

crs (occ_clean) <-  myCRS3

