#' add_cloud
#'
#' @param raster a raster object
#' @param cloud the cloud object to add
#'
#' @return raster object with clouds
#' @export
#'
#' @examples
#' library(nimbus)
#' library(raster)
#' plot(example_raster)
#' cloud <- example_raster
#' cloud[cloud < 500] <- NA
#' example_raster |> add_cloud(cloud) |> plot()
add_cloud <- function(raster, cloud){
  raster <- raster::mask(
    raster,
    mask = cloud
  )
}
# library(nimbus)
# library(raster)
# plot(example_raster)
# cloud <- example_raster
# cloud[cloud < 500] <- NA
# example_raster |> add_cloud(cloud) |> plot()
