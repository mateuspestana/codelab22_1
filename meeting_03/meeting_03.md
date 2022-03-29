# Meeting 03 - Raspagem com o rvest
## Instrutores: Luana Calzavara e Matheus Pestana

## 1. Raspagem de dados

Raspagem de dados ou *web scrapping* significa acessar dados que estão disponíveis online, porém, que não são acessíveis de forma simplificada por meio de um download. São informações que podemos visualizar, mas que requerem uma forma mais direta de se obter. Nesse sentido, estamos extraindo, raspando dados.

Por exemplo, suponha que desejamos acompanhar a discussão política no Twitter durante o horário debate ao vivo em uma emissora de TV. Para isso, basta acessar a plataforma nesse horário e buscar por palavras chaves específicas, como "#DebateNaGlobo". Contudo, por mais que o pesquisador consiga visualizar todos os tweets, é mais interessante que esse reuní-los para uma análise mais atenta e criteriosa. Para isso, ele precisa extraí-los de alguma forma. Assim, diversos tipos de análise podem ser feitas e o pesquisador pode voltar neles quando desejar. 

Para isto fazemos a raspagem!
Outro exemplo bem comum são tabelas disponíveis online, mas que não possuem uma versão para download, como as presentes em páginas da Wikipedia.

#### O que precisamos saber para fazer a raspagem

Antes de trabalharmos com os pacotes no R, precisamos conhecer o conteúdo e a página  que queremos raspar. 


##### Conhecer a página e acessar seu código fonte
Uma vez definido o seu objeto de pesquisa, e encontrando a página a partir da qual obteremos os dados, precisamos apontar corretamente esse caminho a nossa função. Isso significa que precisamos acessar o *código fonte* da página de interesse. 
Boa parte dos sites disponíveis estão em `html`. Clicando com o botão direito na página, podemos acessar o seu código fonte e obter o caminho exato da região do site que é de nosso interesse.


##### Acessando uma página pelo R
Os pacotes mais utilizados para a raspagem em R são:
`httr `
`xml2`
`rvest`

Trabalharemos com o `rvest`


#### API - Aplication Programming Interface (Interface de programação de aplicações)

A quantidade e qualidade de dados online fez crescer o interesse desse informação para pesquisadores e para as próprias empresas que os produzem. Tudo o que é publicado por usuários em páginas como Youtube, Twitter e outras novas mídias sociais é passível de análise. Porém há uma fronteira legal ainda nebulosa sobre a viabilidade desses dados. Grandes empresas como o Facebook, hoje Meta, temem que tamanha raspagem possa atrapalhar seu desenvolvimento, por questões coorporativas. Nesse sentido, a própria indústria digital encontrou uma solução de maior segurança para ela: acesso aos seus dados por meio da sua API.
APIs são desenvolvidos originalmente para facilitar a troca de informações entre diferentes domínios da internet, integração com diferentes sites e aplicativos. Hoje em dia, essas interfaces também auxiliam o usuário a obter dados de determinada página, disponibilizada por ela própria em seu API.

##### Como uma API funciona?

Para acessar uma API é necessário requerer uma chave, que pode ser um token ou uma credencial. Cada API terá seu próprio sistema. A chave identifica o usuário, qual tipo de permissão ele tem para acesso e por quanto tempo.
Exemplos de pacotes do R para acessar API
 - rtweet: https://github.com/ropensci/rtweet
 - spotifyR: https://www.rcharlie.com/spotifyr/
 - tuber: https://cran.r-project.org/web/packages/tuber/vignettes/tuber-ex.html


### Noções básicas do rvest (olhar documentação!)

## 2. Baixando dados do Wikipedia e outras tabelas simples

## 3. Caso real: CPI da Pandemia no Senado



##### Referências

[Summer Institue of Computational Social Science](https://www.youtube.com/playlist?list=PL9UNgBC7ODr4M1_4RLr4IYcXbHPUWYMrZ)

[Texto como Dado para Ciências Sociais - Davi Moreira](https://bookdown.org/davi_moreira/txt4cs/)

