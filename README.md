Proj-Capacidade-Produtiva---Etapa-I
Proj Capacidade Produtiva - Etapa I

O atual momento de escassez orçamentária/financeira e de pessoal em que se encontra o o mercado, vem exigindo esforços pela busca de métodos de planejamento que otimizem o uso dos recursos, priorizem demandas, aumentem a produtividade e o impacto das ações de supervisão de mercado. 
	O sistema utiliza basicamente três variáveis para estabelecerem suas metas nos Planos de Planejamento Técnico: histórico de execução, quantitativo de pessoal técnico capacitado e disponibilidade financeira.   
	No entanto, estas variáveis vem se mostrando insuficientes, para produzir um plano de planejamento Técnico que considere o melhor potencial de produtividade, com maior cobertura e impacto nos setores econômicos e nas áreas geográficas que mais necessitam acompanhamento.

## Preparação do ambiente de programação

A linguagem escolhida para trabalhar a estrutura de dados “BDCP”, na organização, parametrização, categorização e analise de dados, foi o “R” que é muito utilizada em áreas de Data-Science.

a) Linguagem R - R é uma linguagem de programação multi-paradigma orientada a objetos, programação funcional, dinâmica, fracamente tipada, voltada à manipulação, análise e visualização de dados.
O R disponibiliza uma ampla variedade de técnicas estatísticas e gráficas, incluindo modelação linear e não linear, testes estatísticos clássicos, análise de séries temporais (time-series analysis), classificação, agrupamento e outras. A R é facilmente extensível através de funções e extensões, e a comunidade R é reconhecida pelos seus contributos ativos em termos de pacotes.

b) IDE Rstudio - RStudio é um ambiente de desenvolvimento integrado (IDE) para R. Inclui um console, editor de realce de sintaxe que oferece suporte à execução direta de código, bem como ferramentas para plotagem, histórico, depuração e gerenciamento de espaço de trabalho.

c) Foi adotado para a criação dos códigos o RMarkdown que é uma linguagem pensada para a escrita de textos em que são criadas marcações para títulos, links, códigos de um modo conciso e legível. É tão legível que está hoje ao alcance de pessoas que não desenvolvem para ‘web’ como eu e você, possivelmente.

## Metodologia

Este projeto será executado em 3 fases não necessariamente subsequentes, desenvolvidas por meio de análise documental exploratória, pesquisa bibliográfica, aplicação de métodos estatísticos e sistematização em plataforma web.

## Sub-Etapas

1 - Estruturação do Banco de dados “BDCP” é (y1..x1,x2..) sendo uma variável de produção (dependente) e duas variáveis explicativas (independente), que são os dados do “Produção” Plano de Planejamento de Técnico, despesa de custeio total e da Força de trabalho total e foram obtidas do sistema interno, todos os dados são da respectiva série temporal de 2012 a 2020.
![image](https://user-images.githubusercontent.com/66335171/169863763-8dc0fd9c-d9c7-4bf9-8864-04c438062dd4.png)


2 - Procedimentos (Análise de agrupamentos/Dendrogramas) - A análise de cluster é uma técnica estatística usada para classificar elementos em grupos, de forma que elementos dentro de um mesmo cluster sejam muito parecidos, e os elementos em diferentes clusters sejam distintos entre si e o uso do dendograma para visualizar o processo de clusterização passo a passo, assim como analisar os níveis de distância dos clusters formados. Um bom ponto de decisão da clusterização final é onde os valores de distância mudam consideravelmente. Para a decisão do agrupamento final também devem ser avaliados se os clusters formados fazem sentido para o problema.
![image](https://user-images.githubusercontent.com/66335171/169865503-297ccd11-93a0-4e9a-92c8-56dcf6dba093.png)

inserir mapa

3 - Procedimentos (Boxplot) - O Boxplot ou box plot é um diagrama de caixa construído utilizando as referências de valores mínimos e máximos, primeiro e terceiro quartil, mediana e outliers da base de dados. No boxplot a parte central do gráfico contém os valores que estão entre o primeiro quartil e o terceiro quartil.
![image](https://user-images.githubusercontent.com/66335171/169865645-37f0d30e-ade1-4cf4-981d-65d1422c9de1.png)


4 - Procedimentos de análise de Fatores de variação de inflação - Por meio das técnicas de Correlação, variância e covariância (matrizes) e Fatores de variação de inflação, para se identificar as melhores variáveis para próxima etapa do projeto.

inserir gráfico vif

5 - Procedimentos (Regressão linear múltipla (RLM) e Especificações mínimas do modelo) - 
Regressão linear múltipla (RLM)

A Regressão Linear Múltipla é um modelo de análise que usamos quando modelamos a relação linear entre uma variável de desfecho contínua e múltiplas variáveis preditoras que podem ser contínuas ou categóricas.

Especificações mínimas do modelo

A análise de regressão gera uma equação para descrever a relação entre uma ou mais variáveis e a variável resposta. Depois de usar o linguagem “R” para ajustar um modelo de regressão e verificar o ajuste  através dos gráficos de resíduos, devemos interpretar os valores-p e os coeficientes que aparecem na saída da análise de regressão linear.

O valor-p para cada termo testa a hipótese nula de que o coeficiente é igual a zero (sem efeito). Um valor-p baixo (< 0,05) indica que você pode rejeitar a hipótese nula. Em outras palavras, uma variável que tenha um valor-p baixo provavelmente será significativa ao seu modelo, porque as alterações no valor dela estão relacionadas à alterações na variável resposta.

Por outro lado, um valor-p maior (> 0,05) sugere que as mudanças na variável não estão associadas à mudanças na variável resposta.


## Perguntas a serem respondidas com a Regressão linear múltipla (RLM)

Uma mudança de k unidades na força de trabalho ( FT ) implica em quanto de mudança na produção (UBP)?

II  -  Uma mudança de valor #R$ no Custeio Total  implica em quanto de mudança na produção (UBP)?

III -  Qual faixa, em %, a ser adotada para controle / acompanhamento / projeções da produção?

IV -  É possível relacionar projeto com o índice de atingimento de metas(IAM)?

V -   O UF executa bem ou planeja mal?

VI -  Quais UF estão produzindo de forma coerente com  FT e o Custeio que possuem?

VII - Quais OD estão produzindo aquém do esperado?
