# Data Input e Output
## Abrindo bases e arquivos no R
## Autores: Luana Calzavara e Matheus Pestana

# Existem inúmeras formas de abrir uma base no R. 
# Uma base significa um dataframe quadrangular com um determinado número de colunas (variáveis)
# e linhas (casos).

# Dataframes podem ser abertos em CSV, XLSX, XLS, TSV, TXT, dentre outros. O R tem muitas funções para isso.

### Abrindo um arquivo CSV separado por ; 

cand_rj <- read_csv2("meeting_02/bases/votacao_candidato_munzona_2020_RJ.csv")

### Abrindo um CSV separado por , 

pisa <- read_csv("meeting_02/bases/pisa.csv")

### Abrindo um Excel

install.packages("readxl")
library(readxl)
gender_gap <- read_xlsx("meeting_02/bases/gender_gap.xlsx")

### Baixando um arquivo e abrindo como base

gapminder_pop <- read_csv("https://media.githubusercontent.com/media/m-clark/noiris/master/data-raw/gapminder/population_total.csv")

### Abrindo arquivos pesados rapidamente:

install.packages("vroom")
library(vroom)
movielens <- vroom("https://media.githubusercontent.com/media/m-clark/noiris/master/data-raw/gapminder/population_total.csv")

### Abrindo arquivo de qualquer formato sem lembrar a função
install.packages("rio")
library(rio)
movie2 <- import("meeting_02/bases/movielens.fst")