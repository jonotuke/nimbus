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
#' \donttest{example_raster |> add_cloud(speckled_cloud) |> plot()
#' example_raster |> add_cloud(large_cloud) |> plot()
#' }
add_cloud <- function(raster, cloud){
  raster <- raster::mask(
    raster,
    mask = cloud
  )
}
# library(nimbus)
# example_raster |> add_cloud(speckled_cloud) |> plot()
# example_raster |> add_cloud(large_cloud) |> plot()
