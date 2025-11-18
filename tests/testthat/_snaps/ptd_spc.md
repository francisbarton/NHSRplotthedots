# it outputs expected content

    Code
      summary(s1)
    Output
      Plot the Dots SPC options:
      ================================
      value_field:          'y'
      date_field:           'x'
      facet_field:          not set
      rebase:               not set
      fix_after_n_points:   not set
      improvement_direction:'increase'
      target:               not set
      trajectory:           not set
      screen_outliers:      'TRUE'
      --------------------------------
      tibble [1, 8]
      mean_col                  dbl 0.141624
      lpl                       dbl -3.01138
      upl                       dbl 3.294627
      n                         int 20
      common_cause              int 20
      special_cause_improvement int 0
      special_cause_concern     int 0
      variation_type            chr common_cause

---

    Code
      summary(s2)
    Output
      Plot the Dots SPC options:
      ================================
      value_field:          'y'
      date_field:           'x'
      facet_field:          not set
      rebase:               '2020-01-01'
      fix_after_n_points:   not set
      improvement_direction:'increase'
      target:               not set
      trajectory:           not set
      screen_outliers:      'TRUE'
      --------------------------------
      tibble [1, 9]
      rebase_group              dbl 0
      mean_col                  dbl 0.141624
      lpl                       dbl -3.01138
      upl                       dbl 3.294627
      n                         int 20
      common_cause              int 20
      special_cause_improvement int 0
      special_cause_concern     int 0
      variation_type            chr common_cause

---

    Code
      summary(s3)
    Output
      Plot the Dots SPC options:
      ================================
      value_field:          'y'
      date_field:           'x'
      facet_field:          'facet'
      rebase:               not set
      fix_after_n_points:   not set
      improvement_direction:'increase'
      target:               not set
      trajectory:           not set
      screen_outliers:      'TRUE'
      --------------------------------
      tibble [2, 9]
      f                         dbl 0 1
      mean_col                  dbl 0.074626 0.208622
      lpl                       dbl -2.600585 -3.279005
      upl                       dbl 2.749837 3.696249
      n                         int 10 10
      common_cause              int 10 10
      special_cause_improvement int 0 0
      special_cause_concern     int 0 0
      variation_type            chr common_cause common_cause

---

    Code
      summary(s4)
    Output
      Plot the Dots SPC options:
      ================================
      value_field:          'y'
      date_field:           'x'
      facet_field:          'facet'
      rebase:               '2020-01-01'
      fix_after_n_points:   not set
      improvement_direction:'increase'
      target:               not set
      trajectory:           not set
      screen_outliers:      'TRUE'
      --------------------------------
      tibble [2, 10]
      f                         dbl 0 1
      rebase_group              dbl 0 0
      mean_col                  dbl 0.074626 0.208622
      lpl                       dbl -2.600585 -3.279005
      upl                       dbl 2.749837 3.696249
      n                         int 10 10
      common_cause              int 10 10
      special_cause_improvement int 0 0
      special_cause_concern     int 0 0
      variation_type            chr common_cause common_cause

---

    Code
      summary(s5)
    Output
      Plot the Dots SPC options:
      ================================
      value_field:          'y'
      date_field:           'x'
      facet_field:          not set
      rebase:               not set
      fix_after_n_points:   not set
      improvement_direction:'increase'
      target:               '0.5'
      trajectory:           not set
      screen_outliers:      'TRUE'
      --------------------------------
      tibble [1, 9]
      mean_col                  dbl 0.141624
      lpl                       dbl -3.01138
      upl                       dbl 3.294627
      n                         int 20
      common_cause              int 20
      special_cause_improvement int 0
      special_cause_concern     int 0
      variation_type            chr common_cause
      assurance_type            chr a

# summary with a target

    Plot the Dots SPC options:
    ================================
    value_field:          'y'
    date_field:           'x'
    facet_field:          not set
    rebase:               not set
    fix_after_n_points:   not set
    improvement_direction:'increase'
    target:               '0.5'
    trajectory:           not set
    screen_outliers:      'TRUE'
    --------------------------------
    tibble [1, 9]
    mean_col                  dbl 0.141624
    lpl                       dbl -3.01138
    upl                       dbl 3.294627
    n                         int 20
    common_cause              int 20
    special_cause_improvement int 0
    special_cause_concern     int 0
    variation_type            chr common_cause
    assurance_type            chr inconsistent

