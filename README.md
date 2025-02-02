## Passo a Passo para utilizar o script no Power BI.

**Abra o Power BI Desktop e vá até a guia Página Inicial**

*1. Clique em Transformar Dados para abrir o Editor de Power Query.<br>
2. Na faixa de opções do Editor de Power Query, selecione Nova Fonte e depois Consulta em Branco.<br>
3. Renomeie a consulta para algo como dCalendario (opcional, mas recomendado).<br>
4. Com a consulta selecionada, na faixa de opções clique em Editor Avançado.<br>
5. Apague todo o conteúdo e cole o código M do calendário que criei.<br>
6. Clique em Concluídopara finalizar a edição do código.<br>
7. Verifique se a consulta foi atualizada e se os dados (colunas e linhas) aparecem.<br>
8. Recomendo renomear a consulta para ***d_Calendario***.<br>
9. Feche o Editor de Power Query clicando em Fechar e Aplicar para carregar a tabela de calendário no seu modelo do Power BI.* <br>

***Agora você tem uma tabela de calendário completa, com várias colunas úteis para análise temporal (Ano, Mês, Dia, Trimestre, Dia da Semana, etc.) e que se atualiza até a data atual sem precisar criar colunas calculadas em DAX.***
