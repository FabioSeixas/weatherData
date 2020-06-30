#' Title
#' @import dplyr
#' @import tidyr
#' @import readxl
#' @export
read_automatic = function(directory){

  for(data_file in dir(directory)){
    process_xls_data(paste0(directory, "\\",
                        data_file)) -> data

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

  return(final_data)
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
