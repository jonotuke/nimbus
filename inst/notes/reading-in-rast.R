library(terra)
example <- rast("data-raw/example_raster.img", lyrs = 1)
example <- as.numeric(example)
plot(example)
crs(example)

sim <- rast()
crs(sim) <- crs(example)
sim
values(sim) <- runif(ncell(sim))
plot(sim)
