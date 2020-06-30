
#' Title
#' @import dplyr
dates_check_procedure = function(final_data,
                                 dates_complete = FALSE){

  if(!check_dates(final_data) & dates_complete){
    message("Filling missing dates...")

    old_rows = nrow(final_data)

    seq.Date(from = final_data$Data[1],
             to = dplyr::last(final_data$Data),
             by = 1) %>%
      as_tibble() %>%
      rename("Data" = value) %>%
      left_join(final_data, by = "Data") -> final_data

    message(paste("Date column filling completed.",
                  (nrow(final_data) - old_rows),
                  "rows added."))
    message("Running date check again...")
    check_dates(final_data)
  }

  return(final_data)

}


check_dates = function(data, details = F){

  datas_periodo = seq.Date(from = first(data$Data),
                           to = last(data$Data),
                           by = 1)

  if(sum(datas_periodo == data$Data) == nrow(data)){

    message(paste0("No date missing between ",
                 format(first(data$Data),
                        "%d de %B de %Y")," e ",
                 format(last(data$Data),
                        "%d de %B de %Y")))
    return(TRUE)
  }else{
    message(paste0("There are dates missing between ",
                 format(first(data$Data),
                        "%d de %B de %Y")," e ",
                 format(last(data$Data),
                        "%d de %B de %Y.")))

    if(details){
      print(datas_periodo[!(datas_periodo == data$Data)])
    }

    return(FALSE)
  }
}

