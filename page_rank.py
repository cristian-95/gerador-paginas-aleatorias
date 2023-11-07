import networkx as nx

# Função para ler o arquivo .dot e criar um grafo direcionado
def read_dot_file(file_name):
    G = nx.DiGraph()
    with open(file_name, 'r') as f:
        lines = f.readlines()
    for line in lines:
        if "strict digraph  {" in line or "}" in line:
            continue
        if "->" in line:
            # Encontrou uma aresta
            parts = line.strip().split(" -> ")
            source = parts[0]
            targets = parts[1].strip(";").split("; ")
            for target in targets:
                G.add_edge(source, target)
        else:
            # Encontrou um nó
            node = line.strip().strip(";")
            G.add_node(node)
    return G

# Função para implementar o algoritmo PageRank
def pagerank(graph, num_iterations=100, damping_factor=0.85):
    nodes = list(graph.nodes)
    num_nodes = len(nodes)
    initial_pagerank = 1 / num_nodes
    pagerank_dict = {node: initial_pagerank for node in nodes}
    
    for _ in range(num_iterations):
        new_pagerank_dict = {node: 0 for node in nodes}
        for node in nodes:
            neighbors = list(graph.predecessors(node))
            if len(neighbors) > 0:
                for neighbor in neighbors:
                    new_pagerank_dict[node] += pagerank_dict[neighbor] / len(neighbors)
            else:
                new_pagerank_dict[node] += pagerank_dict[node] / num_nodes
        for node in nodes:
            new_pagerank_dict[node] = (1 - damping_factor) / num_nodes + damping_factor * new_pagerank_dict[node]
        pagerank_dict = new_pagerank_dict
    
    return pagerank_dict

# Nome do arquivo .dot
dot_file = 'site_relations.dot'

# Ler o arquivo .dot e criar o grafo
graph = read_dot_file(dot_file)

# Calcular o PageRank
pagerank = pagerank(graph)

# Classificar os nós com base no PageRank
sorted_pagerank = sorted(pagerank.items(), key=lambda x: x[1], reverse=True)

# Imprimir os resultados
for node, rank in sorted_pagerank:
    print(f'{node}: {rank}')
