test_that("message works", {
  expect_message(simulate_cloud(cloud_size = 10, phi = 0.1))
})
