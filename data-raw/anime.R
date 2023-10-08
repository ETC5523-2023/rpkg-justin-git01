## code to prepare `anime` dataset goes here

library(tidyverse)
library(dplyr)
anime <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-04-23/tidy_anime.csv")

# Reformat start_date and end_date
anime$start_date <- as.Date(anime$start_date, format = "%y-%m-%d")
anime$end_date <- as.Date(anime$end_date, format = "%y-%m-%d")

anime <- anime %>%
  group_by(animeID) %>%
  reframe(
    name = first(name),
    title_english = first(title_english),
    title_japanese = first(title_japanese),
    title_synonyms = first(title_synonyms),
    type = first(type),
    source = first(source),
    producers = paste(unique(producers), collapse = ", "),  # Combine producers into a single string
    genre = paste(unique(genre), collapse = ", "),
    studio = paste(unique(studio), collapse = ", "),  # Combine studios into a single string
    episodes = first(episodes),
    status = first(status),
    airing = first(airing),
    start_date = first(start_date),
    end_date = first(end_date),
    duration = first(duration),
    rating = first(rating),
    score = first(score),
    scored_by = first(scored_by),
    rank = first(rank),
    popularity = first(popularity),
    members = first(members),
    favorites = first(favorites),
    synopsis = first(synopsis),
    background = first(background),
    premiered = first(premiered),
    broadcast = first(broadcast),
    related = first(related)
  ) %>%
  ungroup()

# Make new column name start_year
anime <- anime %>%
  mutate(start_year = year(start_date))

usethis::use_data(anime, overwrite = TRUE)
