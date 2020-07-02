context("Combine Data")

auto = read_automatic("D:/weatherData/tests/testdata/xls")
conv = read_conventional("D:/weatherData/tests/testdata/case1/conv.txt")
xavier = read_xavier("D:/weatherData/tests/testdata/xavier.csv")

library(waldo)
library(weatherData)

expect_equal_tibbles = function(x, y, test_n,
                                add_rows = F, add_cols = F){
  current = combine_data(x, y, add_rows, add_cols)
  expected = select(read_csv(paste0("D:/weatherData/tests/testdata/case1/test",
                         test_n, ".csv")),
                    names(current))
  print(paste("TESTE", test_n))
  print(current)
  print(expected)
  expect_equal(current,
               expected,
               check.attributes = F)
}

test_that("combination: y starts before x", {

  # x: 'auto'
  expect_equal_tibbles(auto, conv, test_n = 1)

  expect_equal_tibbles(auto, conv, test_n = 2, add_rows = T)

  expect_equal_tibbles(auto, conv, test_n = 3, add_cols = T)

  expect_equal_tibbles(auto, conv, test_n = 4, add_cols = T, add_rows = T)

  expect_equal_tibbles(auto, xavier, test_n = 5)

  expect_equal_tibbles(auto, xavier, test_n = 6, add_rows = T)

  expect_equal_tibbles(auto, xavier, test_n = 7, add_rows = T, add_cols = T)

  expect_equal_tibbles(auto, xavier, test_n = 8, add_cols = T)

  # # x: 'conv'

  expect_equal_tibbles(conv, auto, test_n = 9)

  expect_equal_tibbles(conv, auto, test_n = 10, add_rows = T)

  expect_equal_tibbles(conv, auto, test_n = 11, add_cols = T)

  expect_equal_tibbles(conv, auto, test_n = 12, add_rows = T, add_cols = T)

  expect_equal_tibbles(conv, xavier, test_n = 13)

  expect_equal_tibbles(conv, xavier, test_n = 14, add_rows = T)

  expect_equal_tibbles(conv, xavier, test_n = 15, add_rows = T, add_cols = T)

  expect_equal_tibbles(conv, xavier, test_n = 16, add_cols = T)

})
