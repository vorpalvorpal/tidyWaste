#' The core tidyWaste packages
#'
#' The `core` member packages of the tidyWaste family. These are attached when
#' you run `library(tidyWaste)`.
#'
#' @keywords internal
#' @noRd
core <- c("hydroSense", "meteoHazard")

#' List the tidyWaste family packages
#'
#' `tidyWaste_packages()` lists the core member packages of the tidyWaste
#' family (those attached by `library(tidyWaste)`).
#'
#' @param include_self Include tidyWaste in the list?
#' @return A character vector of package names.
#' @export
#' @examples
#' tidyWaste_packages()
tidyWaste_packages <- function(include_self = TRUE) {
  raw <- utils::packageDescription("tidyWaste")$Imports
  imports <- strsplit(raw, ",")[[1]]
  parsed <- gsub("^\\s+|\\s+$", "", imports)
  names <- vapply(strsplit(parsed, "\\s+"), `[[`, character(1), 1)

  # Only the family members, not infrastructure imports such as cli or rlang.
  names <- intersect(names, core)

  if (include_self) {
    names <- c("tidyWaste", names)
  }

  names
}

tidyWaste_attach <- function() {
  to_load <- core_unloaded()
  if (length(to_load) == 0) {
    return(invisible())
  }

  cli::cli_h1(
    sprintf("Attaching tidyWaste %s", package_version("tidyWaste"))
  )

  versions <- vapply(to_load, package_version, character(1))
  packages <- paste0(
    cli::col_green(cli::symbol$tick), " ",
    cli::col_blue(format(to_load)), " ",
    cli::col_silver(format(versions))
  )

  if (length(packages) %% 2 == 1) {
    packages <- c(packages, "")
  }
  col1 <- seq_len(length(packages) / 2)
  info <- paste0(packages[col1], "     ", packages[-col1])

  cli::cli_verbatim(info)

  suppressPackageStartupMessages(
    lapply(to_load, library, character.only = TRUE, warn.conflicts = FALSE)
  )

  invisible()
}

core_unloaded <- function() {
  loaded <- paste0("package:", core) %in% search()
  core[!loaded]
}

package_version <- function(x) {
  version <- as.character(unclass(utils::packageVersion(x))[[1]])
  if (length(version) > 3) {
    version[4:length(version)] <- cli::col_red(version[4:length(version)])
  }
  paste0(version, collapse = ".")
}

.onAttach <- function(...) {
  needed <- core[!is_attached(core)]
  if (length(needed) == 0) {
    return()
  }

  tidyWaste_attach()
}

is_attached <- function(x) {
  paste0("package:", x) %in% search()
}
