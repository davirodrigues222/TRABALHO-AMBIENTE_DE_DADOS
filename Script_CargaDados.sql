USE clinica_fisioterapia;

-- (segurança caso rode novamente)
SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE EXAME;
TRUNCATE TABLE AVALIACAO;
TRUNCATE TABLE SESSAO;
TRUNCATE TABLE PACIENTE;
TRUNCATE TABLE PROCEDIMENTO;
TRUNCATE TABLE PLANO_SAUDE;
TRUNCATE TABLE FISIOTERAPEUTA;

SET FOREIGN_KEY_CHECKS = 1;

-- =========================
-- FISIOTERAPEUTAS
-- =========================
INSERT INTO FISIOTERAPEUTA (NOME, ESPECIALIDADE, TELEFONE, EMAIL, AGENDA_TRABALHO) VALUES 
('Dra. Alice Moraes', 'Traumato-Ortopedia', '85991234567', 'alice@clinica.com', 'Seg a Sex 08h-13h'),
('Dr. Roberto Santos', 'Fisioterapia Esportiva', '85997654321', 'roberto@clinica.com', 'Seg/Qua/Sex 14h-19h'),
('Dra. Carla Souza', 'Pilates Clínico', '85992334455', 'carla@clinica.com', 'Ter/Qui 08h-18h');

-- =========================
-- PLANOS
-- =========================
INSERT INTO PLANO_SAUDE (NOME_PLANO, TIPO_PLANO) VALUES 
('Unimed Fortaleza', 'Convênio'),
('Bradesco Saúde', 'Convênio'),
('Particular', 'Particular');

-- =========================
-- PROCEDIMENTOS
-- =========================
INSERT INTO PROCEDIMENTO (NOME_PROCEDIMENTO, DESCRICAO, VALOR_PADRAO) VALUES 
('Fisioterapia Convencional', 'Sessão padrão', 90.00),
('Pilates Clínico', 'Exercícios terapêuticos', 120.00),
('Reabilitação Funcional', 'Pós-lesão/cirurgia', 150.00);

-- =========================
-- PACIENTES
-- =========================
INSERT INTO PACIENTE (NOME_COMPLETO, DATA_NASCIMENTO, SEXO, ENDERECO, TELEFONE_PACIENTE, DIAGNOSTICO_INICIAL, INDICACAO_TRATAMENTO) VALUES 
('Carlos Henrique Silva', '1984-05-12', 'M', 'Meireles', '85988112233', 'LCA joelho', 'Reabilitação funcional'),
('Maria Eduarda Lima', '1998-11-23', 'F', 'Edson Queiroz', '85987776655', 'Escoliose', 'Pilates'),
('Marcos Antônio Pereira', '1965-02-28', 'M', 'Varjota', '85999221100', 'Tendinite ombro', 'Fisioterapia');

-- =========================
-- SESSÕES
-- =========================
INSERT INTO SESSAO 
(DATA_SESSAO, VALOR_PROCEDIMENTO, MODALIDADE_PAGAMENTO, PAGO, ID_PACIENTE, ID_FISIOTERAPEUTA, ID_PROCEDIMENTO, ID_PLANO) VALUES 
('2026-05-25 09:00:00', 150.00, 'Convênio', 0, 1, 2, 3, 1),
('2026-05-27 09:00:00', 150.00, 'Convênio', 0, 1, 2, 3, 1),
('2026-05-26 10:00:00', 120.00, 'PIX', 1, 2, 3, 2, 3),
('2026-05-25 14:00:00', 90.00, 'Convênio', 1, 3, 1, 1, 2);

-- =========================
-- AVALIAÇÕES
-- =========================
INSERT INTO AVALIACAO (ID_PACIENTE, ID_FISIOTERAPEUTA, DATA_AVALIACAO, AVALIACAO, PROGRESSO_PERCENTUAL, RECOMENDACAO) VALUES 
(1, 2, '2026-05-01', 'Boa evolução joelho', 40, 'Fortalecimento'),
(2, 3, '2026-05-10', 'Melhora lombar', 50, 'Manter Pilates'),
(3, 1, '2026-05-12', 'Melhora parcial ombro', 30, 'Continuar terapia');

-- =========================
-- EXAMES
-- =========================
INSERT INTO EXAME (ID_PACIENTE, TIPO_EXAME, DATA_EXAME, RESULTADO_LAUDO, IMAGEM_EXAME) VALUES 
(1, 'RM Joelho', '2026-04-15', 'Pós-operatório OK', '/docs/rm1.pdf'),
(2, 'RX Coluna', '2026-04-20', 'Escoliose leve', '/docs/rx2.pdf'),
(3, 'US Ombro', '2026-04-25', 'Tendinite leve', '/docs/us3.pdf');