library(tidyverse)
library(here)

file = choose.files()

data = read_delim(file,
                  delim = ";",
                skip = 16) %>%
  select(-c(Estacao, X10))

data %>%
  mutate(Data = as.Date(Data, format = "%d/%m/%Y")) %>%
  group_by(Data) %>%
  summarise_at(.vars = c("TempMaxima", "TempMinima",
                         "Umidade Relativa Media",
                         "Velocidade do Vento Media"), 
               .funs = mean, na.rm = T) -> first_part
  
data %>%
  mutate(Data = as.Date(Data, format = "%d/%m/%Y")) %>%
  group_by(Data) %>%
  summarise_at(.vars = c("Insolacao",
                         "Precipitacao"), 
               .funs = sum, na.rm = T) %>%
  full_join(first_part, by = "Data") -> final_data


# Testar se faltam linhas (datas) nos dados
source(here("script",
            "checar_dados.R"),
       encoding = "utf-8")$value

checar_datas(final_data)


# Salvar














