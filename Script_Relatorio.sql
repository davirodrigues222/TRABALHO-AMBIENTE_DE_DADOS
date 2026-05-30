USE clinica_fisioterapia;

-- =========================================================================================
-- RELATÓRIO 1: Frequência de Sessões por Paciente
-- Exibe o total de sessões realizadas por cada paciente, separadas pelo tipo de tratamento,
-- totalizando os custos.
-- =========================================================================================
SELECT
    p.NOME_COMPLETO                                       AS PACIENTE,
    pr.NOME_PROCEDIMENTO                                  AS TIPO_TRATAMENTO,
    COUNT(sa.ID_SESSAO)                                   AS TOTAL_SESSOES,
    SUM(COALESCE(sa.VALOR_REAL_PAGO, pr.VALOR_PADRAO))   AS CUSTO_TOTAL
FROM SESSAO_AGENDA sa
JOIN PACIENTE      p   ON sa.ID_PACIENTE      = p.ID_PACIENTE
JOIN PROCEDIMENTO  pr  ON sa.ID_PROCEDIMENTO  = pr.ID_PROCEDIMENTO
JOIN STATUS_SESSAO ss  ON sa.ID_STATUS_SESSAO = ss.ID_STATUS_SESSAO
WHERE ss.DESCRICAO = 'Concluída'
GROUP BY p.ID_PACIENTE, p.NOME_COMPLETO, pr.ID_PROCEDIMENTO, pr.NOME_PROCEDIMENTO
ORDER BY p.NOME_COMPLETO, TOTAL_SESSOES DESC;

-- =========================================================================================
-- RELATÓRIO 2: Pacientes por Fisioterapeuta
-- Lista cada fisioterapeuta com o número de pacientes sob seu cuidado e o valor total
-- que os pacientes vão pagar.
-- =========================================================================================
SELECT
    f.NOME                                                AS FISIOTERAPEUTA,
    esp.NOME_ESPECIALIDADE                                AS ESPECIALIDADE,
    COUNT(DISTINCT sa.ID_PACIENTE)                        AS TOTAL_PACIENTES,
    SUM(COALESCE(sa.VALOR_REAL_PAGO, pr.VALOR_PADRAO))   AS VALOR_TOTAL
FROM FISIOTERAPEUTA f
JOIN ESPECIALIDADE   esp ON f.ID_ESPECIALIDADE    = esp.ID_ESPECIALIDADE
LEFT JOIN SESSAO_AGENDA sa  ON f.ID_FISIOTERAPEUTA = sa.ID_FISIOTERAPEUTA
LEFT JOIN PROCEDIMENTO  pr  ON sa.ID_PROCEDIMENTO  = pr.ID_PROCEDIMENTO
GROUP BY f.ID_FISIOTERAPEUTA, f.NOME, esp.NOME_ESPECIALIDADE
ORDER BY TOTAL_PACIENTES DESC;

-- =========================================================================================
-- RELATÓRIO 3: Sessões por Tipo de Tratamento e Período
-- Mostra o número de sessões realizadas para cada tipo de tratamento em um intervalo de
-- datas específico, ajudando na análise de demanda.
-- Ajuste as datas do WHERE conforme o período desejado.
-- =========================================================================================
SELECT
    pr.NOME_PROCEDIMENTO   AS TIPO_TRATAMENTO,
    COUNT(sa.ID_SESSAO)    AS TOTAL_SESSOES
FROM SESSAO_AGENDA sa
JOIN PROCEDIMENTO pr ON sa.ID_PROCEDIMENTO = pr.ID_PROCEDIMENTO
WHERE sa.DATA_SESSAO BETWEEN '2025-04-01' AND '2025-04-30'
GROUP BY pr.ID_PROCEDIMENTO, pr.NOME_PROCEDIMENTO
ORDER BY TOTAL_SESSOES DESC;

-- =========================================================================================
-- RELATÓRIO 4: Ganhos por Fisioterapeuta
-- Mostra, por mês e ano: soma total dos ganhos, quantidade de sessões e quantidade de
-- pacientes atendidos no mês.
-- =========================================================================================
SELECT
    f.NOME                                                AS FISIOTERAPEUTA,
    YEAR(sa.DATA_SESSAO)                                  AS ANO,
    MONTH(sa.DATA_SESSAO)                                 AS MES,
    COUNT(sa.ID_SESSAO)                                   AS TOTAL_SESSOES,
    COUNT(DISTINCT sa.ID_PACIENTE)                        AS TOTAL_PACIENTES,
    SUM(COALESCE(sa.VALOR_REAL_PAGO, pr.VALOR_PADRAO))   AS GANHO_TOTAL
FROM FISIOTERAPEUTA f
JOIN SESSAO_AGENDA sa  ON f.ID_FISIOTERAPEUTA  = sa.ID_FISIOTERAPEUTA
JOIN PROCEDIMENTO  pr  ON sa.ID_PROCEDIMENTO   = pr.ID_PROCEDIMENTO
JOIN STATUS_SESSAO ss  ON sa.ID_STATUS_SESSAO  = ss.ID_STATUS_SESSAO
WHERE ss.DESCRICAO = 'Concluída'
GROUP BY f.ID_FISIOTERAPEUTA, f.NOME, YEAR(sa.DATA_SESSAO), MONTH(sa.DATA_SESSAO)
ORDER BY f.NOME, ANO, MES;
