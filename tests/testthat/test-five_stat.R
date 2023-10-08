test_that("Test five_stat with numeric vector", {
  numeric_data <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
  result <- five_stat(numeric_data)
  expect_equal(result$Summary, c(1, 3.25, 5.5, 7.75, 10))
})

test_that("Test five_stat with character vector", {
  character_data <- c("A", "B", "A", "C", "B", "D")
  result <- five_stat(character_data)
  expect_equal(result$Frequency, c(2, 2, 1, 1))
})


test_that("Test five_stat with numeric vector less than 5 values", {
  numeric_data <- c(1, 2, 3)
  result <- five_stat(numeric_data)
  expect_null(result)
})

test_that("Test five_stat with other types of input", {
  other_data <- c(TRUE, FALSE, FALSE)
  result <- five_stat(other_data)
  expect_null(result)
})
