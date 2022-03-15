# Github

### Autores: Matheus C. Pestana & Luana Calzavara
### Data: 16/03


## O que é?

Git/Github são plataformas que servem como repositório de arquivos de programação. O Git é um sistema offline de versionamento local, enquanto o Github é um sistema online, remoto, que armazena esses dados na internet. Além do Github, existem outras opções online como GitLab e o BitKeeper.

Nela, podemos criar e gerenciar projetos de softwares, pacotes, bibliotecas de funcionalidades, ou mesmo teses e dissertações (escritas em Markdown ou LaTeX). Com o controle de versão, sabemos cada mudança que fazemos, podendo retornar a ela posteriormente, entendendo o que mudou e em que ponto mudou. Também serve para armazenarmos gratuitamente esse código. 

O Git foi criado por Linus Torvalds, o mesmo criador do Linux, em 2005. 


## Por que usar? 

Existem muitas vantagens de se usar um sistema de versionamento offline/online: 

- marcar as alterações feitas
- ter controle de quando, quem, e o que foi realizado em cada alteração
- ter diversos ramos em um mesmo código, podendo criar novas funcionalidades sem afetar as originais
- disponibilizar isso na internet, de modo que outros desenvolvedores possam ver, corrigir seus códigos, enviar sugestões e identificar erros, aproveitando todas as benesses do _open source_. 
- permite trabalho em equipe, colaboração
- organização
- ter um portfólio onde se possar tornar público seus trabalhos

## Instalando

### Linux

No Linux, a maioria das distribuições já vem com o git instalado, dada a importância do software. Mas caso não esteja, basta abrir o gerenciador de pacotes (como o `dnf` ou o `apt`) e instalar por lá.

`sudo apt install git-all` 

ou 

`sudo dnf install git-all

E assim, toda a suite do git será instalada. 

### MacOS

No caso dos sistemas da Apple, basta utilizar o gerenciador de pacotes `brew`, em `brew install git` ou instalar os `Developer Tools`. Para isso, basta digitar `git` no prompt de comando que o sistema sugerirá sua instalação, caso não esteja instalado.

### Windows

Para instalar o Git no Windows, basta baixar a versão do site https://gitforwindows.org

Todas os comandos serão universais, devendo ser executados nos terminais/prompt de comando do sistema. 


## Baixando/Clonando um repositório já criado

Para baixar um repositório do Github e torná-lo disponível localmente, basta utilizar a sua URL, abrir o prompt de comando, direcionando para a pasta desejada, e digitar:

`git clone https://github.com/mateuspestana/codelab22_1`

Todos os arquivos criados (incluindo suas modificações anteriores) serão baixados e armazenados na pasta escolhida, cujo nome será o mesmo do repositório (no caso acima, codelab22_1). 

## Criando um repositório

Um repositório pode ser criado da seguinte maneira (utilizando como exemplo o repositório do __CodeLab__: 

```
1 | echo "# codelab22_1" >> README.md
2 | git init
3 | git add README.md
4 | git commit -m "first commit"
5 | git branch -M main
6 | git remote add origin https://github.com/mateuspestana/codelab22_1.git
7 | git push -u origin main
```

A linha `1` na realidade não cria um repositório. Na verdade, ela cria um arquivo. Ela utiliza o comando `echo`, presente em plataformas como Linux e Mac. Esse comando exibe uma mensagem na tela, é uma mera reprodução de texto. No R, seria o equivalente ao comando `print()`. O que estamos fazendo aqui, na verdade, é direcionando essa mensagem para dentro de um arquivo, que ainda não existe, chamado `README.md`. 

Esse direcionamento para um arquivo se dá através do sinal `>>`. Comparando com o R, seria equivalente ao `<-`, que direciona tudo que está à direita para o que está à esquerda do sinal. No caso do comando digitado no terminal para a pasta do __git__, a direção é invertida. Mas é possível alterar o sinal (e por conseguinte, a direção de atribuição) em ambos os casos. 

A segunda linha diz para o diretório (pasta) que aquele diretório será do tipo `git`, ou seja, terá controle de versão. Atentem: é possível que tenhamos um diretório git no computador e nunca o colocarmos na Web. Isso é bastante comum em empresas, que tem seus servidores próprios, e desenvolvedores que querem apenas um controle do que produzem, sem "vazar" os seus códigos. De qualquer forma, é possível fazer com que um repositório no Github seja acessível apenas pelo dono e colaboradores. 

A terceira linha adiciona ao controle daquela versão o arquivo README.md, criado anteriormente. 

A quarta linha "fecha" aquela versão, afirmando que todas as alterações ali feitas tem um sentido, ou foram feitas em conjunto, ou dentro de um determinado contexto (incluir uma nova funcionalidade, por exemplo). A isso chamamos "commitar". Podemos adicionar (na verdade, DEVEMOS) um comentário para registrarmos de forma resumida o que foi alterado ali. É clássico que o primeiro commit seja registrado como "first commit".

A quinta linha direciona essa versão commitada para o ramo "main", ou seja, o ramo principal. Podemos ter vários *branches*, trabalhando em um código enquanto mantemos outro. Um exemplo: temos um pacote de R que funciona perfeitamente, ele é distribuído e usado por vários pesquisadores. Todavia, queremos incluir uma nova funcionalidade que é bastante complexa e exigirá semanas ou meses de trabalho. Se ficarmos commitando as mudanças diárias que fazemos no código, e novos usuários baixarem o pacote, ele não funcionará, pois a nova função afeta funções anteriores. O que fazemos? Criamos um novo branch que terá o código inteiro + a nova função, e trabalharemos nele, sempre commitando no branch certo. Alterações pontuais são feitas no __main__, em paralelo. Ao longo do tempo, com o término dos commits, podemos fazer um _merge_, ou seja, uma fusão dos dois branches em um só, e tudo funcionará (com sorte) como esperado.

Na sexta linha, criamos uma relação entre o nosso diretório git e o nosso repositório online no Github (ou gitlab ou outras plataformas). Definimos o nosso como local e o remoto é o online.

Na sétima linha, enviamos todas as nossas alterações para o nosso repositório remoto. 


## Subindo um repositório e salvando as modificações

Para subir as modificações em arquivos de um diretório git, basta reutilizar parte dos comandos anteriores, com uma singela diferença:

```
1 | git add arquivos_novos.R
2 | git commit -m "Adiciona novos arquivos ao diretório"
3 | git push
```

Se tivermos alterado muitos arquivos e quisermos adicioná-los todos de uma vez, trocamos a linha 1 acima para

```
git add .
```

E todos os arquivos que foram alterados são registrados para um novo commit. 

## Baixando as alterações remotas

E se tivermos baixado um pacote, e o criador dele posteriormente fez alterações? Como pegamos novamente essas alterações?

Basta digitar, pelo prompt de comando, no diretório da pasta, o seguinte:

`git pull` 

E tudo estará atualizado. Se você quiser saber se há alguma modificação disponível, tanto local quanto remota, basta digitar:

`git status`. 

## Termos e funcionalidades do Git

*Clornar Repositório*
Baixar um repositório público para a sua própria máquina e fazer um git local. Permite que você tenha acesso ao código baixado e realiza alterações. Como se estivéssemo realizando o download de todo repositório. Para clonar um repositório, basta entrar no repositório de interese, clicar na caixa verde "Code", e obter a linha de códio ou link para baixá-lo.

*Commit*
Criação de uma sub-versão dentro do repositório local, da sua própria máquina.

*Push*
Levar o commit novo ao repositório remoto, ao próprio gitHub.

*Fork*
Clonar para dentro de um repositório remoto, dentro do próprio github.

*Issues*
Questões indentificadas por algum usuário do Github dentro de um repositório público. Esta pessoa pode comentar, dentro da aba de issues, sobre o código postado. Essa ferramenta permite interação entre programadores.

*Pullrequest*
O pullrequest é utilizado para baixar atualizações que tenham sido feitas no Github. Ele também é uma ferramenta prática de colaboração. Dado uma sugestão de alteração no código de terceiros, um usuário pode requerer um pullrequest que altere o código que estava sendo trabalhado. Se o programador do projeto original aceitar estas modificações, a pessoa que encaminhou as sugestões entra como colaboradora.

*Branches*
Branches são os ramos do versionamento. Ao criar um git, temos a branch master, ou ramo principal, a ser commitada. Caso o usuário deseje subdivir seu projeto, pode criar novos ramos dentro da principal. Ao final, uma operação de merge, fusão, uni os ramos secundários dentro do principal. Este processo ocorre dentro do repositório local.

## Para saber mais:

[Curso de Git da Beatriz Milz](https://beatrizmilz.github.io/slidesR/git_rstudio/09-2021-gyn.html#1)

[Instalando o Git no Windows](https://www.webdevdrops.com/git-no-windows-github/)

[Github - Tecnoblog](https://tecnoblog.net/responde/como-usar-o-github-guia-para-iniciantes/)

[Quickstart - Github](https://docs.github.com/pt/get-started/quickstart)

[Tutotrial Git e Github](https://butecotecnologico.com.br/tutorial-git-e-github/)
[Curso de Git e Github](https://www.youtube.com/playlist?list=PLHz_AreHm4dm7ZULPAmadvNhH6vk9oNZA)
