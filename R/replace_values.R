
#' Title
#' @export
replace_values = function(x, y, var, date, cond = x == 0){

  var = ensym(var)
  cond = enexpr(cond)

  # To register replaced values
  rep_total = 0

  # Run
  if(check_date_input(date)){
    if(is.list(date)){
      for(year_s in names(date)){

        old = pull(filter(x,
                          year(Data) == year_s,
                          month(Data) %in% date[[year_s]]),
                   !!var)

        x = replace_values_year(x, y, var,
                                year_s = year_s,
                                months = date[[year_s]],
                                cond)

        rep_total = count_replaced(old, x, year_s, date,
                                   var, rep_total)

      }
      message(paste(sum(rep_total),
                    "values replaced"))
      return(x)
    }
    else {
      return(replace_values_year(x, y, var, date[1],
                                 months = date[2],
                                 cond))
    }
  }
}

count_replaced = function(old, x, year_s, date, var, rep_total) {

  replaced = sum(!(pull(filter(x,
                               year(Data) == year_s,
                               month(Data) %in% date[[year_s]]),
                        !!var) == old))

  return(c(rep_total, replaced))
}

replace_values_year = function(x, y, var, year_s,
                               months, cond) {

  x %>%
    select(Data, from_x = !!var) %>%
    filter(year(Data) == year_s,
           month(Data) %in% months) %>%
    left_join(select(y, Data, from_y = !!var), by = "Data") %>%
    mutate(from_x = map2_dbl(from_x, from_y,
                             ~replace(.x, eval(cond,
                                               rlang::env(x = .x)),
                                      .y))) %>%
    select(Data, from_x) %>%
    right_join(x, by = "Data") %>%
    mutate(from_x = map2_dbl(.x = from_x, .y = !!var,
                             ~replace(.x, is.na(.x), .y))) %>%
    select(-!!var) %>%
    rename(!!var := from_x) %>%
    arrange(Data)
}

check_date_input = function(date) {

  # Vector
  if(is.numeric(date)){
    if(length(date) == 2){
      year_len = str_split(date[1], "", simplify = T) %>% length
      if(year_len == 4){
        if(date[2] %in% 1:12){
          return(TRUE)
        }
        else{
          message("Incorrect date input:", date[2])
          return(FALSE)
        }

      }
      else {
        message(paste("Incorrect 'date' input:", date[1]))
        return(FALSE)
      }
    }
    else {
      message(paste("Incorrect 'date' input length:", length(date)))
      return(FALSE)
    }
  }

  # List
  if(is.list(date)){
    for(year in names(date)){
      len = str_split(year, "", simplify = T) %>% length
      if(len == 4){
        if(is.numeric(date[[year]])){
          test = map_lgl(date[[year]], function(x) x %in% 1:12)
          if(sum(!test)){
            message(paste("Incorrect date input:",
                          date[[year]][!test],
                          "on year", year))
            return(FALSE)
          }
        }
        else {
          message(paste("Incorrect 'date' input:",
                        class(date[[year]]),
                        "on year", year))
          return(FALSE)
        }
      }
      else{
        message(paste("Incorrect 'date' input:", year))
        return(FALSE)
      }
    }
  }
  else{
    message(paste("Incorrect 'date' input type:", class(date)))
    return(FALSE)
  }
  return(TRUE)
}
