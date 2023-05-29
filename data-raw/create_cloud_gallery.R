pacman::p_load(tidyverse, nimbus, raster)

clouds <- expand_grid(
  form = c("smooth", "pixellated"),
  phi = seq(0, 1, length = 10),
  type = c("speckled", "large")
  )

clouds <-
  clouds |>
  rowwise() |>
  mutate(
    cloud = list(simulate_cloud(cloud_size = 20, phi = phi, form = form)),
    filter_cloud = list(filter_cloud(cloud, type))
  )

plot(clouds$cloud[[3]])
plot(clouds$filter_cloud[[3]], colNA = "blue")
plot(clouds$cloud[[8]])
plot(clouds$filter_cloud[[3]], colNA = "blue")

clouds$cloud[[2]]

cloud <- filter_cloud(clouds$cloud[[2]], type = "large")
plot(cloud, colNA = "blue")

usethis::use_data(cloud_gallery, overwrite = TRUE)
