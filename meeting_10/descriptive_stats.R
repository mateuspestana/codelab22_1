##=============================================================
##               Descriptive Statistics
##============================================================= 

options(scipen = 999)
options(mc.cores = parallel::detectCores())


## Packages =======================================

# install.packages("pacman")

pacman::p_load(tidyverse, janitor, survival, hrbrthemes, 
               sjPlot, sjmisc, gridExtra, ggcorrplot, ggalt, 
               ggfortify, broom, ggcorrplot, vroom, fst,rio,
               survminer ,simPH, stargazer, scales, coxed)

## Open dataset ===================================

base_sobrevivencia <- import("base_sobrevivencia_dados_nova.csv")

## Data Wrangling =================================

base_desc <- base_sobrevivencia %>% 
  filter(nivel_funcao %in% c("DAS-1", "DAS-2", "DAS-3", "DAS-4",
                             "DAS-5", "DAS-6"))  %>% 
  mutate(por_df = ifelse(uf_organizacao == "DF", "DF", "Outros")) %>% 
  mutate(filiado = ifelse(filiado == 1, "Sim", "Nao"))    %>% 
  mutate(DAS5e6 = ifelse(nivel_funcao %in% c("DAS-5", "DAS-6"), 1, 0))

## Descriptive Analysis ============================

quartz()
windows()

# Survival Curve ===================================

sobrevivencia <- survfit(Surv(tempo_sobre, censor) ~ 1,
                         conf.type = "log-log", 
                         data = base_desc)

g1_sobre <- autoplot(sobrevivencia, censor.shape = "", conf.int = T) + 
  labs(x="", y = "", 
       caption = "*Tempo de sobrevivência em meses.") +
  theme_bw()

# export::graph2pdf(x = g1_sobre, file="graf_curv_sobre.pdf",font = "Times New Roman",
#           height = 4, width = 6)

# Per level =======================================

teste_das <- survfit(Surv(tempo_sobre, censor) ~ DAS5e6, 
                     base_desc)
print(teste_das)

# Partisans ======================================

teste_fil <- survfit(Surv(tempo_sobre, censor) ~ parl_base, 
                     base_desc)

# Public Service ================================

teste_fora <- survfit(Surv(tempo_sobre, censor) ~ fora_serv_pub, 
                      base_desc)

# Federal District ==============================

teste_df <- survfit(Surv(tempo_sobre, censor) ~ por_df,
                    base_desc)


# Combine all plots =============================

splots <- list()

splots[[1]] <- ggsurvplot(teste_das,
                          data = base_desc,
                          conf.int = T,
                          ggtheme = theme_bw(),
                          legend.labs = c("DAS-1 a 4   ", "DAS-5 a 6"),
                          legend.title = "",
                          legend = "bottom",
                          palette = c("black", "red"),
                          surv.scale="percent",
                          title = "Nível da Função",
                          xlab = "",
                          ylab = "",
                          censor.shape = "")

splots[[2]] <- ggsurvplot(teste_fil,
                          data = base_desc,
                          conf.int = T,
                          ggtheme = theme_bw(),
                          legend.title = "",
                          legend = "bottom",
                          legend.labs = c("Filiados  ", "Não Filiados"),
                          palette = c("red", "black"),
                          censor.shape = "", 
                          title = "Filiação",
                          xlab = "",
                          ylab = "",
                          surv.scale = "percent")

splots[[3]] <- ggsurvplot(teste_fora,
                          data = base_desc,
                          conf.int = T,
                          ggtheme = theme_bw(),
                          legend.labs = c("Concursados   ", "Não Concursados"),
                          legend.title = "",
                          legend = "bottom",
                          palette = c("black", "red"),
                          censor.shape = "", 
                          title = "Concursados",
                          xlab = "",
                          ylab = "",
                          surv.scale = "percent")

splots[[4]] <- ggsurvplot(teste_df,
                          data = base_desc,
                          conf.int = T,
                          ggtheme = theme_bw(),
                          legend.title = "",
                          legend = "bottom",
                          legend.labs = c("DF   ", "Outros"),
                          palette = c("red", "black"),
                          censor.shape = "", 
                          title = "Localidade",
                          xlab = "",
                          ylab = "",
                          surv.scale = "percent")

g2_desc <- arrange_ggsurvplots(splots, print= T, ncol = 2 ,nrow = 2)

# ggsave("graf_desc.pdf", g2_desc)
