install.packages("jsonlite")# necessary for download data from GBIF
library(jsonlite)
library (dismo)

occ_raw <- gbif(genus="Myrceugenia",species="bananalensis",download=TRUE)
head (occ_raw)
colnames(occ_raw)


names (occ_raw) [1:20]

coordinates()
