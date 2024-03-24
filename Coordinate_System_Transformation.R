### COORDINATE SYSTEM TRANSFORMATION ###
### Juan Andrade Rivera
### linkedin.com/in/juan-andriv
### 24.03.2024

## Adapt by editing: WD, file names, coordinate column names, CSR


# Libraries
library(sp)
library(raster)

# setwd
setwd("C:/Users/Juan/Documents/0_RStudio/Coordinate_System_Transformation")

# load data
data <- read.csv("Ecosystem_Services.csv", header = TRUE)

# Convert data to SpatialPointsDataFrame
coordinates(data) <- c("X", "Y")

# Specify the coordinate system
proj4string(data) <- CRS("+proj=utm +zone=14 +datumWGS84")

# Transform coordinates and create a temporal object to store them
data_wgs84 <- spTransform(data, CRS("+proj=longlat +datum=WGS84"))

# Extract new lat long coordinates from temporal object
data$Latitude <- coordinates(data_wgs84)[,2]
data$Longitude <- coordinates(data_wgs84)[,1]

# Check everything's all right
names(data)

# Write a new .csv file adding the extracted coordinates to the original data
write.csv(data, "Ecosystem_Services_latlong.csv", row.names = FALSE)
