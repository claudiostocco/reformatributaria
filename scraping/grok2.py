from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.chrome.options import Options
from bs4 import BeautifulSoup
import json
import time
import pandas as pd  # Opcional, para DataFrame limpo

# Configurações do Chrome (headless=True para rodar sem janela visível)
chrome_options = Options()
chrome_options.add_argument("--headless")  # Remova para ver o navegador
# chrome_options.add_argument("--no-sandbox")  # Útil em alguns ambientes
# chrome_options.add_argument("--disable-dev-shm-usage")

# Inicializa o driver (ajuste o path se necessário)
driver = webdriver.Chrome(options=chrome_options)  # Ou: webdriver.Chrome(executable_path='/path/to/chromedriver')

URL = "https://dfe-portal.svrs.rs.gov.br/CFF/ClassificacaoTributaria"

print("🔄 Abrindo o site...")

try:
    driver.get(URL)
    
    # Espera a tabela carregar (classe comum do DataTables)
    wait = WebDriverWait(driver, 10)
    table = wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, "table.dataTable")))
    
    print("📊 Carregando todas as páginas da tabela...")
    
    all_rows = []
    
    while True:
        # Espera a tabela atual renderizar
        time.sleep(2)  # Pausa para JS carregar
        
        # Parse da página atual com BeautifulSoup
        soup = BeautifulSoup(driver.page_source, 'html.parser')
        table_body = soup.find('tbody')
        
        if not table_body:
            break
        
        rows = table_body.find_all('tr')
        current_page_rows = []
        
        for row in rows:
            cells = row.find_all('td')
            if len(cells) >= 3:  # Garante colunas mínimas
                classificacao = cells[0].text.strip()
                descricao = cells[1].text.strip()
                no_anexo = cells[2].text.strip()  # Coluna "Nº Anexo"
                grupo = cells[3].text.strip() if len(cells) > 3 else ""
                subgrupo = cells[4].text.strip() if len(cells) > 4 else ""
                cst = cells[5].text.strip() if len(cells) > 5 else ""
                
                current_page_rows.append({
                    "classificacao_tributaria": classificacao,
                    "descricao": descricao,
                    "no_anexo": no_anexo,
                    "grupo": grupo,
                    "subgrupo": subgrupo,
                    "cst": cst
                })
        
        all_rows.extend(current_page_rows)
        print(f"   - Página atual: {len(current_page_rows)} registros (total até agora: {len(all_rows)})")
        
        # Tenta ir para a próxima página (botão "Next" do DataTables)
        try:
            next_button = driver.find_element(By.CSS_SELECTOR, "a.paginate_button.next:not(.disabled)")
            if 'disabled' in next_button.get_attribute('class'):
                break
            next_button.click()
        except:
            break  # Sem próxima página
    
    print(f"✅ Total de classificações coletadas: {len(all_rows)}")
    
    # Salva em JSON
    output_file = "classificacoes_tributarias_anexos.json"
    with open(output_file, 'w', encoding='utf-8') as f:
        json.dump(all_rows, f, ensure_ascii=False, indent=2)
    
    print(f"💾 Arquivo salvo: {output_file}")
    
    # Exemplo das primeiras 3 com anexos
    print("📊 Exemplo das primeiras 3 linhas com anexos:")
    for item in all_rows[:3]:
        anexo_info = f"Anexo '{item['no_anexo']}'" if item['no_anexo'] else "Sem anexo"
        print(f"  - {item['classificacao_tributaria']}: {anexo_info}")
    
    # Opcional: Salva em CSV para Excel
    df = pd.DataFrame(all_rows)
    df.to_csv("classificacoes_tributarias_anexos.csv", index=False, encoding='utf-8')
    print("💾 CSV também salvo para Excel: classificacoes_tributarias_anexos.csv")

except Exception as e:
    print(f"❌ Erro: {e}")
    print("Dica: Verifique se o ChromeDriver está no PATH e versão compatível.")

finally:
    driver.quit()  # Fecha o navegador