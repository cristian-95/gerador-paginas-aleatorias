import os
import networkx as nx
from bs4 import BeautifulSoup

# Diretório onde os sites foram criados
site_dir = "sites"

# Inicialize um grafo direcionado
G = nx.DiGraph()

# Função para extrair links de um arquivo HTML
def extract_links(file_path):
    with open(file_path, 'r', encoding='utf-8') as file:
        soup = BeautifulSoup(file, 'html.parser')
        links = []
        for link in soup.find_all('a'):
            href = link.get('href')
            if href:
                links.append(href)
        return links

# Escaneie os sites e crie o grafo
for site_file in os.listdir(site_dir):
    site_path = os.path.join(site_dir, site_file)
    if os.path.isfile(site_path) and site_path.endswith('.html'):
        site_name = os.path.splitext(site_file)[0]
        site_links = extract_links(site_path)

        # Adicione o site atual ao grafo
        G.add_node(site_name)

        for link in site_links:
            if link.endswith('.html') and link in os.listdir(site_dir):
                link_name = os.path.splitext(link)[0]
                G.add_edge(site_name, link_name)

# Gere um arquivo DOT representando o grafo
dot_file = "site_relations.dot"
nx.drawing.nx_pydot.write_dot(G, dot_file)

print(f"Arquivo DOT gerado em {dot_file}")
