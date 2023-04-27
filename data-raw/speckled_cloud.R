## code to prepare `speckled_cloud` dataset goes here
example_cloud_matched
speckled_cloud <- filter_cloud(example_cloud_matched, type = "speckled")
usethis::use_data(speckled_cloud, overwrite = TRUE)
