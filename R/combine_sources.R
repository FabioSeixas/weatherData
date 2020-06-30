
#' Title
#' @export
combine_sources = function(first, second, third,
                           add_columns = FALSE,
                           add_rows = FALSE){

  result = combine(first, second,
                   add_columns, add_rows)

  return(result)
}

fill_na = function(x, y){
  for(i in 1:length(x)){
    if(is.na(x[i])){
      x[i] = y[i]
    }
  }
  return(x)
}

combine = function(x, y, add_columns = FALSE, add_rows = FALSE){
  vars = names(x)[-1]

  y %>%
    filter(Data >= x$Data[1],
           Data <= dplyr::last(x$Data)) -> y_red

  for(var in vars){
    if(is.null(y_red[[var]])) next
    x[var] = fill_na(x[[var]], y_red[[var]])
  }

  # Add columns

  # NOT WORKING!
  # combine_sources(xavier, auto, add_columns = T)
  # DIFFERENT LENGTH VECTORS
  if(add_columns){
    log_vec = !(names(y) %in% names(x))
    if(sum(log_vec)){
      vars = names(y)[log_vec]
      for(var in vars){
        x[var] = y_red[var]
      }
    }
  }

  # Add rows
  if(add_rows){
    y %>%
      filter(Data > dplyr::last(x$Data) |
             Data < x$Data[1]) %>%
      bind_rows(x) %>%
      arrange(Data) %>%
      select(names(x)) -> x
  }

  x = dates_check_procedure(x)

  return(x)
}










