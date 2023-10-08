#' Five Statistics
#'
#' This function summarizes a vector of data based on its type and length.
#' If the input is a numeric vector with at least 5 values, it returns a data frame
#' with the five-number summary. If the input is a character or factor vector,
#' it returns a data frame with value frequencies. For other types of input or
#' numeric vectors with less than 5 values, it returns NULL.
#'
#' @param input_vector A vector of data to be summarized.
#'
#' @return A data frame with summaries or frequencies, or NULL.
#'
#' @examples
#' # Numeric vector with at least 5 values
#' numeric_data <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
#' five_stat(numeric_data)
#'
#' # Character vector
#' character_data <- c("A", "B", "A", "C", "B", "D")
#' five_stat(character_data)
#'
#' # Numeric vector with less than 5 values
#' short_numeric_data <- c(1, 2, 3)
#' five_stat(short_numeric_data)
#'
#' # Other types of input
#' other_data <- c(TRUE, FALSE, TRUE)
#' five_stat(other_data)
#'
#' @export
five_stat <- function(input_vector) {
  if (is.numeric(input_vector) && length(input_vector) >= 5) {
    # For a numeric vector with at least 5 values, return a data frame
    summary_values <- c(min(input_vector), quantile(input_vector, 0.25), median(input_vector), quantile(input_vector, 0.75), max(input_vector))
    summary_names <- c("Minimum", "Q1", "Median", "Q3", "Maximum")
    result_df <- data.frame(Value = summary_names, Summary = summary_values)
    return(result_df)
  } else if (is.character(input_vector) || is.factor(input_vector)) {
    # For a character or factor vector, return a data frame with frequencies
    freq_table <- table(input_vector)
    result_df <- data.frame(Value = names(freq_table), Frequency = as.vector(freq_table))

    return(result_df)
  } else {
    # For a numeric vector with less than 5 values or other types, return NULL
    return(NULL)
  }
}
