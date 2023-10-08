## code to prepare `ikea` dataset goes here

library(tidyverse)

ikea <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-11-03/ikea.csv')
ikea <- ikea[, -1]
ikea <- ikea %>% mutate(discount = ifelse(old_price == "No old price", "On sale", "NOT on sale"))
ikea <- ikea %>% mutate(depth = ifelse(is.na(depth), "NA", depth),
                        height = ifelse(is.na(height), "NA", height),
                        width = ifelse(is.na(width), "NA", width))
price_range <- range(ikea$price)

usethis::use_data(ikea, overwrite = TRUE)
