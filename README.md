# 📊 Dashboard Comercial | Aurora Comercial

Projeto de **Business Intelligence (BI)** desenvolvido no Power BI para analisar o desempenho comercial da Aurora Comercial, uma empresa fictícia do setor de vendas.

O dashboard permite acompanhar indicadores de faturamento, custos, pedidos e metas, oferecendo uma visão dos resultados comerciais e auxiliando na identificação de oportunidades de melhoria.

---

## 🎯 Objetivo

Centralizar as informações comerciais da empresa em um único ambiente interativo, facilitando o acompanhamento do faturamento, a comparação do desempenho dos vendedores com suas metas e a análise dos resultados por período e região.

---

## 🛠️ Ferramentas Utilizadas

| Ferramenta | Aplicação |
|---|---|
| **Power BI** | Desenvolvimento do dashboard e visualização dos indicadores. |
| **Power Query** | Tratamento, transformação e preparação dos dados. |
| **DAX** | Criação de medidas e cálculos para os indicadores. |
| **MySQL** | Armazenamento e consulta dos dados comerciais. |

---

## 🗂️ Fonte de Dados

O projeto utiliza uma base de dados fictícia desenvolvida para representar as operações comerciais da Aurora Comercial.

A base contempla informações sobre:

- Vendas e pedidos;
- Clientes;
- Produtos e categorias;
- Vendedores;
- Regiões;
- Metas comerciais.

Essas informações permitem analisar o faturamento, o desempenho individual dos vendedores e os resultados comerciais ao longo do tempo.

---

## 🧩 Modelagem de Dados

O modelo de dados foi estruturado com tabelas fato e tabelas dimensão, organizadas para facilitar a análise das informações comerciais.

A tabela `pedidos` concentra os registros das operações comerciais, enquanto as tabelas de clientes, produtos, vendedores e regiões fornecem informações descritivas para as análises.

A tabela calendário permite analisar os resultados ao longo do tempo.

Os relacionamentos entre as tabelas possibilitam a aplicação de filtros e a atualização dos indicadores e gráficos conforme os critérios selecionados.

---

## ⚙️ Tratamento dos Dados

A preparação dos dados foi realizada no Power Query, contemplando verificações e transformações para adequar as informações à modelagem e às análises.

As principais atividades incluem:

- Verificação dos tipos de dados;
- Conferência da consistência das datas;
- Padronização das informações;
- Verificação de valores nulos;
- Preparação das tabelas para utilização no modelo de dados.

---

## 📈 Indicadores (KPIs)

O dashboard apresenta indicadores para acompanhar os principais resultados comerciais da empresa.

| Indicador | Descrição |
|---|---|
| **Faturamento Bruto** | Valor total das vendas no período selecionado. |
| **Faturamento Líquido** | Faturamento bruto descontado dos custos considerados no projeto. |
| **Custo Total** | Total dos custos de fabricação dos produtos e das entregas. |
| **Pedidos x Vendas** | Comparação entre a quantidade de pedidos e o volume de vendas. |
| **Meta Total** | Valor total das metas comerciais estabelecidas para os vendedores. |
| **Atingimento de Meta (%)** | Percentual da meta alcançado no período selecionado. |

---

## 📊 Estrutura do Dashboard

### 1. Visão Geral

Apresenta o faturamento bruto e os principais indicadores comerciais, proporcionando uma visão inicial dos resultados da empresa.

### 2. Vendedores

Permite analisar o desempenho da equipe comercial por meio de:

- TOP 3 vendedores por faturamento;
- Faturamento individual por vendedor;
- Comparação entre faturamento e metas;
- Análise do faturamento por região.

---

## 🔎 Principais Análises

O dashboard permite explorar questões importantes para a gestão comercial, como:

- Quais vendedores apresentam o maior faturamento?
- Quais vendedores alcançaram suas metas comerciais?
- Quais períodos apresentam os melhores resultados?
- Quais regiões contribuem mais para o faturamento?
- Como o desempenho comercial varia conforme os filtros selecionados?

---

## 💡 Resultados Esperados

Espera-se que o dashboard contribua para:

- Facilitar o acompanhamento dos resultados comerciais;
- Reduzir o tempo necessário para consultar informações;
- Identificar vendedores com melhor desempenho;
- Acompanhar o cumprimento das metas comerciais;
- Identificar oportunidades de melhoria;
- Apoiar o planejamento e a tomada de decisões.

---

## 🏁 Conclusão

O desenvolvimento do dashboard comercial da Aurora Comercial permitiu aplicar conhecimentos de preparação e modelagem de dados, criação de medidas DAX e visualização de indicadores no Power BI.

A solução reúne informações relevantes sobre faturamento, custos, vendedores e metas, demonstrando como a análise de dados pode transformar registros comerciais em informações úteis para o acompanhamento dos resultados e o apoio à tomada de decisões.

---

**Nota:** A Aurora Comercial e os dados utilizados neste projeto são fictícios, destinados a fins de estudo e demonstração de conhecimentos em Business Intelligence.
