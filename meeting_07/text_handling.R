# Meeting 07 - Tratamento de textos
# Instrutores: Luana Calzavara e Matheus Pestana
# Data: 26/04/2022

pacman::p_load(tidyverse,
               tidytext,
               quanteda,
               rio,
               janitor,
               gutenbergr,
               stopwords,
               textdata,
               lexiconPT,
               quanteda.textstats,
               quanteda.textmodels,
               quanteda.textplots,
               stm)

remotes::install_github("sillasgonzaga/lexiconPT")

# Conceitos básicos - D. Casmurro ------------------------------------------------------------

casmurro <- gutenberg_download(55752, strip = T) |>
  mutate(text = iconv(text, to = "UTF-8"))

# Removendo os NA e as linhas em branco
casmurro_2 <- casmurro |>
  drop_na() |>
  filter(str_detect(text, "\\S")) |>
  select(-gutenberg_id)

# Tidytext: transformando em tidy
casmurro_3 <- casmurro_2 |>
  unnest_tokens(word, text)

# Frequência de palavras
casmurro_3 |>
  count(word) |>
  arrange(-n)

# Stopwords
stops <- stopwords("pt", simplify = T) |> 
  as.data.frame() |> 
  rename("word" = 1)

# Contando novamente as palavras
casmurro_4 <- casmurro_3 |>
  anti_join(stops)

casmurro_4 |> 
  count(word, sort = T) |> 
  slice_max(n = 20, order_by = n) |> 
  ggplot(aes(x = reorder(word, n), y = n, label = n))+
  geom_col()+
  geom_label()+
  coord_flip()+
  hrbrthemes::theme_ipsum_tw()

# Análise de sentimento
casmurro_5 <- casmurro_4 |> 
  left_join(lexiconPT::oplexicon_v3.0, by = c("word" = "term"))

casmurro_5 |> 
  drop_na() |> 
  count(polarity)


# Notas Taquigráficas ---------------------------------------------------------------

notas <- vroom::vroom(list.files("meeting_03/notas/", pattern = "*.csv", full.names = T))

corpus <- corpus(notas, text_field = "fala")

summary(corpus)

notas_tokens <- corpus |> 
  tokens(remove_punct = T, 
         remove_symbols = T,
         remove_numbers = T, 
         remove_url = T,
         remove_separators = T) |> 
  tokens_remove(stopwords(language = "pt"))

notas_dfm <- notas_tokens |> 
  dfm()

# Frequência
textstat_frequency(notas_dfm)

# Encontramos novas palavras que são stopwords.
stops2 <- c(stopwords(language = "pt"), 
            "é", "aqui", "sr", "senhor", "v", "exa", "ai", "ter", "ser", "vou", "vai", "agora", "pra", "sa", "lá",
            "quero", "vamos", "acho", "disse", "ainda", "falar", "assim", "fez", "sei", "fez", "dessa", "sabe", 
            "todas", "todos", "dr", "sendo", "falou", "desse", "quer", "dar", "vez", "faz", "onde", "saber",
            "diz", "r", "ver", "dra", "nesta", "neste", "mim", "desde", "quanto", "havia", "sido", "nessa", "feito",
            "sempre", "disso", "dois", "alguns", "algum", "dra", "deve", "peço", "pedir", "ali", "olha", "pois", "toda",
            "responder", "têm", "outro", "desta", "nada", "alguma", "outros", "nenhum", "nesse", "tudo", "dizer", 
            "aí", "então")
notas_tokens <- corpus |> 
  tokens(remove_punct = T, 
         remove_symbols = T,
         remove_numbers = T, 
         remove_url = T,
         remove_separators = T) |> 
  tokens_remove(stops2)

notas_dfm <- notas_tokens |> 
  dfm()

textstat_frequency(notas_dfm)

textplot_wordcloud(notas_dfm)

# Topic Model

notas_stm <- quanteda::convert(notas_dfm |> 
                                 dfm_subset(sessao <= 10),
                               to = "stm")

bestK <- searchK(notas_stm$documents, 
                 notas_stm$vocab, 
                 K = 5:10)

plot(bestK)

mod7 <- stm(notas_stm$documents, notas_stm$vocab, K = 7, init.type = "Spectral")

plot(mod7, type = "labels")
plot(mod7, type = "summary")
plot(mod7, type = "perspectives", topics = c(1, 7))
plot(mod7, type = "perspectives", topics = c(1, 2))

labelTopics(mod7, n = 10)

# Brasil Paralelo -------------------------------------------------------------------

brapar <- import("meeting_04/brasil_paralelo/materias_bp.csv") |> 
  corpus(text_field)
