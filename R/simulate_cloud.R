#' simulate cloud
#'
#' Simulates a cloud raster
#'
#' @param cloud_size the size of the grid along each axis.
#' @param phi parameter to control the structure of the cloud
#' @param seed a seed to pass to ensure reproducibility
#' @param form type of cloud, either smooth or pixellated
#'
#' @return a raster object of simulated clouds
#' @export
#'
#' @examples
#' library(raster)
#' cloud <- simulate_cloud(cloud_size = 10, phi = 0.1)
#' plot(cloud)
simulate_cloud <- function(cloud_size = 70,
                           phi, seed = NULL,
                           form = "smooth"
){
  # Check seed
  if(is.null(seed)){
    message("Not seed passed so set to 2023")
    seed <- 2023
  }
  # Set up grid
  cloud_grid <- tidyr::expand_grid(
    X = 1:cloud_size,
    Y = 1:cloud_size
  )
  # Number of pixels
  n_pixels <- nrow(cloud_grid)
  # Get distance matrix D
  D <- as.matrix(stats::dist(cloud_grid))
  # Simulate cloud pixels
  ## Set seed
  set.seed(seed)
  if(form == "smooth"){
    Sigma <- exp(exp(-phi * D^2))
  } else {
    Sigma <- exp(exp(-phi * D))
  }
  ## Simulate pixels
  cloud_grid$Z <- mgcv::rmvn(
    n = 1,
    mu = rep(0, n_pixels),
    V = Sigma
  )
  ## Convert to raster
  cloud_raster <- raster::rasterFromXYZ(cloud_grid)
  cloud_raster
}
# pacman::p_load(tidyverse, targets, raster)
# cloud <- simulate_cloud(cloud_size = 10, phi = 0.1)
# plot(cloud)
