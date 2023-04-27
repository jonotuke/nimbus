#' match_rasters
#'
#' This function matches the simulated cloud so that it is on the same
#' extent and projection as the original raster
#'
#' @param raster original raster to match to.
#' @param cloud simulated cloud
#' @param trace will show some feedback if needed.
#'
#' @return matched cloud raster
#' @export
#'
#' @examples
#' library(raster)
#' plot(example_cloud)
#' \donttest{
#' example_cloud <- match_rasters(example_raster, example_cloud, trace = TRUE)
#' }
#' plot(example_cloud)
match_rasters <- function(raster, cloud, trace = FALSE){
  if(trace){
    print(raster::extent(cloud))
  }
  # Match entent
  raster::extent(cloud) <- raster::extent(raster)
  if(trace){
    print(raster::extent(cloud))
  }
  # Match projection
  if(trace){
    print(raster::proj4string(cloud))
  }
  raster::crs(cloud) <- raster::proj4string(raster)
  if(trace){
    print(raster::proj4string(cloud))
  }
  # Match dimension
  cloud <- raster::projectRaster(
    cloud,
    raster,
    method = 'ngb'
    )
  cloud
}
# library(raster)
# plot(example_cloud)
# example_cloud <- match_rasters(example_raster, example_cloud, trace = TRUE)
# plot(example_cloud)
