#' filter_cloud
#'
#' Add NAs to pixels around zero. These NAs then become the clouds
#'
#' @param cloud a cloud raster
#' @param type a choice between speckled and large.
#'
#' @return cloud raster with NAs.
#' @export
#'
#' @examples
#' library(nimbus)
#' library(raster)
#' cloud <- simulate_cloud(phi = 0.1, seed = 2023)
#' plot(cloud)
#' speckled_cloud_raster <- filter_cloud(cloud)
#' large_cloud_raster <- filter_cloud(cloud, type = "large")
#' plot(speckled_cloud_raster, colNA = "blue")
#' plot(large_cloud_raster, colNA = "blue")
filter_cloud <- function(cloud, type = "speckled"){
  if(type == "speckled"){
    cloud[cloud > -0.5 & cloud < 0.15] <- NA
  } else {
    cloud[cloud > 0.8 & cloud < 4] <- NA
  }
  cloud
}
# library(nimbus)
# library(raster)
# cloud <- simulate_cloud(phi = 0.1, seed = 2023)
# plot(cloud)
# speckled_cloud_raster <- filter_cloud(cloud)
# large_cloud_raster <- filter_cloud(cloud, type = "large")
# plot(speckled_cloud_raster, colNA = "blue")
# plot(large_cloud_raster, colNA = "blue")
