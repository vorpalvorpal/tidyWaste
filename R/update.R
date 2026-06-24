#' Update tidyWaste family packages
#'
#' `tidyWaste_update()` reports which core tidyWaste packages are installed and
#' their versions, and prints the \pkg{pak} command to (re)install them from
#' their GitHub remotes. It does not install anything itself.
#'
#' @return Invisibly, a data frame with one row per family package.
#' @export
#' @examples
#' \dontrun{
#' tidyWaste_update()
#' }
tidyWaste_update <- function() {
  pkgs <- tidyWaste_packages(include_self = FALSE)

  installed <- vapply(pkgs, function(p) {
    tryCatch(as.character(utils::packageVersion(p)),
             error = function(e) NA_character_)
  }, character(1))

  out <- data.frame(
    package = pkgs,
    installed = installed,
    stringsAsFactors = FALSE
  )

  cli::cli_h1("tidyWaste family")
  for (i in seq_len(nrow(out))) {
    v <- out$installed[i]
    if (is.na(v)) {
      cli::cli_alert_danger("{.pkg {out$package[i]}} (not installed)")
    } else {
      cli::cli_alert_info("{.pkg {out$package[i]}} {.field {v}}")
    }
  }

  remotes <- c("vorpalvorpal/hydroSense", "vorpalvorpal/meteoHazard")
  cli::cli_text("")
  cli::cli_text("To (re)install the latest from GitHub:")
  cli::cli_code(
    sprintf('pak::pak(c(%s))',
            paste0('"', remotes, '"', collapse = ", "))
  )

  invisible(out)
}
