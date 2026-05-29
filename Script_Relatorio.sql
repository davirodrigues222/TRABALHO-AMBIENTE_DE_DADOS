USE clinica_fisioterapia;

-- ============================================================
-- RELATÓRIO 1 - VISÃO GERAL DAS SESSÕES
-- ============================================================

SELECT
    sa.ID_SESSAO,
    p.NOME_COMPLETO AS PACIENTE,
    f.NOME AS FISIOTERAPEUTA,
    esp.NOME_ESPECIALIDADE AS ESPECIALIDADE,
    pr.NOME_PROCEDIMENTO AS PROCEDIMENTO,
    pl.NOME_PLANO AS PLANO_SAUDE,
    fp.DESCRICAO AS FORMA_PAGAMENTO,
    ss.DESCRICAO AS STATUS_SESSAO,
    sa.DATA_SESSAO,
    sa.HORA_SESSAO,
    sa.VALOR_REAL_PAGO
FROM SESSAO_AGENDA sa
JOIN PACIENTE p
    ON sa.ID_PACIENTE = p.ID_PACIENTE
JOIN FISIOTERAPEUTA f
    ON sa.ID_FISIOTERAPEUTA = f.ID_FISIOTERAPEUTA
JOIN ESPECIALIDADE esp
    ON f.ID_ESPECIALIDADE = esp.ID_ESPECIALIDADE
JOIN PROCEDIMENTO pr
    ON sa.ID_PROCEDIMENTO = pr.ID_PROCEDIMENTO
JOIN PLANO_SAUDE pl
    ON sa.ID_PLANO = pl.ID_PLANO
JOIN FORMA_PAGAMENTO fp
    ON sa.ID_FORMA_PAGAMENTO = fp.ID_FORMA_PAGAMENTO
JOIN STATUS_SESSAO ss
    ON sa.ID_STATUS_SESSAO = ss.ID_STATUS_SESSAO
ORDER BY sa.DATA_SESSAO, sa.HORA_SESSAO;

-- ============================================================
-- RELATÓRIO 2 - PACIENTES
-- ============================================================

SELECT
    p.ID_PACIENTE,
    p.NOME_COMPLETO,
    ds.DESCRICAO AS SEXO,
    p.DATA_NASCIMENTO,
    p.DIAGNOSTICO_INICIAL,
    p.INDICACAO_TRATAMENTO
FROM PACIENTE p
JOIN DOMINIO_SEXO ds
    ON p.ID_SEXO = ds.ID_SEXO
ORDER BY p.NOME_COMPLETO;

-- ============================================================
-- RELATÓRIO 3 - ENDEREÇOS DOS PACIENTES
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
JOIN PACIENTE p
    ON ep.ID_PACIENTE = p.ID_PACIENTE
ORDER BY p.NOME_COMPLETO;

-- ============================================================
-- RELATÓRIO 4 - TELEFONES DOS PACIENTES
-- ============================================================

SELECT
    p.NOME_COMPLETO,
    tp.NUMERO,
    CASE
        WHEN tp.EH_WHATSAPP = 1 THEN 'SIM'
        ELSE 'NÃO'
    END AS WHATSAPP
FROM TELEFONE_PACIENTE tp
JOIN PACIENTE p
    ON tp.ID_PACIENTE = p.ID_PACIENTE
ORDER BY p.NOME_COMPLETO;

-- ============================================================
-- RELATÓRIO 5 - AVALIAÇÕES CLÍNICAS
-- ============================================================

SELECT
    a.ID_AVALIACAO,
    p.NOME_COMPLETO AS PACIENTE,
    f.NOME AS FISIOTERAPEUTA,
    a.DATA_AVALIACAO,
    a.DESCRICAO_AVALIACAO,
    a.PROGRESSO_PERCENTUAL,
    a.RECOMENDACAO
FROM AVALIACAO a
JOIN PACIENTE p
    ON a.ID_PACIENTE = p.ID_PACIENTE
JOIN FISIOTERAPEUTA f
    ON a.ID_FISIOTERAPEUTA = f.ID_FISIOTERAPEUTA
ORDER BY a.DATA_AVALIACAO DESC;

-- ============================================================
-- RELATÓRIO 6 - EXAMES DOS PACIENTES
-- ============================================================

SELECT
    ex.ID_EXAME,
    p.NOME_COMPLETO,
    te.NOME_TIPO AS TIPO_EXAME,
    ex.DATA_EXAME,
    ex.RESULTADO_LAUDO,
    ex.CAMINHO_IMAGEM
FROM EXAME ex
JOIN PACIENTE p
    ON ex.ID_PACIENTE = p.ID_PACIENTE
JOIN TIPO_EXAME te
    ON ex.ID_TIPO_EXAME = te.ID_TIPO_EXAME
ORDER BY ex.DATA_EXAME DESC;

-- ============================================================
-- RELATÓRIO 7 - FINANCEIRO GERAL
-- ============================================================

SELECT
    COUNT(sa.ID_SESSAO) AS TOTAL_SESSOES,
    SUM(sa.VALOR_REAL_PAGO) AS RECEITA_TOTAL,
    AVG(sa.VALOR_REAL_PAGO) AS MEDIA_RECEBIDA,
    MAX(sa.VALOR_REAL_PAGO) AS MAIOR_PAGAMENTO,
    MIN(sa.VALOR_REAL_PAGO) AS MENOR_PAGAMENTO
FROM SESSAO_AGENDA sa
JOIN STATUS_SESSAO ss
    ON sa.ID_STATUS_SESSAO = ss.ID_STATUS_SESSAO
WHERE ss.DESCRICAO = 'Realizada';

-- ============================================================
-- RELATÓRIO 8 - PRODUTIVIDADE DOS FISIOTERAPEUTAS
-- ============================================================

SELECT
    f.NOME AS FISIOTERAPEUTA,
    esp.NOME_ESPECIALIDADE AS ESPECIALIDADE,
    COUNT(sa.ID_SESSAO) AS TOTAL_SESSOES,
    SUM(sa.VALOR_REAL_PAGO) AS FATURAMENTO_TOTAL
FROM FISIOTERAPEUTA f
LEFT JOIN ESPECIALIDADE esp
    ON f.ID_ESPECIALIDADE = esp.ID_ESPECIALIDADE
LEFT JOIN SESSAO_AGENDA sa
    ON f.ID_FISIOTERAPEUTA = sa.ID_FISIOTERAPEUTA
GROUP BY
    f.ID_FISIOTERAPEUTA,
    f.NOME,
    esp.NOME_ESPECIALIDADE
ORDER BY TOTAL_SESSOES DESC;

-- ============================================================
-- RELATÓRIO 9 - PROCEDIMENTOS MAIS UTILIZADOS
-- ============================================================

SELECT
    pr.NOME_PROCEDIMENTO,
    COUNT(sa.ID_SESSAO) AS QUANTIDADE_REALIZADA,
    SUM(sa.VALOR_REAL_PAGO) AS FATURAMENTO_TOTAL
FROM PROCEDIMENTO pr
JOIN SESSAO_AGENDA sa
    ON pr.ID_PROCEDIMENTO = sa.ID_PROCEDIMENTO
GROUP BY
    pr.ID_PROCEDIMENTO,
    pr.NOME_PROCEDIMENTO
ORDER BY QUANTIDADE_REALIZADA DESC;

-- ============================================================
-- RELATÓRIO 10 - PACIENTES COM MAIS SESSÕES
-- ============================================================

SELECT
    p.NOME_COMPLETO,
    COUNT(sa.ID_SESSAO) AS TOTAL_SESSOES,
    SUM(sa.VALOR_REAL_PAGO) AS TOTAL_GASTO
FROM PACIENTE p
JOIN SESSAO_AGENDA sa
    ON p.ID_PACIENTE = sa.ID_PACIENTE
GROUP BY
    p.ID_PACIENTE,
    p.NOME_COMPLETO
ORDER BY TOTAL_SESSOES DESC;

-- ============================================================
-- RELATÓRIO 11 - STATUS DAS SESSÕES
-- ============================================================

SELECT
    ss.DESCRICAO AS STATUS_SESSAO,
    COUNT(sa.ID_SESSAO) AS TOTAL
FROM STATUS_SESSAO ss
LEFT JOIN SESSAO_AGENDA sa
    ON ss.ID_STATUS_SESSAO = sa.ID_STATUS_SESSAO
GROUP BY
    ss.ID_STATUS_SESSAO,
    ss.DESCRICAO
ORDER BY TOTAL DESC;

-- ============================================================
-- RELATÓRIO 12 - FORMAS DE PAGAMENTO
-- ============================================================

SELECT
    fp.DESCRICAO AS FORMA_PAGAMENTO,
    COUNT(sa.ID_SESSAO) AS QUANTIDADE,
    SUM(sa.VALOR_REAL_PAGO) AS TOTAL_ARRECADADO
FROM FORMA_PAGAMENTO fp
LEFT JOIN SESSAO_AGENDA sa
    ON fp.ID_FORMA_PAGAMENTO = sa.ID_FORMA_PAGAMENTO
GROUP BY
    fp.ID_FORMA_PAGAMENTO,
    fp.DESCRICAO
ORDER BY TOTAL_ARRECADADO DESC;