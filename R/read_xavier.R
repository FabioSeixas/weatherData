#' Title
#' @import dplyr
#' @import readr
#' @export
read_xavier = function(directory){

  read_csv(directory) %>%
    select(Data,
           prec = Precipitacao,
           rh_avg = Umidade,
           rad = Radiacao,
           temp_max = Temperatura_Maxima,
           temp_min = Temperatura_Minima,
           vento = Velocidade_do_Vento)
}
