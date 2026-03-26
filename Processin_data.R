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
data_clean$Biomassa_g <- as.numeric(
  gsub(",", ".", gsub("\\.", "", data_clean$Biomassa_g))
)


data_coord <- vect(data_clean [,-c(7:14)],
                   geom = c("LONG", "LAT"),
                   crs ="EPSG:4326")
rast_tamplate <- rast(ext(data_coord),
                      resolution = 0.0001,
                      crs = crs(data_coord))


data_lyer_n <- rasterize (data_coord,
                           rast_tamplate,
                           field = "N")
data_lyer_biomassa <- rasterize(data_coord,
                                rast_tamplate,
                                field = "Biomassa_g")
r_stack <- c(data_lyer_n,
             data_lyer_biomassa)
names(r_stack) <- c("N",
                    "Biomassa_g")

r_stack <- stack(r_stack)
data_coord <- as(data_coord,
                 "Spatial")

maxent(r_stack,data_coord)
class(data_coord)
