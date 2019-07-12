#' Generate contribution table
#'
#' @inheritParams ggplot2::labs
#' @param data a `data.frame`. e.g. `data("demo")`.
#' @param color_map color map for discrete order, either a length-3 vector for 3 contribution level:
#' None, Minor and Major; or a `Scale` object like `scale_fill_brewer(palette ="Oranges")`.
#' @param palette_name palette_name for plotting continuous contributions.
#' See [show_palette] for available options.
#' @param show_legend if `TRUE`, show figure legend.
#' @param font_size_x font size for x.
#' @param font_size_y font size for y.
#' @param text_angle_x text angle for x.
#' @param text_angle_y text angle for y.
#' @param hjust_x hjust for x axis text.
#' @param hjust_y hjust for y axis text.
#' @param vjust_x vjust for x axis text.
#' @param vjust_y vjust for y axis text.
#' @param coord_ratio coordinate ratio.
#' @param xlab x axis label.
#' @param ylab y axis label.
#'
#' @importFrom rlang .data
#' @importFrom ggplot2 theme element_blank element_rect element_text margin ggplot aes geom_tile
#' scale_x_discrete scale_fill_manual coord_fixed labs xlab ylab scale_fill_gradientn
#' @return a `ggplot2` object
#' @export
#'
#' @examples
#' library(contribution)
#' library(ggplot2)
#' 
#' # Paper contributions
#' generate(demo)
#' generate(demo, text_angle_x = 20, color_map = scale_fill_brewer(palette = "Oranges"))
#' 
#' # Github project contributions
#' my_contr <- dplyr::tibble(
#'   repo = c("UCSCXenaTools", "maftools"),
#'   owner = c("ShixiangWang", "PoisonAlien"),
#'   username = "ShixiangWang",
#'   role = c("Developer", "Contributor")
#' )
#' 
#' my_contr
#' contr_tb <- pull_github(data = my_contr)
#' 
#' contr_tb
#' 
#' generate(contr_tb, show_legend = TRUE, hjust_x = 0)
#' generate(contr_tb,
#'   show_legend = TRUE, hjust_x = 0,
#'   palette_name = "psychedelic"
#' )
generate <- function(data,
                     color_map = c("white", "grey", "black"),
                     palette_name = "github",
                     show_legend = FALSE,
                     title = NULL, xlab = NULL, ylab = NULL,
                     caption = NULL, tag = NULL,
                     font_size_x = 16, font_size_y = 16,
                     text_angle_x = 30, text_angle_y = 0,
                     hjust_x = 0.2, hjust_y = 1,
                     vjust_x = 1, vjust_y = 0.5,
                     coord_ratio = 1) {
  stopifnot(is.data.frame(data))
  colnames(data)[1] <- "role"

  data <- data %>%
    tidyr::gather(key = "contributor", value = "contribution", -.data$role)

  if (!is.numeric(data$contribution)) {
    data <- data %>%
      dplyr::mutate(
        contribution = ifelse(is.na(.data$contribution),
          "None",
          .data$contribution
        ),
        contribution = factor(
          .data$contribution,
          levels = c("None", "Minor", "Major")
        )
      )
  }

  theme_sx <- theme(
    panel.grid = element_blank(),
    panel.background = element_rect(fill = "transparent", colour = NA),
    panel.border = element_blank(),
    axis.ticks = element_blank(),
    axis.text = element_text(color = "black"),
    axis.text.x = element_text(
      size = font_size_x, angle = text_angle_x,
      hjust = hjust_x, vjust = vjust_x
    ),
    axis.text.y = element_text(
      size = font_size_y, angle = text_angle_y,
      hjust = hjust_y, vjust = vjust_y
    ),
    plot.margin = margin()
  )

  p <- ggplot(
    data = data,
    mapping = aes(
      x = .data$contributor,
      y = .data$role
    )
  ) +
    geom_tile(aes(fill = .data$contribution),
      color = "black",
      size = 1
    ) +
    scale_x_discrete(position = "top") +
    theme_sx +
    coord_fixed(ratio = coord_ratio)

  if (inherits(color_map, "Scale")) {
    p <- p + color_map
  } else {
    if (is.numeric(data$contribution)) {
      p <- p + scale_fill_gradientn(colors = contribution::palette[[palette_name]])
    } else {
      p <- p + scale_fill_manual(values = color_map)
    }
  }

  if (show_legend) {
    p <- p + labs(fill = "contribution")
  } else {
    p <- p + theme(legend.position = "none")
  }

  p <- p + xlab(xlab) + ylab(ylab) +
    labs(title = title, caption = caption, tag = tag)

  p
}
