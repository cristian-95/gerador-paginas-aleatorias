#!/bin/bash

# Verifique se o número de sites e o número mínimo de links foram fornecidos como argumentos
if [ $# -ne 2 ]; then
    echo "Uso: $0 <número de sites> <número mínimo de links por página>"
    exit 1
fi

# Número de sites a serem criados
num_sites=$1

# Número mínimo de links por página
min_links=$2

# Diretório onde os sites serão criados
output_dir="sites"

# Verifique se o diretório "sites" existe e, se existir, exclua todos os arquivos
if [ -d "$output_dir" ]; then
    rm -rf "$output_dir"/*
else
    # Crie o diretório se ele não existir
    mkdir -p "$output_dir"
fi

# Loop para criar os sites
for ((site_num=1; site_num<=$num_sites; site_num++)); do
    # Nome do site no formato "siteX.html"
    site_name="site$site_num.html"

    # Crie um arquivo HTML com a lista de links aleatória
    site_file="$output_dir/$site_name"

    # Número de links para a página
    num_links=$((min_links + RANDOM % (num_sites - min_links + 1)))

    # Array para rastrear links usados no site
    used_links=()

    echo "<head>" > "$site_file"
    echo "  <title>$site_name</title>" >> "$site_file"
    echo "  <link rel=\"stylesheet\" href=\"../css/style.css\">" >> "$site_file"
    echo "</head>" >>"$site_file"
    echo "<body>" >> "$site_file"
    echo "<h1>$site_name</h1>" >> "$site_file"
    echo "  <div>" >> "$site_file"

    echo "      <ul>" >> "$site_file"
    for ((link_num=1; link_num<=$num_links; link_num++)); do
        # Gere um número aleatório para escolher um site aleatório
        random_site_num=$((1 + RANDOM % num_sites))
        random_site_name="site$random_site_num.html"

        # Verifique se o link já foi usado para evitar duplicatas
        if [ "$random_site_name" != "$site_name" ] && ! [[ " ${used_links[@]} " =~ " $random_site_name " ]]; then
            used_links+=("$random_site_name")
            echo "    <li><a href=\"$random_site_name\">$random_site_name</a></li>" >> "$site_file"
        fi
    done
    echo "    </ul>" >> "$site_file"
    echo "  </div>" >> "$site_file"
    echo "</body>" >> "$site_file"

    echo "Site $site_name criado em $site_file"
done

echo ""
python3 graph.py