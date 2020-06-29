source("script/clean_automatica.R")

# Diretório dos arquivos de dados
directory = choose.dir(default = here())

x = start(directory)

# Testar se faltam linhas (datas) nos dados
source(here("script",
            "checar_dados.R"),
       encoding = "utf-8")

checar_datas(x)

# SALVAR
write.csv(new_data,
          here("result",
               paste0(arq_final, ".csv")),
          row.names = F)
