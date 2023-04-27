## code to prepare `example_cloud_matched` dataset goes here
library(nimbus)
library(raster)
example_cloud
example_raster
example_cloud_matched <- match_rasters(
  raster = example_raster,
  cloud = example_cloud
)
usethis::use_data(example_cloud_matched, overwrite = TRUE,
                  compress = "bzip2")
