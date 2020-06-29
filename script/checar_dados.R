
checar_datas = function(data){

  datas_periodo = seq.Date(from = first(data$Data),
                           to = last(data$Data),
                           by = 1)
  
  if(sum(datas_periodo == data$Data) == nrow(data)){
    
    print(paste0("Nenhuma data faltando entre ",
                 format(first(data$Data),
                        "%d de %B de %Y")," e ",
                 format(last(data$Data),
                        "%d de %B de %Y")))
  }else{
    print(paste0("Há datas faltando entre ",
                 format(first(data$Data),
                        "%d de %B de %Y")," e ",
                 format(last(data$Data),
                        "%d de %B de %Y."),
                 " Checar dados."))
  }
}

