#!/bin/bash

# Verifique se o número de sites e o número mínimo de links foram fornecidos como argumentos
if [ $# -ne 2 ]; then
    echo "Uso: $0 <número de sites (até 26)> <número mínimo de links por página>"
    exit 1
fi

# Número de sites a serem criados
num_sites=$1

# Número mínimo de links por página
min_links=$2

# Diretório onde os sites serão criados
output_dir="sites"

# Crie o diretório se ele não existir
mkdir -p "$output_dir"

# Array para armazenar os nomes dos sites (letras do alfabeto)
site_names=({A..Z})

# Verifique se o número de sites não excede 26
if [ "$num_sites" -gt 26 ]; then
    echo "O número de sites não pode exceder 26 (número de letras do alfabeto)."
    exit 1
fi

# Limite o número de sites ao número de letras do alfabeto disponíveis
site_names=("${site_names[@]:0:$num_sites}")

# Loop para criar os sites
for site_name in "${site_names[@]}"; do
    # Crie um arquivo HTML com a lista de links aleatória
    site_file="$output_dir/$site_name.html"

    # Número de links para a página
    num_links=$((min_links + RANDOM % (num_sites - min_links + 1)))

    # Array para rastrear links usados no site
    used_links=()

    echo "<head>" > "$site_file"
    echo "  <title>SITE $site_name</title>" >> "$site_file"
    echo "  <link rel=\"stylesheet\" href=\"../css/style.css\">" >> "$site_file"
    echo "</head>" >>"$site_file"
    echo "<body>" >> "$site_file"
    echo "  <div>" >> "$site_file"

    echo "      <ul>" >> "$site_file"
    for ((link_num=1; link_num<=$num_links; link_num++)); do
        # Gere um número aleatório para escolher um site aleatório
        random_site_num=$((1 + RANDOM % num_sites))
        random_site_name="${site_names[random_site_num - 1]}"

        # Verifique se o link já foi usado para evitar duplicatas
        if [ "$random_site_name" != "$site_name" ] && ! [[ " ${used_links[@]} " =~ " $random_site_name " ]]; then
            used_links+=("$random_site_name")
            echo "    <li><a href=\"$random_site_name.html\">$random_site_name</a></li>" >> "$site_file"
        fi
    done
    echo "    </ul>" >> "$site_file"
    echo "  </div>" >> "$site_file"
    echo "</body>" >> "$site_file"

    echo "Site $site_name criado em $site_file"
done