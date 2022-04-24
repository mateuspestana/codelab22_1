# Raspagem da CPI da Pandemia

pacman::p_load(
  tidyverse,
  rvest,
  hrbrthemes,
  janitor,
  rio,
  stopwords,
  lubridate
)


# Qual o link da comissão?

# https://legis.senado.leg.br/comissoes/comissao?codcol=2441

link_qualquer <- "https://www25.senado.leg.br/web/atividade/notas-taquigraficas/-/notas/r/10342"

# Como obter qual a fala de cada deputado?

df_fala <- read_html(link_qualquer) |> 
  html_elements(".principalStyle") |>
  html_text() |>
  as.data.frame() |>
  rename("fala" = 1) |> 
  mutate(autor = str_squish(str_extract(fala, "[OA] SRA?. [A-Z áéíóúàèìòùãõâêîôûÁÉÍÓÚÀÈÌÒÙÃÕÂÊÎÔÛ.]*"))) |>
  mutate(comentario = paste(
    str_extract_all(fala, "\\([A-Za-z0-9/áéãõêÃÕÉÁ \\.\\-]*\\)")
  )) |> 
  slice(-1) |> 
  mutate(
    autor = ifelse(autor == "character(0)", NA, autor),
    comentario = ifelse(comentario == "character(0)", NA, comentario)
  ) |>
  fill(autor, .direction = "down") |>
  fill(comentario, .direction = "down") |>
  mutate(
    fala = str_remove_all(fala, pattern = autor),
    fala = str_remove_all(fala, pattern = comentario),
    fala = str_remove_all(fala, pattern = "\\(|\\)"),
    fala = str_squish(fala),
    autor = str_squish(str_to_title(str_remove_all(autor, "[OA] SRA?."))),
    comentario = str_remove_all(comentario, pattern = "\\(|\\)")
    ) 

# Como obter o número da sessão e a data?

info <- read_html(link_qualquer) |>
  html_elements("h1") |>
  html_text() |>
  nth(3)

arquivo <-  info |>
  str_remove_all("-|ª|\\/") |>
  str_squish() |>
  str_replace_all(" ", "_")

sessao <- info |>
  str_split(pattern = "-") |> 
  unlist() |> 
  str_squish() 

data_cpi <- sessao |> nth(1)

# Como obter o ID da sessão?

id_sessao <- str_extract(link_qualquer, "/r/\\d*") |> 
  str_remove("/r/") |> 
  as.integer()

# Salvando o arquivo da 69ª sessão, de ID 10342:


df_fala |> 
  mutate(data = data_cpi) |> 
  write.csv2(
    paste0("meeting_03/sessao_", 
           str_remove(sessao[2], "ª"),
           "_",
           str_extract(arquivo, "\\d{8}"),
           "_ID-", 
           as.character(id_sessao), 
           ".csv")
  )

# OK, mas e como baixamos TODAS? 

## Podemos criar uma função para tal. 
## Basta voltarmos à página da comissão e listarmos todas os eventos existentes. 

pagina_cpi <-"https://legis.senado.leg.br/comissoes/comissao?codcol=2441&data1=2020-04-20&data2=2022-04-27"

ids <- read_html(pagina_cpi) |>
  html_elements("div.reunioesOuEventos") |> 
  html_elements("a") |> 
  html_attr("href") |> 
  str_subset("notas-taquigraficas") |> 
  str_extract_all("\\d{4,}") |> 
  unlist()

# Mas como baixar todos? Vamos criar uma função

pegaIDS <- function(url = "https://legis.senado.leg.br/comissoes/comissao?codcol=2441&data1=2020-04-20&data2=2022-04-27") {
  ids <- read_html(url) |>
    html_elements("div.reunioesOuEventos") |> 
    html_elements("a") |> 
    html_attr("href") |> 
    str_subset("notas-taquigraficas") |> 
    str_extract_all("\\d{4,}") |> 
    unlist()
  cat("Todas as notas taquigráficas baixadas.\n")
  cat(paste("Total:", length(ids), "sessões.\n"))
  return(ids)
}

ids <- pegaIDS()

# Agora que temos um objeto com todos os IDs,
# vamos criar a função que baixa a planilha de cada ID. 
# Podemos copiar partes do código de cima, que é funcional!

baixaNotas <- function(id, extensao = "xlsx") {
  
  # Usa o link padrão como esqueleto, e adicionamos o ID
  link <-
    paste0(
      "https://www25.senado.leg.br/web/atividade/notas-taquigraficas/-/notas/r/",
      id
    )
  
  # Baixa a página e guarda em um objeto
  pagina <- read_html(link)
  
  # Pega o cabeçalho de informações
  info <- pagina |>
    html_elements("h1") |>
    html_text() |>
    nth(3)
  
  # Salva um objeto para nome de arquivo
  arquivo <- info |>
    str_remove_all("-|ª|\\/") |>
    str_squish() |>
    str_replace_all(" ", "_")
  
  # Salva o nome da sessão
  sessao <- info |>
    str_split(pattern = "-") |>
    unlist() |>
    str_squish()
  
  # Mensagem para o usuário avisando que o sistema está funcionando!
  cat(paste("Baixando",
            sessao[2],
            "sessão de ID",
            id,
            "realizada em",
            sessao[1],
            "\n"))
  
  # Aqui começamos a baixar a tabela
  tabela <- pagina |>
    html_elements(".principalStyle") |>
    html_text() |>
    as.data.frame() |>
    rename("fala" = 1) |>
    mutate(autor = str_squish(str_extract(fala, "[OA] SRA?. [A-Z áéíóúàèìòùãõâêîôûÁÉÍÓÚÀÈÌÒÙÃÕÂÊÎÔÛ.]*"))) |>
    mutate(comentario = paste(
      str_extract_all(fala, "\\([A-Za-z0-9/áéãõêÃÕÉÁ \\.\\-]*\\)")
    )) |>
    slice(-1) |>
    mutate(
      autor = ifelse(autor == "character(0)", NA, autor),
      comentario = ifelse(comentario == "character(0)", NA, comentario)
    ) |>
    fill(autor, .direction = "down") |>
    fill(comentario, .direction = "down") |>
    mutate(
      fala = str_remove_all(fala, pattern = autor),
      fala = str_remove_all(fala, pattern = comentario),
      fala = str_remove_all(fala, pattern = "\\(|\\)"),
      fala = str_squish(fala),
      autor = str_to_title(str_remove_all(autor, "[OA] SRA?.")),
      comentario = str_remove_all(comentario, pattern = "\\(|\\)"),
      sessao_id = id,
      data = dmy(sessao[1]),
      sessao = str_remove_all(sessao[2], "ª"),
      link
    ) |>
    select(sessao_id, data, sessao, autor, comentario, fala, link) |>
    rio::export(paste0("meeting_03/notas/",
      str_remove_all(sessao[2], "ª"),
      "_",
      dmy(sessao[1]),
      "-CPI_Pandemia.",
      extensao
    ))
}

# Vejamos se funciona
baixaNotas(ids[7], "xlsx")

# Baixando tudo com um FOR
for(id in ids){baixaNotas(id, "xlsx")}

# E se fosse um map?
# Explicação do map
map(ids, baixaNotas, "csv")

notas <- list.files(".", pattern = ".csv", full.names = T)

vroom::vroom(notas) |> 
  export("meeting_03/Todas_as_notas.xlsx")
