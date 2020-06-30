#' Title
#'
#' @import dplyr
#' @import tidyr
#' @import lubridate
#' @import tidyselect
#' @export
monthly_summary = function(x) {

  if(class(x$Data) != "Date"){
    x = x %>%
      mutate(Data = lubridate::ymd(Data))
  }

  x %>%
    group_by(year = lubridate::year(Data),
             month = lubridate::month(Data)) %>%
    summarise(across(where(is.numeric),
                     .fns = list(AVG = ~mean(.x, na.rm = T),
                                 MAX = ~max(.x, na.rm = T),
                                 MIN = ~min(.x, na.rm = T),
                                 SUM = ~sum(.x, na.rm = T)))) %>%
    mutate(across(where(is.numeric),
                  ~inf_to_NA(.x))) %>%
    group_by(month) %>%
    select(-year) %>%
    summarise(across(where(is.numeric),
                     ~mean(.x, na.rm = T))) %>%
    mutate(month = lubridate::month(month,
                                    label = T)) %>%
    pivot_longer(cols = -month) %>%
    pivot_wider(id_cols = name,
                names_from = month,
                values_from = value)

}

