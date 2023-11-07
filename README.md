# Gerador de sites aleatórios

## script.sh:

- Gera N sites simples cada um com um numero aleatório de links para outros sites gerados;

- Exemplo de uso: `./script.sh  5 0` (gera 5 sites com numero minimo de links  = 0)

## graph.py:

- Scaneia a pasta `/sites` e gera um arquivo de descrição de grafos .dot

- Para visualizar o grafo gerado cole o conteudo do arquivo .dot neste site: https://edotor.net/     (ou baixe o Graphviz)

## page_rank.py

- a partir do arquivo .dot, monta um grafo e aplica o algortmo page rank

- para rodar os scripts python instale:

- ```pip install beautifulsoup4```
- ```pip install networkx```
- ```pip install pydot```
