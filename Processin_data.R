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



data_raw =  "https://docs.google.com/spreadsheets/d/e/2PACX-1vQx8IN6CoV4lbjPFXnjY5HDYpUbX0E-wqxjsfZ9oHHCqfTLz6wEmMUIMlGJS3eTXz20OO7PvvbxndvU/pub?output=csv"
data_raw <- read.csv(data_raw, dec= ",")





