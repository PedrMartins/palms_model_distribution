if(!"rmaxent" %in% rownames(installed.packages())){
  if(!"devtools" %in% rownames(installed.packages())){
    install.packages("devtools")}
  devtools::install_github("johnbaums/rmaxent")

}

pkg <-  c("dismo", # a collection of ENM/SDM tools
          "terra", # spatial data analysis
          "ENMeval", # a few new tools in ENM/SDM
          "wallace", # interface for Maxent and ENMeval
          "utils" # for zip & unzip files
)

pkg <- pkg[!pkg%in%installed.packages()]
pkg
install.packages (pkg)

library(dismo)
library(terra)
library(ENMeval)
library(wallace)
library(utils)
library(rmaxent)

data_url =  "https://docs.google.com/spreadsheets/d/e/2PACX-1vQx8IN6CoV4lbjPFXnjY5HDYpUbX0E-wqxjsfZ9oHHCqfTLz6wEmMUIMlGJS3eTXz20OO7PvvbxndvU/pub?output=csv"
data_raw <- read.csv(data_url,
                     dec= ",",
                     header = T)

data_clean <- subset(data_raw,(!is.na(Presence)))

crdref <- "+proj=longlat +datum=WGS84"

data_presence <- data_clean [,c(1:4)]
coordinates(data_presence) <- ~ LONG + LAT
myCRS1 <- CRS("+proj=longlat +datum=WGS84") # WGS 84
crs(data_presence) <- myCRS1
data_coord <- cbind(data_clean$LONG, data_clean$LAT)
data_coord <- vect(data_coord)
crs(data_coord) <- "+proj=longlat +datum=WGS84"

data_val <- data_clean [, -c(1:4,7:14)]
raster_val1 <- rast(ncol=ncol(data_val), nrow=nrow(data_val), xmin=-150, xmax=-80, ymin=20, ymax=60)
raster_val2 <- rast(ncol=ncol(data_val), nrow=nrow(data_val), xmin=-150, xmax=-80, ymin=20, ymax=60)
values(raster_val1) <- data_val [1]
values(raster_val2) <- data_val [2]
raster_val = c(raster_val1, raster_val2)

occ_buffer <- terra::buffer(data_coord,width=4*10^5)#unit is meter

# raster_mask <- terra::mask(raster_val, occ_buffer)
# cat (class (raster_val), class (data_presence))
#
# maxent(x=raster_val, p=data_presence)

