# Documentação da consulta

## Definiçaõ e Objetivo
As consultas desse grupo tem como objetivo verificar se o item selecionado possui controle de estoque, e se pertence à um departamento especificado. Essas consultas são usadas no processo de aprovação por alçada, para que dependendo do grupo do item, ele seja enviado para o aprovador adequado.
![ConsultaAprovacaoSolicitacao](https://github.com/BernardoKrop/Relatorios-e-Consultas/assets/170366143/72501d42-43b4-4155-8fbb-834de6ff8350)

## Informações técnicas
A consulta faz uma comparação com o grupo do item, usando a coluna `$[$38.1]` "Número do Item" para buscar seu grupo e verificar no banco se `U_ControlaEstoque` é S ou N. Essa comparação é feita em conjunto com a coluna `$[$38.2003]` de "Área/Departamento".
![Screenshot_1](https://github.com/BernardoKrop/Relatorios-e-Consultas/assets/170366143/650faa27-897a-45c5-9ef3-d4369da3051b)
