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
    table = soup.find('table')
    print(table)
    tbody = soup.find('tbody', {'id': 'tab-pai-body'})  # Substitua 'classificacaoTable' pelo ID correto da tabela
    print(len(table.find_all('tr')))

    # Extrai os dados da tabela
    data = []
    for row in table.find_all('tr')[1:]:  # Ignora o cabeçalho da tabela
        cols = row.find_all('td')
        anexo = cols[3].text.strip() if len(cols) > 3 else None  # Ajuste o índice conforme necessário
        data.append({'Anexo': anexo})

    # Converte os dados para um DataFrame do pandas
    df = pd.DataFrame(data)

    # Converte o DataFrame para um arquivo JSON
    json_data = df.to_json(orient='records', force_ascii=False)

    # Salva o JSON em um arquivo
    with open('anexos.json', 'w', encoding='utf-8') as f:
        f.write(json_data)

    print("Dados salvos em 'anexos.json'")
else:
    print(f"Erro ao acessar a página: {response.status_code}")