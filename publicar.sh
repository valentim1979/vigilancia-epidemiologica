#!/bin/bash
# ==============================================================================
# publicar.sh — Vigilância Epidemiológica / 15ª RS Maringá
# Uso normal (dados não mudaram):   ./publicar.sh
# Uso com dados novos (DBF novo):   ./publicar.sh --dados-novos
# ==============================================================================

set -e   # interrompe se qualquer comando falhar

PROJETO="/Users/valentimsalajunior/Documents/vigilancia-epidemiologica"
cd "$PROJETO"

echo ""
echo "=================================================="
echo "  PUBLICAR — $(date '+%d/%m/%Y %H:%M')"
echo "=================================================="

# --- Se --dados-novos for passado, invalida o cache do freeze ---
# Isso força o Quarto a re-executar os scripts mesmo sem mudança nos .qmd
if [[ "$1" == "--dados-novos" ]]; then
  echo ""
  echo "[1/4] Dados novos detectados — limpando cache do freeze..."
  rm -rf _freeze/
  echo "      Cache removido."
else
  echo ""
  echo "[1/4] Usando cache existente (freeze: auto)."
  echo "      Para forçar re-execução com DBF novo: ./publicar.sh --dados-novos"
fi

# --- Renderiza o projeto ---
echo ""
echo "[2/4] Renderizando projeto Quarto..."
quarto render

# --- Commit e push ---
echo ""
echo "[3/4] Enviando para o GitHub..."
git add .

# Mensagem de commit automática com data
if [[ "$1" == "--dados-novos" ]]; then
  git commit -m "Atualização de dados — $(date '+%d/%m/%Y')" || echo "Nada novo para commitar."
else
  git commit -m "Atualização de layout/texto — $(date '+%d/%m/%Y')" || echo "Nada novo para commitar."
fi

git push

echo ""
echo "[4/4] Publicado."
echo "=================================================="
echo "  Site: https://valentim1979.github.io/vigilancia-epidemiologica"
echo "=================================================="
echo ""
