#' IKEA Furniture
#'
#' A dataset that contains a wide range of Ikea furniture, classified
#' by multiple variables, such as categories, name, id, price, etc.
#'
#' @format A data frame with 3,694 rows and 14 variables
#' \describe{
#'    \item{item_id}{Item id wich can be used later to merge with other IKEA dataframes}
#'    \item{name}{The commercial name of items}
#'    \item{category}{The furniture category that the item belongs to (Sofas, beds, chairs, Trolleys,…)}
#'    \item{price}{The current price in Saudi Riyals as it is shown in the website by 4/20/2020}
#'    \item{old_price}{The price of item in Saudi Riyals before discount, otherwise "No old price" shown}
#'    \item{sellable_online}{Sellable online TRUE or FALSE}
#'    \item{link}{The web link of the item}
#'    \item{other_colors}{If other colors are available for the item, or just one color as displayed in the website (Boolean)}
#'    \item{short_description}{A brief description of the item}
#'    \item{designer}{The name of the designer who designed the item. this is extracted from the full_description column.}
#'    \item{depth}{Depth of the item in Centimeter}
#'    \item{height}{Height of the item in Centimeter}
#'    \item{width}{Width of the item in Centimeter}
#'    \item{discount}{Whether the item On sale or NOT onsale}
#' }
#' @source \url{https://github.com/rfordatascience/tidytuesday/blob/master/data/2020/2020-11-03/ikea.csv}

"ikea"
