# Ultima verificacao Isabelle/HOL

**Resultado:** REPROVADO — codigo de saida 127

**Data UTC:** 2026-11-12 14:39:43

**Commit de origem:** `d764bd90bbf8d7c9b1ef6ce8ff807eb33ed194bf`

**Versao:** Isabelle2026, imagem Docker oficial `makarius/isabelle:Isabelle2026`.

**Verificacao:** `isabelle build -D . -j 2 -v`.

> Um build aprovado verifica as teorias listadas no ROOT, nao a verdade filosofica dos axiomas.
> O filtro textual de `sorry` e conservador e nao substitui uma auditoria dos axiomas e oraculos.

## Ultimas linhas do log

```text
Data UTC: 2026-11-12 14:39:01
Commit: d764bd90bbf8d7c9b1ef6ce8ff807eb33ed194bf
Imagem: makarius/isabelle:Isabelle2026
Comando: isabelle build -D . -j 2 -v

Unable to find image 'makarius/isabelle:Isabelle2026' locally
Isabelle2026: Pulling from makarius/isabelle
435bf5c20694: Pulling fs layer
d9d511d19a19: Pulling fs layer
0ddd5b993b86: Pulling fs layer
390433ddf1e7: Pulling fs layer
4f4fb700ef54: Pulling fs layer
e25f76115ad3: Pulling fs layer
72ff5e9b9923: Pulling fs layer
4f4fb700ef54: Waiting
390433ddf1e7: Waiting
72ff5e9b9923: Waiting
e25f76115ad3: Waiting
d9d511d19a19: Verifying Checksum
d9d511d19a19: Download complete
435bf5c20694: Verifying Checksum
435bf5c20694: Download complete
390433ddf1e7: Verifying Checksum
390433ddf1e7: Download complete
4f4fb700ef54: Verifying Checksum
4f4fb700ef54: Download complete
0ddd5b993b86: Verifying Checksum
0ddd5b993b86: Download complete
435bf5c20694: Pull complete
e25f76115ad3: Verifying Checksum
e25f76115ad3: Download complete
72ff5e9b9923: Verifying Checksum
72ff5e9b9923: Download complete
d9d511d19a19: Pull complete
0ddd5b993b86: Pull complete
390433ddf1e7: Pull complete
4f4fb700ef54: Pull complete
e25f76115ad3: Pull complete
72ff5e9b9923: Pull complete
Digest: sha256:d6e7b8995f30a7e33172b750a1db9f5d46d39d8dcd59303c2390df4fdd5dae93
Status: Downloaded newer image for makarius/isabelle:Isabelle2026
docker: Error response from daemon: failed to create task for container: failed to create shim task: OCI runtime create failed: runc create failed: unable to start container process: error during container init: exec: "Isabelle/bin/isabelle": stat Isabelle/bin/isabelle: no such file or directory

Run 'docker run --help' for more information
```
