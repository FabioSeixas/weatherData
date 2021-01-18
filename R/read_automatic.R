#' Title
#' @import dplyr
#' @import tidyr
#' @import readxl
#' @export
read_automatic = function(directory, delim = ',', dates_complete = FALSE){

  for(data_file in dir(directory)){
    start_data_processing(paste0(directory, "\\", data_file), delim) -> data

    final_data = tryCatch({
      left_join(data,
                final_data,
                by = "Data")
    },
    error = function(cond){
      final_data = data
      return(final_data)
    },
    finally = {
      message(paste("O arquivo:", data_file,
                    "terminou de ser processado"))
    })
  }

  dates_check_procedure(final_data, dates_complete)

  return(final_data)
}

start_data_processing = function(file, delim) {
  if (str_ends(file, 'xls')) {
    return (process_xls_data(file))
  }
  if (str_ends(file, 'csv')) {
    return (process_csv_data(file, delim))
  }

}

process_xls_data = function(file){

  data = read_xls(file,
                skip = 9)

  data_inicio = read_xls(file,
                         skip = 10,
                         n_max = 1) %>%
    .[[1, 1]]

  message(paste("Data de início dos dados:",
              format(data_inicio, "%d de %B de %Y")))

  origin = as.Date(data_inicio) - as.integer(data[[2, 1]])

  # Ajustes
  data = data[-1,]
  names(data)[1] = "Data"

  # Variáveis
  vars = vars_list_procedure(data)

  # Extrair variáveis
  new_data = tibble(Data = data$Data) %>%
    mutate(Data = as.Date(as.integer(Data), origin = origin))

  for(variable in vars){
    message(paste("Adicionando", variable, "a tabela"))
    new_data[variable] = extrair_var(data, variable, origin)
  }

  # Colocar nomes das colunas
  names(new_data) = c("Data", names(vars))

  return(new_data)
}

process_csv_data = function(file, delim){

  data = read_delim(file, delim)

  data_inicio = data[[1, 1]]

  message(paste("Data de início dos dados:",
                format(data_inicio, "%d de %B de %Y")))

  origin = as.Date(data_inicio) - as.integer(data[[2, 1]])

  # Ajustes
  data = data[-1,]
  names(data)[1] = "Data"

  # Variáveis
  vars = vars_list_procedure(data)

  # Extrair variáveis
  new_data = tibble(Data = data$Data) %>%
    mutate(Data = as.Date(as.integer(Data), origin = origin))

  for(variable in vars){
    message(paste("Adicionando", variable, "a tabela"))
    new_data[variable] = extrair_var(data, variable, origin)
  }

  # Colocar nomes das colunas
  names(new_data) = c("Data", names(vars))

  return(new_data)
}
