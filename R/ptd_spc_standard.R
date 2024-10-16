#' SPC Standard Calculations (internal function)
#'
#' Returns a data frame containing SPC fields which are common to all
#'  methodologies, including 'plot the dots'
#'
#' This function is designed to produce consistent SPC charts
#' across Information Department reporting, according to the 'plot the dots'
#' logic produced by NHSI. The function can return either a plot or data frame.
#'
#' @inheritParams ptd_spc
#' @param options created by `spcOptions()` function
#'
#' @noRd
ptd_spc_standard <- function(.data, options = NULL) {
  # get values from options
  value_field <- options[["value_field"]]
  date_field <- options[["date_field"]]
  facet_field <- options[["facet_field"]]
  mean_field <- options[["mean_field"]]
  fix_after_n_points <- options[["fix_after_n_points"]]
  traj_field <- options[["trajectory"]]

  # constants
  limit <- 2.66
  limitclose <- 2 * (limit / 3)

  assertthat::assert_that(
    is.null(traj_field) | traj_field %in% names(.data),
    msg = paste0("Trajectory field (", traj_field, ") not found in .data")
  )
  assertthat::assert_that(
    is.null(facet_field) | facet_field %in% names(.data),
    msg = paste0("Facet field (", facet_field, ") not found in .data")
  )
  assertthat::assert_that(
    is.null(mean_field) | mean_field %in% names(.data),
    msg = paste0("Mean field (", mean_field, ") not found in .data")
  )

  .data |>
    dplyr::mutate(
      traj = dplyr::if_else(is.null(traj_field), NA_real_, .data[[traj_field]]),
      # If no facet field is specified, bind a pseudo-facet field for
      # grouping/joining purposes.
      f = dplyr::if_else(is.null(facet_field), "no facet", .data[[facet_field]])
    ) |>
    dplyr::select(
      x = tidyselect::any_of(date_field),
      y = tidyselect::any_of(value_field),
      "f",
      "rebase",
      trajectory = "traj"
    ) |>
    dplyr::arrange(dplyr::pick(c("f", "x"))) |>
    # convert rebase 0/1s to group indices
    dplyr::mutate(rebase_group = cumsum(.data[["rebase"]]), .by = "f") |>
    dplyr::mutate(
      fix_y = dplyr::if_else(
        dplyr::row_number() <= (fix_after_n_points %||% Inf), .data[["y"]], NA_real_
      ),
      mean_col = dplyr::if_else(
        is.null(mean_field),
        mean(.data[["fix_y"]], na.rm = TRUE),
        .data[[mean_field]]
      ),

      mr = c(NA, abs(diff(.data[["fix_y"]]))),
      amr = mean(.data[["mr"]], na.rm = TRUE),

      # screen for outliers
      mr = dplyr::case_when(
        !options[["screen_outliers"]] ~ .data[["mr"]],
        .data[["mr"]] < 3.267 * .data[["amr"]] ~ .data[["mr"]],
        .default = NA_real_
      ),
      amr = mean(.data[["mr"]], na.rm = TRUE),

      # identify lower/upper process limits
      lpl = .data[["mean_col"]] - (limit * .data[["amr"]]),
      upl = .data[["mean_col"]] + (limit * .data[["amr"]]),
      
      # identify near lower/upper process limits
      nlpl = .data[["mean_col"]] - (limitclose * .data[["amr"]]),
      nupl = .data[["mean_col"]] + (limitclose * .data[["amr"]]),

      # identify any points which are outside the upper or lower process limits
      outside_limits = (.data[["y"]] > .data[["upl"]] | .data[["y"]] < .data[["lpl"]]), # nolint
      # identify whether a point is above or below the mean
      relative_to_mean = sign(.data[["y"]] - .data[["mean_col"]]),

      # Identify if a point is between the near process limits and process
      # limits.
      close_to_limits = !.data[["outside_limits"]] & (.data[["y"]] < .data[["nlpl"]] | .data[["y"]] > .data[["nupl"]]), # nolint

      .by = c("f", "rebase_group")
    ) |>
    # clean up by removing columns that no longer serve a purpose
    dplyr::select(!c("mr", "nlpl", "nupl", "amr", "rebase"))
}
