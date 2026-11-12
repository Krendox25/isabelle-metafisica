#!/usr/bin/env bash
# Executa as provas no Isabelle2026 oficial, gera um relatorio sem autenticar ninguem.
# Nao passa tokens ou segredos para o container Docker.
set -uo pipefail
mkdir -p relatorios
LOG='relatorios/ultimo_build.log'
REPORT='relatorios/ultimo_resultado.md'
CODE_FILE='relatorios/exit_code.txt'

{
  echo "Data UTC: $(date -u '+%Y-%m-%d %H:%M:%S')"
  echo "Commit: ${GITHUB_SHA:-local}"
  echo 'Imagem: makarius/isabelle:Isabelle2026'
  echo 'Comando: isabelle build -D /home/isabelle/projeto -j 2 -v'
  echo
} > "$LOG"

# Bloqueio textual conservador. Ele pode detectar 'sorry' ate em comentarios.
# O build bem-sucedido sozinho nao certifica ausencia de axiomas/oraculos.
if grep -nHE --include='*.thy' '(^|[[:space:]])sorry([[:space:]]|$)' ./*.thy >> "$LOG" 2>&1; then
  echo 'ERRO: foi encontrado o comando ou texto "sorry" em arquivo .thy.' >> "$LOG"
  code=90
elif ! command -v docker >/dev/null 2>&1; then
  echo 'ERRO: Docker nao encontrado.' >> "$LOG"
  code=127
else
  # A pasta do codigo e montada somente para leitura no container.
  # A compilacao e os heaps do Isabelle ficam dentro do container.
  docker run --rm \
    --volume "$(pwd):/home/isabelle/projeto:ro" \
    makarius/isabelle:Isabelle2026 \
    build -D /home/isabelle/projeto -j 2 -v >> "$LOG" 2>&1
  code=$?
fi

printf '%s\n' "$code" > "$CODE_FILE"
if [ "$code" -eq 0 ]; then
  status='APROVADO — Isabelle concluiu a compilacao'
else
  status="REPROVADO — codigo de saida $code"
fi

{
  echo '# Ultima verificacao Isabelle/HOL'
  echo
  echo "**Resultado:** $status"
  echo
  echo "**Data UTC:** $(date -u '+%Y-%m-%d %H:%M:%S')"
  echo
  echo "**Commit de origem:** \`${GITHUB_SHA:-execucao-local}\`"
  echo
  echo '**Versao:** Isabelle2026, imagem Docker oficial `makarius/isabelle:Isabelle2026`.'
  echo
  echo '**Verificacao:** `isabelle build -D . -j 2 -v`.'
  echo
  echo '> Um build aprovado verifica as teorias listadas no ROOT, nao a verdade filosofica dos axiomas.'
  echo '> O filtro textual de `sorry` e conservador e nao substitui uma auditoria dos axiomas e oraculos.'
  echo
  echo '## Ultimas linhas do log'
  echo
  echo '```text'
  tail -n 120 "$LOG" | sed 's/```/` ` `/g'
  echo '```'
} > "$REPORT"

echo "Resultado: $status"
echo "Relatorio: $REPORT"
# O workflow usa exit_code.txt depois de publicar os relatorios.
exit 0
