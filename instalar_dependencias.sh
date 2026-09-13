#!/bin/bash
# ==============================================================================
# instalar_dependencias.sh — Vigilância Epidemiológica / 15ª RS Maringá
# Instala o Quarto CLI, as libs de sistema (GDAL/GEOS/PROJ/UDUNITS — exigidas
# pelos pacotes R "sf" e "tmap") e os pacotes R usados por SCRIPT_Unificado.R
# e descritiva_srag_15rs.R.
#
# Uso: ./instalar_dependencias.sh
# Vai pedir sua senha sudo (pacman) e confirmação do yay para os pacotes AUR.
# ==============================================================================

set -e

echo ""
echo "=================================================="
echo "  INSTALAR DEPENDÊNCIAS — $(date '+%d/%m/%Y %H:%M')"
echo "=================================================="

# --- 1. Libs de sistema do repositório oficial (GDAL/GEOS/PROJ) ---
echo ""
echo "[1/4] Instalando libs de sistema (gdal, geos, proj)..."
sudo pacman -S --needed gdal geos proj

# --- 2. udunits (só existe no AUR) ---
echo ""
echo "[2/4] Instalando udunits (AUR)..."
yay -S --needed udunits

# --- 3. Quarto CLI (binário pré-compilado, AUR) ---
echo ""
echo "[3/4] Instalando Quarto CLI (quarto-cli-bin, AUR)..."
yay -S --needed quarto-cli-bin

# --- 4. Pacotes R exigidos pelos scripts ---
echo ""
echo "[4/4] Instalando pacotes R..."
Rscript -e '
pacotes <- c(
  "sf", "foreign", "dplyr", "ggplot2", "scales", "tidyr",
  "readr", "stringr", "lubridate", "forcats", "tmap", "writexl",
  "httr", "jsonlite", "kableExtra"
)
faltando <- pacotes[!sapply(pacotes, requireNamespace, quietly = TRUE)]
if (length(faltando) > 0) {
  message("Instalando: ", paste(faltando, collapse = ", "))
  install.packages(faltando, repos = "https://cloud.r-project.org")
} else {
  message("Todos os pacotes R já estão instalados.")
}
'

echo ""
echo "=================================================="
echo "  Concluído. Verifique com:"
echo "    quarto check"
echo "    Rscript -e 'library(sf); library(tmap)'"
echo "=================================================="
echo ""
