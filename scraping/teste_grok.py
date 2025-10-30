import requests
import json
import time

# URL da API interna (server-side DataTables)
API_URL = "https://dfe-portal.svrs.rs.gov.br/CFF/api/ClassificacaoTributaria"

# Headers para simular navegador (evita bloqueios)
HEADERS = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
    'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
    'Accept': 'application/json, text/javascript, */*; q=0.01',
    'X-Requested-With': 'XMLHttpRequest'
}

def build_datatables_payload(draw, start, length):
    """Constrói o payload exato esperado pelo DataTables server-side"""
    columns = [
        {"data": "classificacaoTributaria", "name": "", "searchable": True, "orderable": True},
        {"data": "descricao", "name": "", "searchable": True, "orderable": True},
        {"data": "noAnexo", "name": "", "searchable": True, "orderable": True},
        {"data": "grupo", "name": "", "searchable": True, "orderable": True},
        {"data": "subgrupo", "name": "", "searchable": True, "orderable": True},
        {"data": "cst", "name": "", "searchable": True, "orderable": True}
    ]
    
    payload = {
        'draw': str(draw),
        'start': str(start),
        'length': str(length),
        'search[value]': '',
        'search[regex]': 'false',
        'order[0][column]': '0',
        'order[0][dir]': 'asc'
    }
    
    # Adiciona colunas no formato DataTables
    for i, col in enumerate(columns):
        payload[f'columns[{i}][data]'] = col['data']
        payload[f'columns[{i}][name]'] = col['name']
        payload[f'columns[{i}][searchable]'] = str(col['searchable']).lower()
        payload[f'columns[{i}][orderable]'] = str(col['orderable']).lower()
        payload[f'columns[{i}][search][value]'] = ''
        payload[f'columns[{i}][search][regex]'] = 'false'
    
    return payload

# Coleta TODOS os dados
all_classificacoes = []
draw_counter = 1
start = 0
page_size = 500  # Tamanho do lote (máx. eficiente)

print("🔄 Buscando dados da API...")

while True:
    payload = build_datatables_payload(draw_counter, start, page_size)
    
    try:
        response = requests.get(API_URL, data=payload, headers=HEADERS, timeout=10)
        response.raise_for_status()
        data = response.json()
        
        records = data.get('data', [])
        total_records = int(data.get('recordsTotal', 0))
        
        all_classificacoes.extend(records)
        
        print(f"📄 Página {draw_counter}: {len(records)} registros (total: {total_records})")
        
        if start + page_size >= total_records:
            break
            
        start += page_size
        draw_counter += 1
        time.sleep(0.5)  # Pausa leve para não sobrecarregar o servidor
        
    except Exception as e:
        print(f"❌ Erro: {e}")
        break

print(f"✅ Total de classificações coletadas: {len(all_classificacoes)}")

# Formata para JSON focado em "classificações" e "Nº Anexo"
json_data = []
for row in all_classificacoes:
    json_data.append({
        "classificacao_tributaria": row.get("classificacaoTributaria", ""),
        "descricao": row.get("descricao", ""),
        "no_anexo": row.get("noAnexo", ""),  # Vazio se não tiver
        "grupo": row.get("grupo", ""),
        "subgrupo": row.get("subgrupo", ""),
        "cst": row.get("cst", "")
    })

# Salva em arquivo JSON
output_file = "classificacoes_tributarias_anexos.json"
with open(output_file, 'w', encoding='utf-8') as f:
    json.dump(json_data, f, ensure_ascii=False, indent=2)

print(f"💾 Arquivo salvo: {output_file}")
print("📊 Exemplo das primeiras 3 linhas:")
for item in json_data[:3]:
    print(f"  - {item['classificacao_tributaria']}: Anexo '{item['no_anexo']}'")