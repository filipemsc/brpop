test_that("pop uf is consistent", {
  res <- uf_pop_age() %>%
    dplyr::group_by(year, age_group) %>%
    dplyr::summarise(freq = sum(pop, na.rm = TRUE)) %>%
    dplyr::ungroup() %>%
    dplyr::group_by(freq) %>%
    dplyr::summarise(count = dplyr::n()) %>%
    dplyr::filter(count > 1)

  expect_equal(nrow(res), 0)
})
