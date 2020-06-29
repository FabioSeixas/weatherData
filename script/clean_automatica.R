library(tidyr)
library(dplyr)
library(stringr)
library(readxl)
library(here)

# Variáveis
vars_list = source(here("script",
                        "vars_list.R"),
                   encoding = "utf-8")$value

# Funções necessárias
source(here("script",
            "functions_extrair.R"),
       encoding = "utf-8")

source(here("script",
            "vars_list_procedure.R"),
       encoding = "utf-8")


# Main functions
start = function(directory){
  
  for(data_file in dir(directory)){
    process_data(paste0(directory, "\\",
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



process_data = function(file){
  
  data = read_xls(file,
                skip = 9)
  
  data_inicio = read_xls(file,
                         skip = 10, 
                         n_max = 1) %>%
    .[[1, 1]]
  
  print(paste("Data de início dos dados:", 
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
    print(paste("Adicionando", variable, "a tabela"))
    new_data[variable] = extrair_var(data, variable, origin)
  }
  
  # Colocar nomes das colunas
  names(new_data) = c("Data", names(vars))
  
  return(new_data)
}
