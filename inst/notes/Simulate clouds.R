#Read in satellite image
#Simulate cloud shapes
#Mask cloud shapes out of the original satellite image and
# export to a .tif file

library(raster)
# library(rgdal)
library(gplots)
library(mgcv)

#read in raster
img <-raster("inst/archive/InjuneCloudFree27Sept.tif")
plot(img)

#FPC.raster[FPC.raster==0]<- NA

#Simulate clouds using distance grid approach and raster package
### Following section adapted from Helmstedt and Potts approach

#library(gplots)

n.sides <- 70
# Set up a square lattice region
simgrid <- expand.grid(1:n.sides, 1:n.sides)
n <- nrow(simgrid)

# Set up distance matrix
distance <- as.matrix(dist(simgrid))
# Generate random variable
#Can change phi  values
phi <- 0.1
X <- rmvn(1, rep(0, n), exp(-phi * distance))
Xraster <- rasterFromXYZ(cbind(simgrid[, 1:2] - 0.5, X))
cloud<-as.matrix(Xraster)
cloud<-cloud+abs(min(cloud))

plot(Xraster)

#Set CRS for Xraster to same as for the satellite image
#To check extent use
extent(img)
crs(img)
crs(Xraster) = "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"

#Set extent of Xraster equal to img
xmin(Xraster) <--68.41667
xmax(Xraster) <--64.28611
ymin(Xraster) <--15.17222
ymax(Xraster) <--11.88056

extent(Xraster)
#Xraster now has the same extent as FPC.raster

#Check the dimensions
dim(Xraster)
dim(img)

#Reproject the FPC.raster and X_raster in order to stack them
#Note: this step takes a few minutes
Xraster.resampled <- projectRaster(Xraster,img,method = 'ngb')

#The dimensions and extents of Xraster.resampled and FPC.raster now match

##### Cloud masking. Choose values of the Xraster.resample layer to
# mask out based on how you want clouds to appear.
#e.g. Mask out the green regions in Xraster.resampled.
# Green regions have values 1 to 3.

cloud.layer <-Xraster.resampled #rerun this line before changing the cloud layer NA values below

#For speckled small clouds use
cloud.layer[cloud.layer >-0.5 & cloud.layer <0.15] <-NA

#For large clouds use
cloud.layer[cloud.layer >0.8 & cloud.layer <4] <-NA

cloud.layer[cloud.layer >-1.5 & cloud.layer < -1] <-NA

#plot the layer to visually check
plot(cloud.layer, colNA="blue")

# Plot the stack and the cloud mask on top of each other. If they are misaligned
# this is not a serious problem
#and occurs due to the angle landsat data is captured at.
#https://stackoverflow.com/questions/24213453/overlay-raster-plot-using-plot-add-t-leads-to-arbitrary-misalignment-of-fin
#plot(FPC.raster, new=TRUE)
#plot(cloud.layer, add = TRUE, legend = FALSE, new=TRUE)

#Save the cloud.layer raster as a separate mask
mask <- cloud.layer

#Use this code to remove the 0 values as set in the simulated cloud mask
# to be zero in the actual FPC.raster
#Change the file name when generating new files
#(10 September https://cran.r-project.org/web/packages/raster/raster.pdf pg 121)
masked.img <-mask(img, mask=mask, filename="masked.subset", inverse = FALSE, maskvalue=NA, updatevalue=0,updateNA=FALSE, overwrite=TRUE)

plot(masked.img)

#convert raster layer to a spatial pixels dataframe (need this format to use the writeGDAL function)
img.spdf <-as(masked.img, "SpatialPixelsDataFrame")

#Output new cloudy image to a .tif file
#Change file name when generating new images
writeGDAL(img.spdf,"inst/archive/InjuneCloudFree27Sept.largeclouds.tif",
          drivername="GTiff", type="Byte")



### END CODE ###


















