theory Teste
  imports Main
begin

lemma eliminacao_conjuncao:
  assumes "P \<and> Q"
  shows "P"
  using assms by blast

lemma implicacao_simples:
  assumes "P"
  shows "Q \<longrightarrow> P"
  using assms by blast

end
