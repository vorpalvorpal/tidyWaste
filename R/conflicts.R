#' Conflicts between tidyWaste packages and other packages
#'
#' `tidyWaste_conflicts()` lists every function exported by a core tidyWaste
#' package that shares a name with a function attached elsewhere on the search
#' path. Such names resolve differently depending on attach order, so they are
#' worth qualifying explicitly (e.g. `hydroSense::foo()`).
#'
#' @return A `tidyWaste_conflicts` object (a named list mapping each conflicted
#'   function name to the packages that provide it, in search-path order). It
#'   has a print method.
#' @export
#' @examples
#' \dontrun{
#' tidyWaste_conflicts()
#' }
tidyWaste_conflicts <- function() {
  envs <- grep("^package:", search(), value = TRUE)
  pkgs <- sub("^package:", "", envs)

  # function name -> packages providing it, preserving search-path order
  functions <- lapply(envs, env_functions)
  names(functions) <- pkgs

  all_names <- unique(unlist(functions))
  providers <- lapply(all_names, function(nm) {
    pkgs[vapply(functions, function(fns) nm %in% fns, logical(1))]
  })
  names(providers) <- all_names

  # Keep names provided by a core package and at least one other package.
  conflicted <- Filter(
    function(p) any(p %in% core) && length(p) > 1,
    providers
  )

  structure(conflicted, class = "tidyWaste_conflicts")
}

env_functions <- function(env) {
  e <- as.environment(env)
  nms <- ls(envir = e)
  nms[vapply(nms, exists, logical(1),
             envir = e, mode = "function", inherits = FALSE)]
}

#' @export
print.tidyWaste_conflicts <- function(x, ...) {
  if (length(x) == 0) {
    cli::cli_alert_success("No conflicts between tidyWaste packages")
    return(invisible(x))
  }

  cli::cli_h1("tidyWaste conflicts")
  for (nm in names(x)) {
    winner <- x[[nm]][[1]]
    others <- x[[nm]][-1]
    cli::cli_text(
      "{.fn {nm}}: {cli::col_blue(winner)} masks ",
      "{.val {paste0(others, '::', nm)}}"
    )
  }
  invisible(x)
}
