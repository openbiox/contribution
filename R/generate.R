#' Generate contribution table
#'
#' @inheritParams ggplot2::labs
#' @param data a `data.frame`. e.g. `data("demo")`.
#' @param color_map color map, either a length-3 vector for 3 contribution level:
#' None, Some and Many; or a `Scale` object like `scale_fill_brewer(palette ="Oranges")`.
#' @param show_legend if `TRUE`, show figure legend.
#' @param font_size_x font size for x.
#' @param font_size_y font size for y.
#' @param text_angle_x text angle for x.
#' @param coord_ratio coordinate ratio.
#' @param xlab x axis label.
#' @param ylab y axis label.
#'
#' @importFrom rlang .data
#' @importFrom ggplot2 theme element_blank element_rect element_text margin ggplot aes geom_tile
#' scale_x_discrete scale_fill_manual coord_fixed labs xlab ylab
#' @return a `ggplot2` object
#' @export
#'
#' @examples
#' library(contribution)
#' library(ggplot2)
#' generate(demo)
#' generate(demo, text_angle_x = 20, color_map = scale_fill_brewer(palette ="Oranges"))
generate = function(data,
                    color_map=c("white", "grey", "black"),
                    show_legend=FALSE,
                    title=NULL, xlab=NULL, ylab=NULL,
                    caption=NULL, tag=NULL,
                    font_size_x=16, font_size_y=16,
                    text_angle_x=30,
                    coord_ratio=1) {

  data = data %>%
    tidyr::gather(key="contributor", value="contribution", -.data$Class)

  if (!is.numeric(data$contribution)) {
    data = data %>%
      dplyr::mutate(contribution = ifelse(is.na(.data$contribution),
                                          "None",
                                          .data$contribution),
                    contribution = factor(
                      .data$contribution,
                      levels = c("None", "Some", "Many")
                    ))
  }

  theme_sx = theme(
    panel.grid = element_blank(),
    panel.background = element_rect(fill = "transparent",colour = NA),
    panel.border = element_blank(),
    axis.ticks = element_blank(),
    axis.text = element_text(color="black"),
    axis.text.x = element_text(size = font_size_x, angle = text_angle_x, hjust = 0.2),
    axis.text.y = element_text(size = font_size_y),
    plot.margin = margin()
  )

  if (text_angle_x <= 10) {
    theme_sx = theme_sx +
      theme(
        axis.text.x = element_text(hjust = 0.5)
      )
  }

  p = ggplot(data = data,
         mapping = aes(x=.data$contributor,
                       y=.data$Class)) +
    geom_tile(aes(fill=.data$contribution),
                  color="black",
                  size=1) +
    scale_x_discrete(position = "top") +
    theme_sx +
    coord_fixed(ratio=coord_ratio)

  if (inherits(color_map, "Scale")) {
    p = p + color_map
  } else {
    p = p + scale_fill_manual(values = color_map)
  }

  if (show_legend) {
    p = p + labs(fill="contribution")
  } else {
    p = p + theme(legend.position = "none")
  }

  p = p + xlab(xlab) + ylab(ylab) +
    labs(title=title, caption=caption, tag=tag)

  p
}