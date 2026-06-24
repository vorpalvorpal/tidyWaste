test_that("tidyWaste_packages() lists the core members", {
  pkgs <- tidyWaste_packages()
  expect_true(all(c("hydroSense", "meteoHazard") %in% pkgs))
  expect_true("tidyWaste" %in% pkgs)
})

test_that("tidyWaste_packages(include_self = FALSE) drops tidyWaste", {
  expect_false("tidyWaste" %in% tidyWaste_packages(include_self = FALSE))
})

test_that("tidyWaste_conflicts() returns a printable object", {
  cc <- tidyWaste_conflicts()
  expect_s3_class(cc, "tidyWaste_conflicts")
  expect_output(print(cc), "conflict|No conflicts", ignore.case = TRUE)
})
