## code to prepare `large_cloud` dataset goes here
example_cloud_matched
large_cloud <- filter_cloud(example_cloud_matched, type = "large")
usethis::use_data(large_cloud, overwrite = TRUE)
