# R e Tidyverse - Data Transformation
## Manipulando bases no R
## Autores: Luana Calzavara e Matheus Pestana


# Carregando os pacotes
library(tidyverse)
library(rio)
library(janitor)
library

# ou...
pacman::p_load(tidyverse, rio, janitor)

# Abrindo a base

voto_rj_20 <- import("meeting_02/bases/votacao_candidato_munzona_2020_RJ.csv", 
                     encoding = "Latin-1")


# Olhando a base

glimpse(voto_rj_20)
summary(voto_rj_20)

# O Pipe %>% ou |> 

## O pipe coloca o comando anterior na primeira posição do comando seguinte. 
## Geralmente, a primeira linha é o banco/dataframe, e o resto, processamentos
## que faremos com ele.
 
## banco |> 
##  comando1()
##  comando2() |>
##  comando3() |> 
##  comando4()

# Isso é o mesmo que digitar: 
# comando4(comando3(comando2(comando1(banco))))

# Claramente, a opção do pipe torna tudo muito mais legível.

# Na teoria, tanto faz %>% ou |>, mas é sempre preferível usar o |> 


# Select

# E se quiséssemos remover algumas variáveis, ou selecionar algumas variáveis do banco?

voto_rj_20 |> 
  select(-DT_GERACAO, -HH_GERACAO, -starts_with("CD"))

voto_select <- voto_rj_20 |> 
  select(NM_URNA_CANDIDATO, SG_PARTIDO, DS_CARGO, NM_UE, DS_SIT_TOT_TURNO, QT_VOTOS_NOMINAIS)

# Filter

## E se quiséssemos filtrar só os casos de candidatos à prefeitura?

voto_select |> 
  filter(DS_CARGO == "Prefeito")

## E os candidatos à prefeitura da cidade do Rio de Janeiro? Juntando com o select pra pegarmos a zona?

prefs_rio <- voto_rj_20 |> 
  filter(DS_CARGO == "Prefeito" & NM_UE == "RIO DE JANEIRO") |> 
  select(NM_URNA_CANDIDATO, SG_PARTIDO, DS_SIT_TOT_TURNO, QT_VOTOS_NOMINAIS, NR_ZONA)

# Group By

prefs_rio |> 
  group_by(NM_URNA_CANDIDATO, SG_PARTIDO, DS_SIT_TOT_TURNO) |> 
  summarise(TOTAL_VOTOS_TURNO = sum(QT_VOTOS_NOMINAIS))

#### EXPLICAR O SUMMARISE

# Arrange

# Reordenando a tabela:

prefs_rio_grouped <- prefs_rio |> 
  group_by(NM_URNA_CANDIDATO, SG_PARTIDO, DS_SIT_TOT_TURNO) |> 
  summarise(TOTAL_VOTOS_TURNO = sum(QT_VOTOS_NOMINAIS)) |> 
  arrange(-TOTAL_VOTOS_TURNO)

# Mutate

prefs_rio_mutate <- prefs_rio_grouped |> 
  mutate(VOTOS_x10 = TOTAL_VOTOS_TURNO * 10,
         NM_URNA_CANDIDATO = str_to_title(NM_URNA_CANDIDATO),
         ELEITO_DUMMY = ifelse(DS_SIT_TOT_TURNO == "ELEITO" , 1, 0),
         IDEOLOGIA = case_when(SG_PARTIDO %in% c("PDT", "PT", "PSOL", "PSTU") ~ "Esquerda",
                               SG_PARTIDO %in% c("MDB", "REDE", "PMB") ~ "Centro",
                               TRUE ~ "Direita")) |> 
  filter(DS_SIT_TOT_TURNO != "2º TURNO")

# Contando com COUNT

voto_rj_20 |> 
  filter(DS_CARGO == "Vereador") |> 
  count(SG_PARTIDO) |> 
  arrange(-n)

voto_rj_20 |> 
  filter(DS_CARGO == "Vereador") |> 
  count(NM_UE, SG_PARTIDO) |> 
  arrange(NM_UE, -n)

# O count nada mais é que um atalho para...

voto_rj_20 |> 
  filter(DS_CARGO == "Vereador") |> 
  group_by(NM_UE, SG_PARTIDO) |> 
  summarise(n = n()) |> 
  arrange(NM_UE, -n)


