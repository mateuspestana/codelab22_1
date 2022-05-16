##=============================================================
##               Regression Analysis
##============================================================= 

options(scipen = 999)
options(mc.cores = parallel::detectCores())

## Open Packages =======================================

# install.packages("pacman")

pacman::p_load(tidyverse, janitor, survival, hrbrthemes, 
               sjPlot, sjmisc, gridExtra, ggcorrplot, ggalt, 
               ggfortify, broom, ggcorrplot, vroom, fst,
               survminer ,simPH, stargazer, scales, coxed, 
               rms, rio, flexsurv)

## load data ============================================

base_sobrevivencia <- import("base_sobrevivencia_dados.csv")

## data wrangling  ======================================

base_sobrevivencia <- base_sobrevivencia %>% 
  mutate(por_df = ifelse(uf_organizacao == "DF", 1, 0),
         DAS5e6 = ifelse(nivel_funcao %in% c("DAS-5", "DAS-6"), 1, 0)) %>% 
  select(tempo_sobre, censor, tempo_medio_min, 
         fora_serv_pub, parl_base, orgao_superior,
         sexo, escolaridade, por_df, DAS5e6, 
         nivel_funcao)  %>% 
  mutate(sexo = ifelse(sexo ==  "F", 1, 0),
         escolaridade = ifelse(escolaridade == "Superior", 1, 0), 
         fora_serv_pub = ifelse(fora_serv_pub == "1", 1,0),
         concursado = ifelse(fora_serv_pub == 0, 1, 0)) %>% 
  mutate(tempo_min_np = log(tempo_sobre)*tempo_medio_min,
         por_df_np = log(tempo_sobre)*por_df,
         fora_serv_pub_np = log(tempo_sobre)*fora_serv_pub,
         escolaridade_np = log(tempo_sobre)*escolaridade,
         parl_base_np = log(tempo_sobre)*parl_base)


sobre4 <- base_sobrevivencia %>% 
  filter(DAS5e6 ==0)

sobre5 <- base_sobrevivencia %>% 
  filter(DAS5e6 ==1)

sobre5$S5 <- Surv(sobre5$tempo_sobre, sobre5$censor)
sobre4$S4 <- Surv(sobre4$tempo_sobre, sobre4$censor)


## Regression Analysis ================================

f1 <- psm(S4 ~ log(tempo_medio_min) +
            parl_base + concursado+ por_df + 
            sexo + escolaridade +
            cluster(orgao_superior), 
          dist = "lognormal",
          sobre4)

f2 <- psm(S4 ~ log(tempo_medio_min) +
            parl_base + concursado+ por_df + 
            sexo + escolaridade +
            cluster(orgao_superior), 
          dist = "loglogistic",
          sobre4)


f3 <- psm(S5 ~ log(tempo_medio_min) +
            parl_base + concursado+ por_df + 
            sexo + escolaridade +
            cluster(orgao_superior), 
          dist = "lognormal",
          sobre5)

f4 <- psm(S5 ~ log(tempo_medio_min) +
            parl_base + concursado+ por_df + 
            sexo + escolaridade +
            cluster(orgao_superior), 
          dist = "loglogistic",
          sobre5)

stargazer(f1, f2, f3, f4, type = "text")
 
