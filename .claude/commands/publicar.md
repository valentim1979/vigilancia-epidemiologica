---
description: Roda o script R, renderiza o site com Quarto e publica no GitHub Pages
argument-hint: "[--dados-novos]"
allowed-tools: Bash(./publicar.sh:*), Bash(git status:*), Bash(git diff:*)
---

Execute o pipeline de publicação do boletim de vigilância epidemiológica.

1. Rode `git status` para confirmar que não há mudanças estranhas/não relacionadas já pendentes no repositório antes de publicar.
2. Rode `./publicar.sh $ARGUMENTS` a partir da raiz do repositório. O script faz, em ordem:
   - `Rscript SCRIPT_Unificado.R` — gera os gráficos/tabelas em `graficos/` e `dados/` (baixa dados via API do dados.gov.br quando não há DBF local em `dbf_sivep/`; requer `DADOS_GOV_TOKEN` em `~/.Renviron`);
   - se `--dados-novos` foi passado, apaga `_freeze/` para forçar o Quarto a reprocessar;
   - `quarto render` — gera o site estático em `docs/`;
   - `git add .`, `git commit` (mensagem automática com a data) e `git push` para `origin/main`, que publica em https://valentim1979.github.io/virus-respiratorios.
3. Se `Rscript` ou `quarto` falharem, pare e reporte o erro exato ao usuário — não tente contornar (não pule etapas, não faça commit parcial).
4. Ao final, confirme a URL do site publicado e resuma o que foi commitado (`git log -1 --stat`).

Use `--dados-novos` sempre que houver dados novos do SIVEP-Gripe/DBF para forçar a reexecução completa; sem o argumento, reaproveita o cache do Quarto (freeze: auto) e é mais rápido para mudanças só de layout/texto.
