## code to prepare `example_cloud` dataset goes here
library(nimbus)
example_cloud <- simulate_cloud(seed = 2023, phi = 0.1)
usethis::use_data(example_cloud, overwrite = TRUE)
