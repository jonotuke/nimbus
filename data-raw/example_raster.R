## code to prepare `example_raster` dataset goes here
pacman::p_load(raster)
example_raster <- raster("data-raw/example_raster.tif")
example_raster
usethis::use_data(example_raster, overwrite = TRUE)
