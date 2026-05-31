USE clinica_fisioterapia;

INSERT INTO DOMINIO_SEXO (DESCRICAO) VALUES
    ('Masculino'),
    ('Feminino'),
    ('Outro');

INSERT INTO TIPO_EXAME (NOME_TIPO) VALUES
    ('Raio-X'),
    ('Ressonância Magnética'),
    ('Ultrassom'),
    ('Tomografia Computadorizada'),
    ('Eletroneuromiografia');

INSERT INTO TIPO_PLANO (DESCRICAO) VALUES
    ('Básico'),
    ('Intermediário'),
    ('Premium'),
    ('Empresarial');

INSERT INTO ESPECIALIDADE (NOME_ESPECIALIDADE) VALUES
    ('Ortopedia e Traumatologia'),
    ('Neurologia'),
    ('Cardiorrespiratória'),
    ('Geriatria'),
    ('Esportiva'),
    ('Pediatria');

INSERT INTO FORMA_PAGAMENTO (DESCRICAO) VALUES
    ('Dinheiro'),
    ('Cartão de Débito'),
    ('Cartão de Crédito'),
    ('Pix'),
    ('Plano de Saúde'),
    ('Transferência Bancária');

INSERT INTO STATUS_SESSAO (DESCRICAO) VALUES
    ('Agendada'),
    ('Confirmada'),
    ('Em Andamento'),
    ('Concluída'),
    ('Cancelada'),
    ('Falta');

INSERT INTO PROCEDIMENTO (NOME_PROCEDIMENTO, VALOR_PADRAO) VALUES
    ('Cinesioterapia',                   120.00),
    ('Eletroterapia (TENS/FES)',          100.00),
    ('Ultrassom Terapêutico',            110.00),
    ('Laser Terapêutico',                130.00),
    ('Pilates Terapêutico',              150.00),
    ('Bandagem Funcional',                80.00),
    ('Drenagem Linfática Manual',        140.00),
    ('RPG - Reeducação Postural Global', 160.00);

INSERT INTO PLANO_SAUDE (NOME_PLANO, ID_TIPO_PLANO) VALUES
    ('Unimed',                1),
    ('Bradesco Saúde',        3),
    ('Amil',                  2),
    ('SulAmérica',            2),
    ('Hapvida',               1),
    ('NotreDame Intermédica', 2);

INSERT INTO PACIENTE (NOME_COMPLETO, DATA_NASCIMENTO, ID_SEXO, DIAGNOSTICO_INICIAL, INDICACAO_TRATAMENTO) VALUES
    ('Ana Clara Mendes',       '1985-03-12', 2, 'Lombalgia crônica',                   'Reabilitação postural'),
    ('Carlos Eduardo Lima',    '1978-07-25', 1, 'LCA rompido pós-cirúrgico',           'Reabilitação ortopédica'),
    ('Mariana Souza Ferreira', '1992-11-08', 2, 'Cervicalgia tensional',               'Fisioterapia manual'),
    ('Roberto Alves Costa',    '1965-04-30', 1, 'AVC isquêmico - hemiplegia esquerda','Reabilitação neurológica'),
    ('Juliana Carvalho Ramos', '2001-09-17', 2, 'Tendinite do manguito rotador',       'Reabilitação esportiva');

INSERT INTO ENDERECO_PACIENTE (ID_PACIENTE, LOGRADOURO, NUMERO, COMPLEMENTO, BAIRRO, CIDADE, ESTADO, CEP) VALUES
    (1, 'Rua das Flores',       '123',  'Apto 45',    'Jardim Paulista', 'São Paulo',      'SP', '01427001'),
    (2, 'Avenida Brasil',       '456',  NULL,          'Centro',          'Campinas',       'SP', '13010111'),
    (3, 'Rua Sete de Setembro', '789',  'Casa',        'Vila Nova',       'Ribeirão Preto', 'SP', '14010080'),
    (4, 'Rua XV de Novembro',   '321',  'Sala 2',      'Santa Cruz',      'Santo André',    'SP', '09010010'),
    (5, 'Avenida Paulista',     '1000', 'Conjunto 34', 'Bela Vista',      'São Paulo',      'SP', '01310100');

INSERT INTO TELEFONE_PACIENTE (ID_PACIENTE, NUMERO, EH_WHATSAPP) VALUES
    (1, '(11) 99123-4567', 1),
    (1, '(11) 3456-7890',  0),
    (2, '(19) 98765-4321', 1),
    (3, '(16) 99234-5678', 1),
    (4, '(11) 97654-3210', 1),
    (5, '(11) 96543-2109', 1);

INSERT INTO FISIOTERAPEUTA (NOME, ID_ESPECIALIDADE, TELEFONE, EMAIL, AGENDA_TRABALHO) VALUES
    ('Dra. Beatriz Oliveira Santos', 1, '(11) 93456-7890', 'beatriz.santos@clinica.com',   'Segunda a Sexta, 08h-17h'),
    ('Dr. Fernando Gomes Prado',     2, '(11) 94567-8901', 'fernando.gomes@clinica.com',   'Segunda a Sexta, 09h-18h'),
    ('Dra. Camila Rodrigues Lima',   5, '(11) 95678-9012', 'camila.rodrigues@clinica.com', 'Terca e Quinta, 07h-16h');

INSERT INTO SESSAO_AGENDA
    (ID_PACIENTE, ID_FISIOTERAPEUTA, ID_PROCEDIMENTO, ID_PLANO,
     ID_STATUS_SESSAO, ID_FORMA_PAGAMENTO, DATA_SESSAO, HORA_SESSAO, VALOR_REAL_PAGO)
VALUES
    (1, 1, 1,    1, 4, 5,    '2025-04-07', '09:00:00', NULL),
    (1, 1, 3,    1, 4, 5,    '2025-04-14', '09:00:00', NULL),
    (2, 1, 2,    2, 4, 5,    '2025-04-08', '10:30:00', NULL),
    (2, 1, 1,    2, 1, NULL, '2025-05-05', '10:30:00', NULL),
    (3, 3, 5, NULL, 4, 2,    '2025-04-09', '14:00:00', 150.00),
    (3, 3, 4, NULL, 4, 4,    '2025-04-16', '14:00:00', 130.00),
    (4, 2, 1,    3, 4, 5,    '2025-04-10', '11:00:00', NULL),
    (5, 3, 6, NULL, 4, 3,    '2025-04-11', '15:30:00', 80.00);

INSERT INTO AVALIACAO
    (ID_PACIENTE, ID_FISIOTERAPEUTA, DATA_AVALIACAO, DESCRICAO_AVALIACAO, PROGRESSO_PERCENTUAL, RECOMENDACAO)
VALUES
    (1, 1, '2025-04-01',
     'Dor lombar moderada (EVA 6). Mobilidade reduzida em flexão. Postura anteriorizada.',
     0,
     'Iniciar cinesioterapia com fortalecimento de core. Retorno em 15 dias.'),
    (1, 1, '2025-04-15',
     'Melhora significativa na dor (EVA 3). Amplitude de movimento aumentada.',
     40,
     'Continuar protocolo. Incluir alongamentos diários em casa.'),
    (2, 1, '2025-04-03',
     'Pos-cirurgico LCA - 6 semanas. Edema leve. Forca muscular reduzida.',
     0,
     'Protocolo RICE + inicio de fortalecimento isometrico do quadriceps.'),
    (4, 2, '2025-04-05',
     'Hemiplegia esquerda. Grau de espasticidade 2 na escala de Ashworth.',
     0,
     'Estimulacao neuromuscular + treino de marcha com assistencia.');

INSERT INTO EXAME (ID_PACIENTE, ID_TIPO_EXAME, DATA_EXAME, RESULTADO_LAUDO, CAMINHO_IMAGEM) VALUES
    (1, 2, '2025-03-20',
     'Protrusao discal em L4-L5 e L5-S1. Sem compressao radicular significativa.',
     'exames/ana_clara_rm_20250320.pdf'),
    (2, 2, '2025-03-15',
     'Ruptura parcial do LCA confirmada. Edema articular presente.',
     'exames/carlos_rm_20250315.pdf'),
    (3, 1, '2025-04-02',
     'Sem alteracoes osseas. Espacos discais preservados.',
     'exames/mariana_rx_20250402.pdf'),
    (4, 4, '2025-03-28',
     'Infarto isquemico em territorio da arteria cerebral media esquerda. Fase cronica.',
     'exames/roberto_tc_20250328.pdf'),
    (5, 3, '2025-04-04',
     'Espessamento tendineo do supraespinhoso. Bursite subacromial leve.',
     'exames/juliana_us_20250404.pdf');
