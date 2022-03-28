# Raspagem do wikipedia

pacman::p_load(tidyverse, rvest, rio, janitor)

# Que página queremos raspar?
# Prefeitos do Rio de Janeiro
prefs <- "https://pt.wikipedia.org/wiki/Lista_de_prefeitos_da_cidade_do_Rio_de_Janeiro"

pref_pagina <- read_html(prefs)

prefeitos_tables <- pref_pagina |> 
  html_elements("table.wikitable") |> 
  html_table() 

names(prefeitos_tables) <- c("Período imperial", "Período Republicano (até 1960)",
                             "Estado da Guanabara", "Período atual")

names(prefeitos_tables[[1]]) <- prefeitos_tables[[1]][1,]


names(prefeitos_tables[[2]]) <- prefeitos_tables |> 
  pluck(2) |> 
  slice(1)

names(prefeitos_tables[[3]]) <- prefeitos_tables |> 
  pluck(3) |> 
  slice(1)

# names(prefeitos_tables[[4]]) <- prefeitos_tables[[4]][1,]

prefeitos_tables[[1]] <- prefeitos_tables[[1]] |> 
  slice(-1) |> 
  clean_names() |> 
  select(-imagem, -no)

prefeitos_tables[[2]] <- prefeitos_tables[[2]] |> 
  slice(-1) |> 
  clean_names() |> 
  select(-imagem, -no)

prefeitos_tables[[3]] <- prefeitos_tables[[3]] |> 
  slice(-1) |> 
  clean_names() |> 
  select(-imagem, -no)

prefeitos_tables[[4]] <- prefeitos_tables[[4]] |> 
  clean_names() |> 
  select(-c(no, prefeito, retrato, eleicao_nota_1, vice_prefeito_nota_2, vice_prefeito_nota_2_2)) |> 
  rename("nome" = prefeito_2)


prefeitos_rio <- bind_rows(prefeitos_tables) 

prefeitos_rio |> 
  export("meeting_03/prefeitos_rio.xlsx")
