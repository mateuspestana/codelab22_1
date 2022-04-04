# Scraper do Brasil Paralelo
# Autor: Matheus Pestana (matheus.pestana@iesp.uerj.br)

from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from webdriver_manager.chrome import ChromeDriverManager
from bs4 import BeautifulSoup
import pandas as pd
import time


# Declarando as URLs e pesquisas
url = 'https://www.brasilparalelo.com.br'
query = 'comunismo'

# Setando o webdriver
s = Service(ChromeDriverManager().install())
driver = webdriver.Chrome(service = s)

# Abre o site
driver.get(url)

time.sleep(2)

# Clica na lupa
lupa = driver.find_element(By.ID, 'search-icon')
lupa.click()

# Clica na caixa de busca
busca = driver.find_element(By.ID, 'search')
busca.send_keys(query)
busca.send_keys(Keys.RETURN)

# Cria uma instância do BeautifulSoup
soup = BeautifulSoup(driver.page_source, 'lxml')

# Busca o 'div' que estão na classe w-container
posts = soup.find('div', {'class':'w-container'})

# Dentro desse 'div', ou seja, um box, busca todos os links
posts_links = posts.find_all('a')

lista_links = []

for links in posts_links:
    postagem = url+links.get('href')
    lista_links.append(postagem)

lista_links = [i for i in lista_links if 'episodios-series' not in i]
lista_links = [i for i in lista_links if 'ebooks' not in i]


# Salva a lista de posts e links em um .csv na pasta
df = pd.DataFrame(lista_links).to_csv('links.csv')

# Vamos continuar processando a lista!
# Agora temos uma lista em que cada item pode ser iterado. Vamos ver como
# podemos raspar o primeiro item.

driver.get(lista_links[0])
soup = BeautifulSoup(driver.page_source, 'lxml')

#titulo = soup.title.get_text()
#materia = soup.find('div', {'id' : 'content-div'}).get_text()
#link = lista_links[0]

#entrada = [titulo, link, materia]

materias_bp = []

for url in lista_links:
    print("Baixando página", url)
    driver.get(url)
    soup = BeautifulSoup(driver.page_source, 'lxml')
    titulo = soup.title.get_text()
    materia = soup.find('div', {'id' : 'content-div'}).get_text()
    link = url
    entrada = [titulo, link, materia]
    materias_bp.append(entrada)
    time.sleep(1)

print("Convertendo em dataframe...")
df = pd.DataFrame(materias_bp, columns = ["Título", "Link", "Matéria"])

print("Salvando em .csv")
df.to_csv("materias_bp.csv")

print("Tudo certo!")

time.sleep(1)
driver.quit()
