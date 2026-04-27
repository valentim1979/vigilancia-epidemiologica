# ==============================================================================
# setup_global.R
# Executado automaticamente pelo Quarto antes de renderizar qualquer página.
# Localização: raiz do projeto vigilancia-epidemiologica/
#
# NÃO edite a ordem dos source(). O descritiva depende dos objetos do principal.
# ==============================================================================

message("\n[setup_global] Iniciando carregamento dos scripts...")
message("[setup_global] ", Sys.time())

# --- Script principal (SIVEP / base_filtrada / gráficos operacionais) ---
source(
  "/Users/valentimsalajunior/Documents/vigilancia-epidemiologica/SCRIPT_Unificado.R",
  echo = FALSE
)

# --- Script descritivo (D01–D12 / tabelas Excel) ---
source(
  "/Users/valentimsalajunior/Documents/vigilancia-epidemiologica/descritiva_srag_15rs.R",
  echo = FALSE
)

message("[setup_global] Carregamento concluído — objetos disponíveis para os .qmd")
