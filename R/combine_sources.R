
#' Title
#' @export
combine_data = function(first, second,
                        add_cols = FALSE,
                        add_rows = FALSE){

  result = combine(first, second,
                   add_cols, add_rows)

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

combine = function(x, y, add_cols = FALSE, add_rows = FALSE){

  na_old_number = sum(is.na(x))
  vars = names(x)[-1]

  y %>%
    filter(Data >= x$Data[1],
           Data <= dplyr::last(x$Data)) -> y_adj

  for(var in vars){
    if(is.null(y_adj[[var]])) next
    x[var] = fill_na(x[[var]], y_adj[[var]])
  }

  message("COMPLETE: NA's filled.")
  message(paste(na_old_number - sum(is.na(x)),
                "values filled."))

  # Add columns
  if(add_cols){
    log_vec = !(names(y_adj) %in% names(x))
    if(sum(log_vec)){
      vars = names(y_adj)[log_vec]

      x = left_join(x, y_adj[c("Data", vars)], by = "Data")
      #for(var in vars){
      #  x[var] = y_red[var]
      #}
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










