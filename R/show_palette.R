plot_palette <- function(x, label) {

    n <- length(x)
    old <- par(mar = c(0.5, 0.5, 0.5, 0.5))
    on.exit(par(old))

    image(1:n, 1, as.matrix(1:n), col = x,
          ylab = "", xaxt = "n", yaxt = "n", bty = "n")

    rect(0, 0.9, n + 1, 1.1, col = rgb(1, 1, 1, 0.8), border = NA)
    text((n + 1) / 2, 1, labels = label, cex = 1, family = "mono")
}

#' Show supported palette
#'
#' A modified version of [plot.lisa_palette](https://github.com/tyluRp/lisa/blob/master/R/utils.R).
#'
#' @return `NULL`
#' @importFrom grDevices rgb
#' @importFrom graphics image par rect text
#' @export
#'
#' @examples
#' show_palette()
show_palette = function() {
  old <- par(mfrow = c(9, 3))
  on.exit(par(old))
  Map(plot_palette, contribution::palette, colnames(contribution::palette))
}

