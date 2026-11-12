# Isabelle/HOL + GitHub Actions (Isabelle2026)

Projeto inicial para executar verificacoes Isabelle/HOL no GitHub, sem instalar Isabelle na maquina local para esse fluxo.

## O que ele automatiza

- Ao enviar um arquivo `.thy` ou alterar o `ROOT`, o GitHub Actions inicia um ambiente Linux com a imagem oficial do Isabelle2026.
- O workflow executa `isabelle build -D . -j 2 -v`.
- Armazena o log e um resumo em `relatorios/ultimo_resultado.md` no proprio repositorio, inclusive se houver falha na prova.
- Marca a execucao como falha quando o Isabelle devolve um codigo diferente de zero.

## Primeiro uso

1. Crie um repositorio **vazio** no GitHub chamado, por exemplo, `isabelle-metafisica` (sem README inicial).
2. Extraia este ZIP numa pasta do Windows.
3. Instale Git para Windows, caso necessario: `winget install --id Git.Git -e`.
4. Abra o PowerShell dentro da pasta extraida e execute (substituindo USUARIO):

   ```powershell
   git init
   git branch -M main
   git add .
   git commit -m "Primeira versao Isabelle"
   git remote add origin https://github.com/USUARIO/isabelle-metafisica.git
   git push -u origin main
   ```

5. Na pagina do repositorio no GitHub, abra **Actions** e a execucao mais recente.
6. Confira `relatorios/ultimo_resultado.md` apos a conclusao do workflow.

**Se nao conseguir fazer commit:** o Git pode pedir que configure seu nome e email (`git config --global user.name "Seu Nome"` e `git config --global user.email "voce@exemplo.com"`). Use seu nome e email corretos, nao os valores de exemplo.

**Se o relatorio nao for publicado:** veja o erro no passo 'Atualizar relatorio'. Em **Settings > Actions > General > Workflow permissions**, permita **Read and write permissions** para o GitHub Actions, se sua conta permitir. O workflow solicita somente `contents: write`.

## Adicionar uma teoria

A teoria `Teste.thy` e um exemplo. Acrescente arquivos `.thy` na raiz do repositorio e registre cada teoria no `ROOT`. Por exemplo, se adicionar `V3.thy`, mude:

```
session Metafisica = HOL +
  options [document = false]
  theories
    Teste
    V3
```

Quando enviar os dois arquivos para o GitHub, uma nova verificacao sera iniciada automaticamente. Voce nao precisa executar os comandos do Isabelle.

## Relatorios

- `relatorios/ultimo_resultado.md`: resumo legivel e ultimas 120 linhas do log.
- `relatorios/ultimo_build.log`: log completo do ultimo build.
- `relatorios/exit_code.txt`: `0` indica sucesso; outros numeros indicam erro ou bloqueio.
- Aba **Actions**: historico de execucoes e artefatos.

## Limites

- A integracao GitHub do ChatGPT pode ler repositorios autorizados, conforme seu plano e modalidade, mas a integracao padrao de Chat nao envia arquivos ao GitHub. Por isso, a etapa de publicacao dos novos `.thy` nao e automatizada por esta conversa.
- Este projeto **verifica**, mas nao formula novas provas automaticamente; para isso e necessario um agente de IA com permissoes de escrita apropriadas.
- `sorry` e bloqueado por uma checagem textual conservadora, que tambem pode acusar ocorrencias dentro de comentarios. Nao e uma certificacao formal de ausencia de axiomas ou oraculos.
- Para guardar os relatórios no proprio repositorio, o workflow usa um token GitHub com permissao `contents: write`. Nao habilite o fluxo para pull requests externos sem revisar a seguranca.
- O Docker monta a pasta de teorias como somente leitura; o Isabelle executa dentro de um container temporario nos servidores do GitHub.
- Repositorios publicos tornam suas teorias e logs publicos. Um repositorio privado preserva a visibilidade, mas o acesso do ChatGPT exige uma integracao com permissao de leitura.
- O GitHub pode aplicar limites de tempo, espaco e consumo de Actions, especialmente em repositorios privados.

## Fontes oficiais

- Isabelle2026 e Docker: https://isabelle.in.tum.de/installation.html
- GitHub Actions: https://docs.github.com/en/actions/concepts/workflows-and-actions/workflows
- Permissoes do GitHub Actions: https://docs.github.com/en/actions/security-for-github-actions/security-guides/automatic-token-authentication
- GitHub no ChatGPT: https://help.openai.com/en/articles/11145903-connecting-github-to-chatgpt
