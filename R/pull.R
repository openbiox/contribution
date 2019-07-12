#' Pull contributions from GitHub
#'
#' @param data a `data.frame` contains columns 'repo', 'owner', 'username' and 'role'.
#' You can also pass them one by one to the following parameters.
#' @param repo repository name.
#' @param owner repository owner.
#' @param username username to pull.
#' @param role user role in this repository.
#' @param report_lines if `TRUE`, report contributed lines.
#' @param type 'all' for the sum of number of additions and deletions,
#' 'add' for the number of additions and 'del' for the number of deletions.
#' @importFrom stats na.omit
#'
#' @return a `data.frame``
#' @export
#'
#' @examples
#' pull_github(
#'   repo = "UCSCXenaTools", owner = "ShixiangWang",
#'   username = "ShixiangWang", role = "developer"
#' )
pull_github <- function(data = NULL, repo = NULL, owner = NULL, username = NULL,
                        role = NULL, report_lines = FALSE, type = c("all", "add", "del")) {
  type <- match.arg(type)

  .pull <- function(repo = NULL, owner = NULL, username = NULL,
                      report_lines = FALSE,
                      type = "all") {
    d <- tryCatch(
      expr = {
        gh::gh(
          "GET /repos/:owner/:repo/stats/contributors",
          owner = owner,
          repo = repo
        )
      }, error = function(e) {
        message("The code didn't run successfuly due to the following reason, \ntypically run it again will pass if your network is fine.")
        message(e)
        invisible(404)
      }
    )

    cc <- sapply(d, function(x, u = NULL, report_lines = FALSE, type = "all") {
      if (x$author$login == u) {
        if (report_lines) {
          y <- dplyr::bind_rows(x$weeks) %>%
            dplyr::summarise(
              add = sum(.data$a), del = sum(.data$d),
              all = .data$add + .data$del
            )
          if (type == "all") {
            y$all
          } else if (type == "add") {
            y$add
          } else if (type == "del") {
            y$del
          }
        } else {
          x$total
        }
      } else {
        NA
      }
    }, u = username, report_lines = report_lines, type = type)
    cc <- as.integer(na.omit(cc))
    if (length(cc) != 0) {
      cc
    } else {
      0L
    }
  }

  if (is.null(data)) {
    stopifnot(
      is.character(repo), is.character(owner),
      is.character(username), is.character(role)
    )
    data <- dplyr::tibble(
      repo = repo,
      owner = owner,
      username = username,
      role = role
    )
  } else {
    stopifnot(
      is.data.frame(data),
      all(c("repo", "owner", "username", "role") %in% colnames(data))
    )
    data <- dplyr::as_tibble(data)
  }

  data <- data %>%
    dplyr::rowwise() %>%
    dplyr::mutate(
      contribution = .pull(.data$repo,
        .data$owner,
        .data$username,
        report_lines = report_lines,
        type = type
      ),
      project = paste(.data$owner, .data$repo, sep = "/")
    )

  data <- data %>%
    dplyr::select(-c("repo", "username", "owner")) %>%
    tidyr::spread(
      key = "project",
      value = "contribution",
      fill = 0L
    )
  data
}
