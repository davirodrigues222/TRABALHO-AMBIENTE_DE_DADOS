# INTEGRANTES DA EQUIPE

1 - Gabriel Vieira - Diagrama de Entidade-Relacionamento
2 - David Frota - Modelo Relacional/ Script de Carga de Dados
3 - Davi Rodrigues - Organização do projeto/ Script Criação do Banco De Dados
4 - Nicolas Castro - Criação do Script de Relatorios


# Banco de Dados — Clínica de Fisioterapia

Projeto de modelagem e implementação de banco de dados relacional para uma clínica de fisioterapia, desenvolvido na disciplina de Ambiente de Dados.

## Estrutura do Repositório

| Arquivo | Descrição |
|---|---|
| `Script_Criacao_Banco.sql` | Criação do banco de dados e todas as tabelas |
| `Script_CargaDados.sql` | Inserção dos dados de exemplo |
| `Script_Relatorio.sql` | 16 relatórios analíticos |
| `Diagrama Entidade-Relacionamento (DER).jpeg` | Diagrama ER do banco |
| `Modelo Relacional na 3ª Forma Normal (3FN).jpeg` | Modelo relacional normalizado |

## Como Executar

Execute os scripts **nesta ordem** em um servidor MySQL:

1. `Script_Criacao_Banco.sql` — cria o banco e as tabelas
2. `Script_CargaDados.sql` — popula as tabelas com dados de exemplo
3. `Script_Relatorio.sql` — executa os relatórios (pode rodar individualmente)

## Modelo de Dados

O banco está normalizado na **3ª Forma Normal (3FN)** e possui 12 tabelas:

### Tabelas de Domínio
- **DOMINIO_SEXO** — valores possíveis para sexo (Masculino, Feminino, Outro)
- **TIPO_EXAME** — tipos de exame (Raio-X, Ressonância, Ultrassom etc.)
- **TIPO_PLANO** — categorias de plano de saúde (Básico, Intermediário, Premium, Empresarial)
- **ESPECIALIDADE** — especialidades dos fisioterapeutas
- **FORMA_PAGAMENTO** — formas de pagamento aceitas
- **STATUS_SESSAO** — estados possíveis de uma sessão (Agendada, Confirmada, Concluída etc.)

### Tabelas Principais
- **PACIENTE** — cadastro dos pacientes com diagnóstico e indicação de tratamento
- **ENDERECO_PACIENTE** — endereços dos pacientes (normalizado, suporta múltiplos endereços)
- **TELEFONE_PACIENTE** — telefones dos pacientes com flag de WhatsApp
- **FISIOTERAPEUTA** — cadastro dos fisioterapeutas com especialidade e agenda
- **PLANO_SAUDE** — planos de saúde conveniados
- **PROCEDIMENTO** — procedimentos disponíveis com valor padrão
- **SESSAO_AGENDA** — agendamento e registro das sessões
- **AVALIACAO** — avaliações clínicas com percentual de progresso
- **EXAME** — exames realizados com resultado e caminho do arquivo

## Relatórios

| # | Relatório | Descrição |
|---|---|---|
| 1 | Frequência de Sessões por Paciente | Total de sessões concluídas e custo por paciente e tipo de tratamento |
| 2 | Pacientes por Fisioterapeuta | Quantidade de pacientes e valor total por fisioterapeuta |
| 3 | Sessões por Tipo de Tratamento e Período | Demanda por procedimento em um intervalo de datas |
| 4 | Ganhos por Fisioterapeuta | Faturamento mensal por fisioterapeuta |
| 5 | Visão Geral das Sessões | Listagem completa com todos os dados de cada sessão |
| 6 | Pacientes | Cadastro completo dos pacientes |
| 7 | Endereços dos Pacientes | Endereços vinculados a cada paciente |
| 8 | Telefones dos Pacientes | Telefones com indicação de WhatsApp |
| 9 | Avaliações Clínicas | Histórico de avaliações com progresso e recomendações |
| 10 | Exames dos Pacientes | Exames realizados com laudos |
| 11 | Financeiro Geral | Totais, médias e extremos de receita da clínica |
| 12 | Produtividade dos Fisioterapeutas | Sessões realizadas e faturamento por fisioterapeuta |
| 13 | Procedimentos Mais Utilizados | Ranking de procedimentos por quantidade e faturamento |
| 14 | Pacientes com Mais Sessões | Pacientes ordenados por total de sessões e gasto |
| 15 | Status das Sessões | Distribuição de sessões por status |
| 16 | Formas de Pagamento | Quantidade e total arrecadado por forma de pagamento |
