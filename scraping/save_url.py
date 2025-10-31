import requests
from bs4 import BeautifulSoup
import pandas as pd
import json

# URL da página com a tabela
url = "https://dfe-portal.svrs.rs.gov.br/CFF/ClassificacaoTributaria"

# Faz a requisição HTTP para a página
response = requests.get(url)

# Verifica se a requisição foi bem-sucedida
if response.status_code == 200:
    # Parseia o conteúdo HTML da página
    soup = BeautifulSoup(response.content, 'html.parser')

    # Encontra a tabela na página (ajuste o seletor conforme necessário)
    src = soup.find_all('script', {'src': ''})
    # print(src)

    # Salva o JSON em um arquivo
    with open('src.html', 'w', encoding='utf-8') as f:
        f.write(src[1].text)

    print("Dados salvos em 'src.html'")
else:
    print(f"Erro ao acessar a página: {response.status_code}")