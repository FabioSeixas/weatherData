#' Title
#' @import dplyr
#' @import tidyr
#' @import readr
#' @export
read_conventional = function(directory, dates_complete = FALSE){

  read_delim(directory, skip = 16, delim = ";") %>%
    mutate(Data = lubridate::dmy(Data)) %>%
    group_by(Data) %>%
    summarise(prec = sum(Precipitacao, na.rm = T),
              temp_min = min(TempMinima, na.rm = T),
              temp_max = max(TempMaxima, na.rm = T),
              rh_avg = mean(`Umidade Relativa Media`, na.rm = T),
              vento = mean(`Velocidade do Vento Media`, na.rm = T)) %>%
    mutate(across(where(is.numeric),
                  ~inf_to_NA(.x))) -> final_data

  final_data = dates_check_procedure(final_data, dates_complete)

  return(final_data)
}

