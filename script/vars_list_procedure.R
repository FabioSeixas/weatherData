

vars_list_procedure = function(data){
  
  var_vec = c()
  
  for(i in 1:(ncol(data))){
    
    str_remove_all(names(data)[i], 
                   pattern = fixed("...")) %>%
      str_remove_all(pattern = fixed("(%)")) %>%
      str_remove_all(pattern = fixed("(°C)")) %>%
      str_remove_all(pattern = fixed("(hPa)")) %>%
      str_remove_all(pattern = fixed("(m/s)")) %>%
      str_remove_all(pattern = fixed("(graus)")) %>%
      str_remove_all(pattern = fixed("(graus)")) %>%
      str_remove_all(pattern = fixed("(mm)")) %>%
      str_remove_all(pattern = fixed("(KJ/M²)")) %>%
      str_remove_all(pattern = fixed(i)) %>%
      str_trim() -> var_vec[i]
  }
  
  var_vec = as.factor(var_vec)
  
  for(i in var_vec %>% levels){
    if(str_count(i) == 0){
      var_vec = droplevels(var_vec, i)
    }
  }
  
  
  ##############################
  dic = c()
  
  for(i in 1:(var_vec %>%
              levels %>%
              length)){
    for(n in 1:(vars_list %>%
                length)){
      if((levels(var_vec)[i]) %in% (vars_list[[n]])){
        
        print(paste("Encontrado: ", levels(var_vec)[i],
                    " e ", names(vars_list)[n]))
        
        key = names(vars_list)[n]
        
        value = levels(var_vec)[i]
        
        names(value) = key
        
        dic = c(dic, value)
        
      }
    }
  } 
  
  return(dic)
  
}