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
JOIN ESPECIALIDADE    esp ON f.ID_ESPECIALIDADE    = esp.ID_ESPECIALIDADE
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

-- ============================================================
-- RELATÓRIO 5 - VISÃO GERAL DAS SESSÕES
-- ============================================================
SELECT
    sa.ID_SESSAO,
    p.NOME_COMPLETO        AS PACIENTE,
    f.NOME                 AS FISIOTERAPEUTA,
    esp.NOME_ESPECIALIDADE AS ESPECIALIDADE,
    pr.NOME_PROCEDIMENTO   AS PROCEDIMENTO,
    pl.NOME_PLANO          AS PLANO_SAUDE,
    fp.DESCRICAO           AS FORMA_PAGAMENTO,
    ss.DESCRICAO           AS STATUS_SESSAO,
    sa.DATA_SESSAO,
    sa.HORA_SESSAO,
    sa.VALOR_REAL_PAGO
FROM SESSAO_AGENDA sa
JOIN PACIENTE       p   ON sa.ID_PACIENTE        = p.ID_PACIENTE
JOIN FISIOTERAPEUTA f   ON sa.ID_FISIOTERAPEUTA  = f.ID_FISIOTERAPEUTA
JOIN ESPECIALIDADE  esp ON f.ID_ESPECIALIDADE    = esp.ID_ESPECIALIDADE
JOIN PROCEDIMENTO   pr  ON sa.ID_PROCEDIMENTO    = pr.ID_PROCEDIMENTO
JOIN STATUS_SESSAO  ss  ON sa.ID_STATUS_SESSAO   = ss.ID_STATUS_SESSAO
LEFT JOIN PLANO_SAUDE    pl ON sa.ID_PLANO           = pl.ID_PLANO
LEFT JOIN FORMA_PAGAMENTO fp ON sa.ID_FORMA_PAGAMENTO = fp.ID_FORMA_PAGAMENTO
ORDER BY sa.DATA_SESSAO, sa.HORA_SESSAO;

-- ============================================================
-- RELATÓRIO 6 - PACIENTES
-- ============================================================
SELECT
    p.ID_PACIENTE,
    p.NOME_COMPLETO,
    ds.DESCRICAO AS SEXO,
    p.DATA_NASCIMENTO,
    p.DIAGNOSTICO_INICIAL,
    p.INDICACAO_TRATAMENTO
FROM PACIENTE p
JOIN DOMINIO_SEXO ds ON p.ID_SEXO = ds.ID_SEXO
ORDER BY p.NOME_COMPLETO;

-- ============================================================
-- RELATÓRIO 7 - ENDEREÇOS DOS PACIENTES
-- ============================================================
SELECT
    p.NOME_COMPLETO,
    ep.LOGRADOURO,
    ep.NUMERO,
    ep.COMPLEMENTO,
    ep.BAIRRO,
    ep.CIDADE,
    ep.ESTADO,
    ep.CEP
FROM ENDERECO_PACIENTE ep
JOIN PACIENTE p ON ep.ID_PACIENTE = p.ID_PACIENTE
ORDER BY p.NOME_COMPLETO;

-- ============================================================
-- RELATÓRIO 8 - TELEFONES DOS PACIENTES
-- ============================================================
SELECT
    p.NOME_COMPLETO,
    tp.NUMERO,
    CASE WHEN tp.EH_WHATSAPP = 1 THEN 'SIM' ELSE 'NÃO' END AS WHATSAPP
FROM TELEFONE_PACIENTE tp
JOIN PACIENTE p ON tp.ID_PACIENTE = p.ID_PACIENTE
ORDER BY p.NOME_COMPLETO;

-- ============================================================
-- RELATÓRIO 9 - AVALIAÇÕES CLÍNICAS
-- ============================================================
SELECT
    a.ID_AVALIACAO,
    p.NOME_COMPLETO AS PACIENTE,
    f.NOME          AS FISIOTERAPEUTA,
    a.DATA_AVALIACAO,
    a.DESCRICAO_AVALIACAO,
    a.PROGRESSO_PERCENTUAL,
    a.RECOMENDACAO
FROM AVALIACAO a
JOIN PACIENTE       p ON a.ID_PACIENTE       = p.ID_PACIENTE
JOIN FISIOTERAPEUTA f ON a.ID_FISIOTERAPEUTA = f.ID_FISIOTERAPEUTA
ORDER BY a.DATA_AVALIACAO DESC;

-- ============================================================
-- RELATÓRIO 10 - EXAMES DOS PACIENTES
-- ============================================================
SELECT
    ex.ID_EXAME,
    p.NOME_COMPLETO,
    te.NOME_TIPO AS TIPO_EXAME,
    ex.DATA_EXAME,
    ex.RESULTADO_LAUDO,
    ex.CAMINHO_IMAGEM
FROM EXAME ex
JOIN PACIENTE   p  ON ex.ID_PACIENTE   = p.ID_PACIENTE
JOIN TIPO_EXAME te ON ex.ID_TIPO_EXAME = te.ID_TIPO_EXAME
ORDER BY ex.DATA_EXAME DESC;

-- ============================================================
-- RELATÓRIO 11 - FINANCEIRO GERAL
-- ============================================================
SELECT
    COUNT(sa.ID_SESSAO)      AS TOTAL_SESSOES,
    SUM(sa.VALOR_REAL_PAGO)  AS RECEITA_TOTAL,
    AVG(sa.VALOR_REAL_PAGO)  AS MEDIA_RECEBIDA,
    MAX(sa.VALOR_REAL_PAGO)  AS MAIOR_PAGAMENTO,
    MIN(sa.VALOR_REAL_PAGO)  AS MENOR_PAGAMENTO
FROM SESSAO_AGENDA sa
JOIN STATUS_SESSAO ss ON sa.ID_STATUS_SESSAO = ss.ID_STATUS_SESSAO
WHERE ss.DESCRICAO = 'Concluída';

-- ============================================================
-- RELATÓRIO 12 - PRODUTIVIDADE DOS FISIOTERAPEUTAS
-- ============================================================
SELECT
    f.NOME                                                AS FISIOTERAPEUTA,
    esp.NOME_ESPECIALIDADE                                AS ESPECIALIDADE,
    COUNT(sa.ID_SESSAO)                                   AS TOTAL_SESSOES,
    SUM(COALESCE(sa.VALOR_REAL_PAGO, pr.VALOR_PADRAO))   AS FATURAMENTO_TOTAL
FROM FISIOTERAPEUTA f
LEFT JOIN ESPECIALIDADE   esp ON f.ID_ESPECIALIDADE   = esp.ID_ESPECIALIDADE
LEFT JOIN SESSAO_AGENDA   sa  ON f.ID_FISIOTERAPEUTA  = sa.ID_FISIOTERAPEUTA
LEFT JOIN PROCEDIMENTO    pr  ON sa.ID_PROCEDIMENTO   = pr.ID_PROCEDIMENTO
GROUP BY f.ID_FISIOTERAPEUTA, f.NOME, esp.NOME_ESPECIALIDADE
ORDER BY TOTAL_SESSOES DESC;

-- ============================================================
-- RELATÓRIO 13 - PROCEDIMENTOS MAIS UTILIZADOS
-- ============================================================
SELECT
    pr.NOME_PROCEDIMENTO,
    COUNT(sa.ID_SESSAO)                                   AS QUANTIDADE_REALIZADA,
    SUM(COALESCE(sa.VALOR_REAL_PAGO, pr.VALOR_PADRAO))   AS FATURAMENTO_TOTAL
FROM PROCEDIMENTO pr
JOIN SESSAO_AGENDA sa ON pr.ID_PROCEDIMENTO = sa.ID_PROCEDIMENTO
GROUP BY pr.ID_PROCEDIMENTO, pr.NOME_PROCEDIMENTO
ORDER BY QUANTIDADE_REALIZADA DESC;

-- ============================================================
-- RELATÓRIO 14 - PACIENTES COM MAIS SESSÕES
-- ============================================================
SELECT
    p.NOME_COMPLETO,
    COUNT(sa.ID_SESSAO)                                   AS TOTAL_SESSOES,
    SUM(COALESCE(sa.VALOR_REAL_PAGO, pr.VALOR_PADRAO))   AS TOTAL_GASTO
FROM PACIENTE p
JOIN SESSAO_AGENDA sa ON p.ID_PACIENTE       = sa.ID_PACIENTE
JOIN PROCEDIMENTO  pr ON sa.ID_PROCEDIMENTO  = pr.ID_PROCEDIMENTO
GROUP BY p.ID_PACIENTE, p.NOME_COMPLETO
ORDER BY TOTAL_SESSOES DESC;

-- ============================================================
-- RELATÓRIO 15 - STATUS DAS SESSÕES
-- ============================================================
SELECT
    ss.DESCRICAO       AS STATUS_SESSAO,
    COUNT(sa.ID_SESSAO) AS TOTAL
FROM STATUS_SESSAO ss
LEFT JOIN SESSAO_AGENDA sa ON ss.ID_STATUS_SESSAO = sa.ID_STATUS_SESSAO
GROUP BY ss.ID_STATUS_SESSAO, ss.DESCRICAO
ORDER BY TOTAL DESC;

-- ============================================================
-- RELATÓRIO 16 - FORMAS DE PAGAMENTO
-- ============================================================
SELECT
    fp.DESCRICAO            AS FORMA_PAGAMENTO,
    COUNT(sa.ID_SESSAO)     AS QUANTIDADE,
    SUM(sa.VALOR_REAL_PAGO) AS TOTAL_ARRECADADO
FROM FORMA_PAGAMENTO fp
LEFT JOIN SESSAO_AGENDA sa ON fp.ID_FORMA_PAGAMENTO = sa.ID_FORMA_PAGAMENTO
GROUP BY fp.ID_FORMA_PAGAMENTO, fp.DESCRICAO
ORDER BY TOTAL_ARRECADADO DESC;
