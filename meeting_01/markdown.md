# Markdown 

Markdown é uma linguagem de marcação de texto, na qual a formatação se resume a caracteres especiais. Geralmente com a extensão `.md`, o Markdown renderiza automaticamente, na web, em um arquivo `.html`, aparentando uma página de navegação. Esse documento e o anterior (`github.md`) foram criados em Markdown. 

Ao invés de usarmos tags HTML, como <b> para negrito, ou <p> para parágrafo, usamos ** ou apenas damos um enter para marcação do início de um novo parágrafo. 

Isso facilita a leitura, uma vez que não são mais tags ou códigos que definem a formatação do texto, mas sim caracteres que fazem algum sentido lógico. Por exemplo:

```
# Isso é um título

## Formatação (subtítulo)

### Negrito (subsubtítulo)
**Isso é um texto em negrito**

### Itálico (subsubtítulo)
*Isso estaria em itálico*

#### Link (subsubsubtítulo)

[Google!](google.com)
```

O texto acima, em Markdown, renderiza da seguinte maneira: 

---

# Isso é um título

## Formatação (subtítulo)

### Negrito (subsubtítulo)
**Isso é um texto em negrito**

### Itálico (subsubtítulo)
*Isso estaria em itálico*

#### Link (subsubsubtítulo)

[Google!](google.com)

---

# R + Markdown 

O R pode editar arquivos Markdown (aliás, qualquer arquivo que seja de texto cru), mas ele possui algo diferente: o RMarkdown, que é uma fusão da linguagem R com o poder de formatação do Markdown.

Para isso, é imprescindível instalar o pacote `rmarkdown`. Vocês sabem como instalamos pacotes?

A vantagem de usar o `rmarkdown` é que podemos gerar relatórios, pesquisas, artigos e até mesmo teses ou dissertações com códigos gerados pelo R. É como se criássemos um texto que dissesse: 

"O gráfico a seguir apresenta o padrão de votação dos partidos"

Ao invés de gerarmos a imagem no R, colarmos no Word/Pages/LibreOffice, basta usarmos o código do R que ele gerará o relatório renderizando o gráfico, gerando um pdf/Word/HTML ao final. O código, dentro do R, seria algo próximo de:

```
base_votacao |> 
  ggplot(aes(x = eixo_x, y = eixo_y, color = partido))+
  geom_point()+
  labs(title = "Padrão de Votação - Partidos")
```

O R leria o código acima e transformaria em um gráfico.

### Qual a vantagem do RMarkdown?

A vantagem é que, além de facilitar a formatação do texto, sem que precisemos nos preocupar com alinhamento, tamanho de fonte, etc, e gerando também um formato universal, como o PDF ou o HTML (lembrando que o Word pode ter problemas de versão e compatibilidade), ele favorece a Ciência Aberta (_OpenScience_), ao garantir que qualquer pessoa que rode aquele relatório obtenha os mesmos dados, garantindo a segurança dos achados e disponibilizando também todo o processo do "fazer ciência" de forma aberta, livre e universal. 

## Para saber mais

[Como usar o Markdown? - Adobe](https://experienceleague.adobe.com/docs/contributor/contributor-guide/writing-essentials/markdown.html?lang=pt-BR)

[R Markdown - The Definitive Guide](https://bookdown.org/yihui/rmarkdown/)