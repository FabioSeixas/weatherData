

#' Title
#' @import rlang
#' @export
monthly_diff = function(x, y, var, fun){

  fun = enexpr(fun)
  var = enexpr(var)

  fun = rlang::call2(fun,
                     x = expr(x),
                     na.rm = T)

  x %>%
    group_by(year = year(Data),
             month = month(Data)) %>%
    summarise(from_x = eval(fun,
                            rlang::env(x = !!var))) -> x_group


  y %>%
    group_by(year = year(Data),
             month = month(Data)) %>%
    summarise(from_y = eval(fun,
                            rlang::env(x = !!var))) %>%
    right_join(x_group, by = c("year", "month")) %>%
    mutate(diff = abs(from_x - from_y)) %>%
    select(year, month, from_x, everything())
}
