# Funções necessárias
inf_to_NA = function(x){
  
  for(i in 1:(length(x))){
    if(x[i] %in% c(Inf, -Inf)){
      x[i] = NA
    }
  }
  return(x) 
}

extrair_mean = function(data, variable, origin){
  data %>%
    mutate(Data = as.Date(as.integer(Data), origin = origin)) %>%
    select(Data, starts_with(variable)) %>%
    gather(key = "variable", value = "valor", -Data) %>%
    group_by(Data) %>%
    summarise(new_var = mean(as.double(valor), na.rm = T)) %>%
    mutate(new_var = inf_to_NA(new_var)) %>%
    pull(new_var)
}

extrair_max = function(data, variable, origin){
  data %>%
    mutate(Data = as.Date(as.integer(Data), origin = origin)) %>%
    select(Data, starts_with(variable)) %>%
    gather(key = "variable", value = "valor", -Data) %>%
    group_by(Data) %>%
    summarise(new_var = max(as.double(valor), na.rm = T)) %>%
    mutate(new_var = inf_to_NA(new_var)) %>%
    pull(new_var)
}

extrair_min = function(data, variable, origin){
  data %>%
    mutate(Data = as.Date(as.integer(Data), origin = origin)) %>%
    select(Data, starts_with(variable)) %>%
    gather(key = "variable", value = "valor", -Data) %>%
    group_by(Data) %>%
    summarise(new_var = min(as.double(valor), na.rm = T)) %>%
    mutate(new_var = inf_to_NA(new_var)) %>%
    pull(new_var)
}

extrair_sum = function(data, variable, origin){
  data %>%
    mutate(Data = as.Date(as.integer(Data), origin = origin)) %>%
    select(Data, starts_with(variable)) %>%
    gather(key = "variable", value = "valor", -Data) %>%
    group_by(Data) %>%
    summarise(new_var = sum(as.double(valor), na.rm = T)) %>%
    mutate(new_var = inf_to_NA(new_var)) %>%
    pull(new_var)
}

extrair_var = function(data, variable, origin){
  
  if((str_count(variable, c("MÁXIMA", "MAXIMA")) %>%
     sum())){
    return(extrair_max(data, variable, origin))
  }
  
  else if((str_count(variable, c("MÍNIMA", "MINIMA")) %>%
          sum())){
    return(extrair_min(data, variable, origin))
  }
  
  else if((str_count(variable, c("PRECIPITAÇÃO",
                                "RADIACAO")) %>%
          sum())){
    return(extrair_sum(data, variable, origin))
  }
  
  else{
    return(extrair_mean(data, variable, origin))
  }
}
