# Convenções de nomenclatura para banco de dados

## Geral

Os nomes das tabelas e colunas devem ter letra maiúscula na primeira letra de cada palavra, sem espaços entre palavras, seguindo o padrão [UpperCamelCase](https://pt.wikipedia.org/wiki/CamelCase#cite_note-N%C3%A3o-nomeado-xZat-1-7), com siglas tendo todas suas letras capitalizadas. Todos os termos devem estar em português, exceto alguns termos que não há tradução apropriada. 
Sempre prefira nomes descritivos, evitando ao máximo contradições e tentando manter os nomes com menos de 20 caracteres.

## Tabelas e Colunas - Apelidos

Os nomes das tabelas devem estar no **singular**.

Ex:
- **Bom**: `Usuario`, `Post`, `Grupo`
- **Ruim**: `users`, `Posts`, `grupos`

## Foreign keys

Todas as foreign keys devem seguir o padrão `IdNomeDaTabelaNoSingular`.

Por exemplo, caso a tabela `Produtos` tenha um relacionameto com a tabela `Grupos`, o nome da coluna foreign key da tabela `Produtos` deve ser `IdGrupo`.

## Nomenclatura de views

A nomenclatura geral das views deve sempre comçar com `vw_` antes do nome da view, com o tipo da view sendo especificado pelo [modelo estrela](https://www.databricks.com/br/glossary/star-schema) de classificação de tabelas entre Fato e Dimensão. As letras minúsculas `d`, `f` ou `c` antes do nome da view devem ser usadas antes do nome da view para especificar se ela é uma view de uma tabela Fato `f`, Dimensão `d` ou se é uma consulta estruturada de SQL`c`

Ex:
- **Bom**: `vw_dEquipamentos`, `vw_cDocsImportados`, `vw_fPedidos`
- **Ruim**: `vw_Equipamentos`, `vw_documento` ,`vw_dpedido`

## Tabelas de Cabeçalho/Item

No caso de tabelas de cabeçalho/item o padrão de nomes a ser ultilizado é `Cabecalhos` para a tabela cabeçalho e `CabecalhoTipoItem` para os itens.

Por exemplo, a tabela `NFEntradas` é uma tabela de cabeçalho, que possui os itens `NFEntradaItens` e `NFEntradaAnexos`.
