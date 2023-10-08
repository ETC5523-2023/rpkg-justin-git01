#' Run the IKEA Shiny app
#'
#' This function launches the Shiny app for IKEA data analysis.
#'
#'@return An IKEA furniture showcase app
#'
#' @export

run_app <- function() {
  app_dir <- system.file("ikea-app", package = "animeR")
  shiny::runApp(app_dir, display.mode = "normal")
}
