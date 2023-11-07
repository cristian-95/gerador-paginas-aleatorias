import pydot
import numpy as np

# Leitura do arquivo .dot
dot_file = 'site_relations.dot'

# Leitura do grafo a partir do arquivo .dot
graph = pydot.graph_from_dot_file(dot_file)
edges = graph[0].get_edge_list()

# Obtém todos os nós únicos do grafo
nodes = list(set([e.get_source() for e in edges] + [e.get_destination() for e in edges]))
nodes.sort()  # Ordena os nós em ordem alfabética

# Cria um dicionário para mapear nomes de nós para índices
node_to_index = {node: i for i, node in enumerate(nodes)}

# Inicializa a matriz de adjacência com zeros
num_nodes = len(nodes)
adjacency_matrix = np.zeros((num_nodes, num_nodes), dtype=int)

# Preenche a matriz de adjacência
for edge in edges:
    src = edge.get_source()
    dest = edge.get_destination()
    src_index = node_to_index[src]
    dest_index = node_to_index[dest]
    adjacency_matrix[src_index][dest_index] = 1

# Exibe a matriz de adjacência
print(adjacency_matrix)

