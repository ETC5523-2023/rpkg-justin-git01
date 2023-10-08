#' Calculate Average Value by Categorical Variable
#'
#' This function calculates the average of values from the numeric variable provided
#' for each unique value within a chosen
#' categorical variable in the given dataset, even if values are grouped together.
#'
#' @param dataset A data frame containing the dataset.
#' @param categorical_var The name of the categorical variable.
#' @param numeric_var The name of the rating variable.
#'
#' @return A data frame with unique values of the chosen categorical variable
#'         and their corresponding average numeric values.
#'
#' @examples
#' data <- data.frame(Genre = c("action, sci-fi", "comedy", "action, drama", "sci-fi, fantasy"),
#'                   Rating = c(4.5, 3.8, 4.0, 3.2))
#' result <- what_ave(data, categorical_var = "Genre", numeric_var = "Rating")
#' print(result)

#'
#' @import tidyr
#'
#' @export
what_ave <- function(dataset, categorical_var, numeric_var) {

  # Split grouped values into separate rows
  dataset <- dataset %>%
    separate_rows({{categorical_var}}, sep = ",\\s*")

  # Group the data by the chosen categorical variable and calculate average rating
  result <- dataset %>%
    dplyr::group_by({{categorical_var}}) %>%
    dplyr::summarize(`Average Score` = mean({{numeric_var}}, na.rm = TRUE)) %>%
    dplyr::arrange(desc(`Average Score`))

  return(result)
}
