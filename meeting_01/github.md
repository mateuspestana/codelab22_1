# Github

### Autores: Matheus C. Pestana & Luana Calzavara
### Data: 16/03


## O que é?

## Por que usar? 

## Como usar? 

## Instalando

## Baixando um repositório já criado

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




## Subindo um repositório e salvando as modificações