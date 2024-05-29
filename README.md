# Convenções de nomenclatura para banco de dados

## Geral

Os nomes das tabelas e colunas devem estar **minúsculas** e as palavras devem ser separadas por **underscore**, seguindo o padrão [snake case](https://en.wikipedia.org/wiki/Snake_case). E todos os termos devem estar em inglês, exceto alguns termos que não há tradução apropriada para o **inglês**. 
Sempre prefira nomes descritivos, evitando ao máximo contrações.

## Tabelas

Os nomes das tabelas devem estar no **plural**.

Ex:
- **Bom**: `users`, `posts`, `roles`, `room_categories`
- **Ruim**: `user`, `post`, `grupos`, `quarto_categoria`

## Colunas

Os nomes das colunas devem estar no **singular**.

Ex:
- **Bom**: `cpf`, `name`, `age`
- **Ruim**: `endereco`, `posts`, `idade`


## Foreign keys

Todas as foreign keys devem seguir o padrão `nome_da_tabela_no_singular_id`.

Por exemplo, caso a tabela `users` tenha um relacionameto com a tabela `roles`, o nome da coluna foreign key da tabela `users` deve ser `role_id`.

## Primary keys

A primary key de toda tabela deve ser uma coluna de inteiros com incremento automático, chamada `id`.

## Timestamps

Toda tabela deve definir duas colunas para colocar os timestamps: `created_at` e `updated_at`. A coluna `created_at` recebe automaticamente o timestamp do momento que o registro for criado. A coluna `updated_at` recebe automaticamente o timestamp do momento que o registro for alterado. 