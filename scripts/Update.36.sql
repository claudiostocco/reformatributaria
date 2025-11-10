UPDATE VERSAO SET DFE = 20X, ID = 36;

INSERT INTO CFG (TMCODIGO, TIPO, NOME, PROPRIETARIO, NIVEL, VALOR, DESCRICAO, VALIDA) VALUES (0, 'TRIBUTO', 'ALIQUOTA CBS', 0, '2', '0', 'Aliquota do CBS, definda no ambito nacional', '<N4,2>');
INSERT INTO CFG (TMCODIGO, TIPO, NOME, PROPRIETARIO, NIVEL, VALOR, DESCRICAO, VALIDA) VALUES (0, 'TRIBUTO', 'ALIQUOTA IBS MUNICIPIO', 0, '2', '0', 'Aliquota do IBS padrão para o municipio, definda no ambito nacional', '<N4,2>');

ALTER TABLE ESTADO ADD TXALIQUOTAIBS NUMERIC(4,2) DEFAULT 0;
ALTER TABLE MUNICIPIO ADD TXALIQUOTAIBS NUMERIC(4,2) DEFAULT 0;
UPDATE ESTADO SET TXALIQUOTAIBS = 0.1;

ALTER TABLE PRODUTO ADD CLASTRIBIBSCBS CHAR(6) DEFAULT '000000';

ALTER TABLE CTRC ADD CLASTRIBIBSCBS CHAR(6) DEFAULT '000000',
                 ADD TXIBSUF NUMERIC(9,4) DEFAULT 0,
                 ADD TXIBSMUN NUMERIC(9,4) DEFAULT 0,
                 ADD TXCBS NUMERIC(9,4) DEFAULT 0;

CREATE TABLE CTRCDFE (
    ID            INTEGER DEFAULT 0 NOT NULL,
    ENTEGOV       SMALLINT DEFAULT 0,
    TXREDUTORGOV  NUMERIC(9,4) DEFAULT 0,
    OPERACAOGOV   SMALLINT DEFAULT 0,
    CONSTRAINT CTRCDFEPK PRIMARY KEY (ID)
);

CREATE TABLE CLASSTRIB (
    ID                CHAR(6) DEFAULT '000000' NOT NULL,
    DESCRICAO         VARCHAR(180),
    TXREDIBS          NUMERIC(9,4) DEFAULT 0,
    TXREDCBS          NUMERIC(9,4) DEFAULT 0,
    REDUCAOBC         CHAR(1) DEFAULT 'N',
    TRIBREGULAR       CHAR(1) DEFAULT 'N',
    CREDITOPRESUMIDO  CHAR(1) DEFAULT 'N',
    ESTORNOCREDITO    CHAR(1) DEFAULT 'N',
    TIPOALIQUOTA      VARCHAR(40),
    DFEASSOCIADO      VARCHAR(120),
    ANEXO             SMALLINT DEFAULT 0,
    CONSTRAINT CLASSTRIBPK PRIMARY KEY (ID)
);

CREATE TABLE CSTIBSCBS (
    ID                   CHAR(3) DEFAULT '000' NOT NULL,
    DESCRICAO            VARCHAR(50),
    TRIBUTACAO           CHAR(1) DEFAULT 'N',
    REDUCAO              CHAR(1) DEFAULT 'N',
    TRANSFCREDITO        CHAR(1) DEFAULT 'N',
    DIFERIMENTO          CHAR(1) DEFAULT 'N',
    MONOFASICA           CHAR(1) DEFAULT 'N',
    CREDITOPRESUMIDOZFM  CHAR(1) DEFAULT 'N',
    AJUSTECREDITO        CHAR(1) DEFAULT 'N',
    CONSTRAINT CSTIBSCBSPK PRIMARY KEY (ID)
);

INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('000001', 'SituaÃ§Ãµes tributadas integralmente pelo IBS e CBS.', 0, 0, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFe,NFCe,CTe,CTeOS,BPe,NF3e,NFCom,NFSE,BPeTM,BPeTA,NFAg,NFGas', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('010002', 'OperaÃ§Ãµes do serviÃ§o financeiro', 0, 0, 'N', 'N', 'N', 'N', 'Uniforme Setorial', 'DERE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('011003', 'IntermediaÃ§Ã£o de planos de assistÃªncia Ã  saÃºde, observado o art. 240 da Lei Complementar nÂº 214, de 2025.', 60, 60, 'N', 'N', 'N', 'N', 'Uniforme Nacional', 'NFSE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200004', 'Venda de dispositivos mÃ©dicos com a especificaÃ§Ã£o das respectivas classificaÃ§Ãµes da NCM/SH previstas no Anexo XII da Lei Complementar nÂº 214, de 2025, observado o art. 144 da', 100, 100, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFe,NFCe,NFSE', 12);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('000002', 'ExploraÃ§Ã£o de via, observado o art. 11 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFSVIA', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('000003', 'Regime automotivo - projetos incentivados, observado o art. 311 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'N', 'S', 'N', 'PadrÃ£o', 'NFe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('000004', 'Regime automotivo - projetos incentivados, observado o art. 312 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'N', 'S', 'N', 'PadrÃ£o', 'NFe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('010001', 'OperaÃ§Ãµes do FGTS nÃ£o realizadas pela Caixa EconÃ´mica Federal, observado o art. 212 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'N', 'N', 'N', 'Uniforme Setorial', 'NFSE,DERE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('011001', 'Planos de assistÃªncia funerÃ¡ria, observado o art. 236 da Lei Complementar nÂº 214, de 2025.', 60, 60, 'N', 'N', 'N', 'N', 'Uniforme Nacional', 'DERE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('011002', 'Planos de assistÃªncia Ã  saÃºde, observado o art. 237 da Lei Complementar nÂº 214, de 2025.', 60, 60, 'N', 'N', 'N', 'N', 'Uniforme Nacional', 'DERE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('011004', 'Concursos e prognÃ³sticos, observado o art. 246 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'N', 'N', 'N', 'Uniforme Nacional', 'DERE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('011005', 'Planos de assistÃªncia Ã  saÃºde de animais domÃ©sticos, observado o art. 243 da Lei Complementar nÂº 214, de 2025.', 30, 30, 'N', 'N', 'N', 'N', 'Uniforme Nacional', 'DERE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200001', 'AquisiÃ§Ãµes de mÃ¡quinas, de aparelhos, de instrumentos, de equipamentos, de matÃ©rias-primas, de produtos intermediÃ¡rios e de materiais de embalagem realizadas entre empresas au', 100, 100, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFe,NFSE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200002', 'Fornecimento ou importaÃ§Ã£o de tratores, mÃ¡quinas e implementos agrÃ­colas, destinados a produtor rural nÃ£o contribuinte, e de veÃ­culos de transporte de carga destinados a tran', 100, 100, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFe,NFCe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200003', 'Vendas de produtos destinados Ã  alimentaÃ§Ã£o humana relacionados no Anexo I da Lei Complementar nÂº 214, de 2025, com a especificaÃ§Ã£o das respectivas classificaÃ§Ãµes da NCM/SH', 100, 100, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFe,NFCe', 1);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200005', 'Venda de dispositivos mÃ©dicos com a especificaÃ§Ã£o das respectivas classificaÃ§Ãµes da NCM/SH previstas no Anexo IV da Lei Complementar nÂº 214, de 2025, quando adquiridos por Ã³', 100, 100, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFe,NFSE', 4);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200006', 'SituaÃ§Ã£o de emergÃªncia de saÃºde pÃºblica reconhecida pelo Poder Legislativo federal, estadual, distrital ou municipal competente, ato conjunto do Ministro da Fazenda e do Comit', 100, 100, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFe,NFCe,NFSE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200007', 'Fornecimento dos dispositivos de acessibilidade prÃ³prios para pessoas com deficiÃªncia relacionados no Anexo XIII da Lei Complementar nÂº 214, de 2025, com a especificaÃ§Ã£o das r', 100, 100, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFe,NFCe,NFSE', 13);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200008', 'Fornecimento dos dispositivos de acessibilidade prÃ³prios para pessoas com deficiÃªncia relacionados no Anexo V da Lei Complementar nÂº 214, de 2025, com a especificaÃ§Ã£o das resp', 100, 100, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFe,NFSE', 5);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200009', 'Fornecimento dos medicamentos relacionados no Anexo XIV da Lei Complementar nÂº 214, de 2025, com a especificaÃ§Ã£o das respectivas classificaÃ§Ãµes da NCM/SH, observado o art. 146', 100, 100, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFe,NFCe', 14);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200010', 'Fornecimento dos medicamentos registrados na Anvisa, quando adquiridos por Ã³rgÃ£os da administraÃ§Ã£o pÃºblica direta, autarquias, fundaÃ§Ãµes pÃºblicas e entidades imunes, observ', 100, 100, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFe,NFCe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200011', 'Fornecimento das composiÃ§Ãµes para nutriÃ§Ã£o enteral e parenteral, composiÃ§Ãµes especiais e fÃ³rmulas nutricionais destinadas Ã s pessoas com erros inatos do metabolismo relacio', 100, 100, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFe', 6);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200012', 'SituaÃ§Ã£o de emergÃªncia de saÃºde pÃºblica reconhecida pelo Poder Legislativo federal, estadual, distrital ou municipal competente, ato conjunto do Ministro da Fazenda e do Comit', 100, 100, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFe,NFCe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200013', 'Fornecimento de tampÃµes higiÃªnicos, absorventes higiÃªnicos internos ou externos, descartÃ¡veis ou reutilizÃ¡veis, calcinhas absorventes e coletores menstruais, observado o art. ', 100, 100, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFe,NFCe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200014', 'Fornecimento dos produtos hortÃ­colas, frutas e ovos, relacionados no Anexo XV da Lei Complementar nÂº 214 , de 2025, com a especificaÃ§Ã£o das respectivas classificaÃ§Ãµes da NCM/', 100, 100, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFe,NFCe', 15);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200015', 'Venda de automÃ³veis de passageiros de fabricaÃ§Ã£o nacional de, no mÃ­nimo, 4 (quatro) portas, inclusive a de acesso ao bagageiro, quando adquiridos por motoristas profissionais q', 100, 100, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFe,NFCe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200016', 'PrestaÃ§Ã£o de serviÃ§os de pesquisa e desenvolvimento por InstituiÃ§Ã£o CientÃ­fica, TecnolÃ³gica e de InovaÃ§Ã£o (ICT) sem fins lucrativos para a administraÃ§Ã£o pÃºblica direta,', 100, 100, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFSE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200017', 'OperaÃ§Ãµes relacionadas ao FGTS, considerando aquelas necessÃ¡rias Ã  aplicaÃ§Ã£o da Lei nÂº 8.036, de 1990, realizadas pelo Conselho Curador ou Secretaria Executiva do FGTS, obse', 100, 100, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFSE,DERE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200018', 'OperaÃ§Ãµes de resseguro e retrocessÃ£o ficam sujeitas Ã  incidÃªncia Ã  alÃ­quota zero, inclusive quando os prÃªmios de resseguro e retrocessÃ£o forem cedidos ao exterior, observa', 100, 100, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'DERE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200019', 'Importador dos serviÃ§os financeiros seja contribuinte que realize as operaÃ§Ãµes de que tratam os incisos I a V do caput do art. 182, serÃ¡ aplicada alÃ­quota zero na importaÃ§Ã£o', 100, 100, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'DERE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200020', 'OperaÃ§Ã£o praticada por sociedades cooperativas optantes por regime especÃ­fico do IBS e CBS, quando o associado destinar bem ou serviÃ§o Ã  cooperativa de que participa, e a coop', 100, 100, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFe,NFCe,NFSE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200021', 'ServiÃ§os de transporte pÃºblico coletivo de passageiros ferroviÃ¡rio e hidroviÃ¡rio urbanos, semiurbanos e metropolitanos, observado o art. 285 da Lei Complementar nÂº 214, de 202', 100, 100, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFSE,BPeTM', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200022', 'OperaÃ§Ã£o originada fora da Zona Franca de Manaus que destine bem material industrializado de origem nacional a contribuinte estabelecido na Zona Franca de Manaus que seja habilit', 100, 100, 'N', 'S', 'N', 'N', 'PadrÃ£o', 'NFe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200023', 'OperaÃ§Ã£o realizada por indÃºstria incentivada que destine bem material intermediÃ¡rio para outra indÃºstria incentivada na Zona Franca de Manaus, desde que a entrega ou disponibi', 100, 100, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200024', 'OperaÃ§Ã£o originada fora das Ãreas de Livre ComÃ©rcio que destine bem material industrializado de origem nacional a contribuinte estabelecido nas Ãreas de Livre ComÃ©rcio que se', 100, 100, 'N', 'S', 'N', 'N', 'PadrÃ£o', 'NFe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200025', 'Fornecimento dos serviÃ§os de educaÃ§Ã£o relacionados ao Programa Universidade para Todos (Prouni), instituÃ­do pela Lei nÂº 11.096, de 13 de janeiro de 2005, observado o art. 308 ', 60, 100, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFSE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200026', 'LocaÃ§Ã£o de imÃ³veis localizados nas zonas reabilitadas, pelo prazo de 5 (cinco) anos, contado da data de expediÃ§Ã£o do habite-se, e relacionados a projetos de reabilitaÃ§Ã£o urb', 80, 80, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFSE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200027', 'OperaÃ§Ãµes de locaÃ§Ã£o, cessÃ£o onerosa e arrendamento de bens imÃ³veis, observado o art. 261 da Lei Complementar nÂº 214, de 2025.', 70, 70, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFSE,NFABI', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200028', 'Fornecimento dos serviÃ§os de educaÃ§Ã£o relacionados no Anexo II da Lei Complementar nÂº 214, de 2025, com a especificaÃ§Ã£o das respectivas classificaÃ§Ãµes da Nomenclatura Brasi', 60, 60, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFSE', 2);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200029', 'Fornecimento dos serviÃ§os de saÃºde humana relacionados no Anexo III da Lei Complementar nÂº 214, de 2025, com a especificaÃ§Ã£o das respectivas classificaÃ§Ãµes da NBS, observado', 60, 60, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFSE', 3);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200030', 'Venda dos dispositivos mÃ©dicos relacionados no Anexo IV da Lei Complementar nÂº 214, de 2025, com a especificaÃ§Ã£o das respectivas classificaÃ§Ãµes da NCM/SH, observado o art. 13', 60, 60, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFe,NFCe,NFSE', 4);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200031', 'Fornecimento dos dispositivos de acessibilidade prÃ³prios para pessoas com deficiÃªncia relacionados no Anexo V da Lei Complementar nÂº 214, de 2025, com a especificaÃ§Ã£o das resp', 60, 60, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFe,NFCe,NFSE', 5);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200032', 'Fornecimento dos medicamentos registrados na Anvisa ou produzidos por farmÃ¡cias de manipulaÃ§Ã£o, ressalvados os medicamentos sujeitos Ã  alÃ­quota zero de que trata o art. 141 da', 60, 60, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFe,NFCe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200033', 'Fornecimento das composiÃ§Ãµes para nutriÃ§Ã£o enteral e parenteral, composiÃ§Ãµes especiais e fÃ³rmulas nutricionais destinadas Ã s pessoas com erros inatos do metabolismo relacio', 60, 60, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFe,NFCe', 6);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200034', 'Fornecimento dos alimentos destinados ao consumo humano relacionados no Anexo VII da Lei Complementar nÂº 214, de 2025, com a especificaÃ§Ã£o das respectivas classificaÃ§Ãµes da NC', 60, 60, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFe,NFCe', 7);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200035', 'Fornecimento dos produtos de higiene pessoal e limpeza relacionados no Anexo VIII da Lei Complementar nÂº 214, de 2025, com a especificaÃ§Ã£o das respectivas classificaÃ§Ãµes da NC', 60, 60, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFe,NFCe', 8);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200036', 'Fornecimento de produtos agropecuÃ¡rios, aquÃ­colas, pesqueiros, florestais e extrativistas vegetais in natura, observado o art. 137 da Lei Complementar nÂº 214, de 2025.', 60, 60, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFe,NFCe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200037', 'Fornecimento de serviÃ§os ambientais de conservaÃ§Ã£o ou recuperaÃ§Ã£o da vegetaÃ§Ã£o nativa, mesmo que fornecidos sob a forma de manejo sustentÃ¡vel de sistemas agrÃ­colas, agrofl', 60, 60, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFSE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200038', 'Fornecimento dos insumos agropecuÃ¡rios e aquÃ­colas relacionados no Anexo IX da Lei Complementar nÂº 214, de 2025, com a especificaÃ§Ã£o das respectivas classificaÃ§Ãµes da NCM/SH', 60, 60, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFe,NFCe,NFSE', 9);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200039', 'Fornecimento dos serviÃ§os e o licenciamento ou cessÃ£o dos direitos relacionados no Anexo X da Lei Complementar nÂº 214, de 2025, com a especificaÃ§Ã£o das respectivas classificaÃ', 60, 60, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFe,NFSE', 10);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200040', 'Fornec dos seguintes serv de comunic instit Ã  admin pÃºb direta, autarq e fund pÃºb: serviÃ§os direcionados ao planej, criaÃ§Ã£o, programaÃ§Ã£o e manutenÃ§Ã£o de pÃ¡ginas eletrÃ´n', 60, 60, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFSE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200041', 'OperaÃ§Ãµes relacionadas Ã s seguintes atividades desportivas: fornecimento de serviÃ§o de educaÃ§Ã£o desportiva, classificado no cÃ³digo 1.2205.12.00 da NBS, e gestÃ£o e exploraÃ§', 60, 60, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFSE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200042', 'OperaÃ§Ãµes relacionadas ao fornecimento de serviÃ§o de educaÃ§Ã£o desportiva, classificado no cÃ³digo 1.2205.12.00 da NBS, observado o art. 141 da Lei Complementar nÂº 214, de 202', 60, 60, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFSE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200043', 'Fornecimento Ã  administraÃ§Ã£o pÃºblica direta, autarquias e fundaÃ§Ãµes pÃºbicas dos serviÃ§os e dos bens relativos Ã  soberania e Ã  seguranÃ§a nacional, Ã  seguranÃ§a da inform', 60, 60, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFe,NFSE', 11);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200044', 'OperaÃ§Ãµes e prestaÃ§Ãµes de serviÃ§os de seguranÃ§a da informaÃ§Ã£o e seguranÃ§a cibernÃ©tica desenvolvidos por sociedade que tenha sÃ³cio brasileiro com o mÃ­nimo de 20% (vinte ', 60, 60, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFe,NFCe,NFSE', 11);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200045', 'OperaÃ§Ãµes relacionadas a projetos de reabilitaÃ§Ã£o urbana de zonas histÃ³ricas e de Ã¡reas crÃ­ticas de recuperaÃ§Ã£o e reconversÃ£o urbanÃ­stica dos MunicÃ­pios ou do Distrito ', 60, 60, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFSE,NFABI', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200046', 'OperaÃ§Ãµes com bens imÃ³veis, observado o art. 261 da Lei Complementar nÂº 214, de 2025.', 50, 50, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFSE,NFABI', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200047', 'Bares e Restaurantes, observado o art. 275 da Lei Complementar nÂº 214, de 2025.', 40, 40, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFe,NFCe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200048', 'Hotelaria, Parques de DiversÃ£o e Parques TemÃ¡ticos, observado o art. 281 da Lei Complementar nÂº 214, de 2025.', 40, 40, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFSE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200049', 'Transporte coletivo de passageiros rodoviÃ¡rio, ferroviÃ¡rio e hidroviÃ¡rio intermunicipais e interestaduais, observado o art. 286 da Lei Complementar nÂº 214, de 2025.', 40, 40, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'BPe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200050', 'ServiÃ§os de transporte aÃ©reo regional coletivo de passageiros ou de carga, observado o art. 287 da Lei Complementar nÂº 214, de 2025.', 40, 40, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'CTe,BPeTA', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200051', 'AgÃªncias de Turismo, observado o art. 289 da Lei Complementar nÂº 214, de 2025.', 40, 40, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFSE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('200052', 'PrestaÃ§Ã£o de serviÃ§os das seguintes profissÃµes intelectuais de natureza cientÃ­fica, literÃ¡ria ou artÃ­stica, submetidas Ã  fiscalizaÃ§Ã£o por conselho profissional: administr', 30, 30, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFSE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('220001', 'IncorporaÃ§Ã£o imobiliÃ¡ria submetida ao regime especial de tributaÃ§Ã£o, observado o art. 485 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'N', 'N', 'N', 'Fixa', 'NFABI', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('220002', 'IncorporaÃ§Ã£o imobiliÃ¡ria submetida ao regime especial de tributaÃ§Ã£o, observado o art. 485 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'N', 'N', 'N', 'Fixa', 'NFABI', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('220003', 'AlienaÃ§Ã£o de imÃ³vel decorrente de parcelamento do solo, observado o art. 486 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'N', 'N', 'N', 'Fixa', 'NFABI', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('221001', 'LocaÃ§Ã£o, cessÃ£o onerosa ou arrendamento de bem imÃ³vel com alÃ­quota sobre a receita bruta, observado o art. 487 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'N', 'N', 'N', 'Fixa', 'NFSE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('222001', 'Transporte internacional de passageiros, caso os trechos de ida e volta sejam vendidos em conjunto, a base de cÃ¡lculo serÃ¡ a metade do valor cobrado, observado o Art. 12 Â§ 8Âº d', 0, 0, 'S', 'N', 'N', 'N', 'PadrÃ£o', 'BPe,BPeTA', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('400001', 'Fornecimento de serviÃ§os de transporte pÃºblico coletivo de passageiros rodoviÃ¡rio e metroviÃ¡rio de carÃ¡ter urbano, semiurbano e metropolitano, sob regime de autorizaÃ§Ã£o, per', 0, 0, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'BPe,NFSE,BPeTM', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('410001', 'Fornecimento de bonificaÃ§Ãµes quando constem do respectivo documento fiscal e que nÃ£o dependam de evento posterior, observado o art. 5Âº da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'N', 'N', 'N', 'Sem AlÃ­quota', 'NFe,NFCe,CTe,CTeOS,BPe,NF3e,NFCom,NFSE,BPeTM,BPeTA,NFABI', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('410002', 'TransferÃªncias entre estabelecimentos pertencentes ao mesmo contribuinte, observado o art. 6Âº da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'N', 'N', 'N', 'Sem AlÃ­quota', 'NFe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('410003', 'DoaÃ§Ãµes que nÃ£o tenham por objeto bens ou serviÃ§os que tenham permitido a apropriaÃ§Ã£o de crÃ©ditos pelo doador, observado o art. 6Âº da Lei Complementar nÂº 214, de 2025.
', 0, 0, 'N', 'N', 'N', 'N', 'Sem AlÃ­quota', 'NFe,NFCe,CTe,CTeOS,BPe,NF3e,NFCom,NFSE,BPeTM,BPeTA,NFAg,NFSVIA,NFABI,NFGas,DERE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('410004', 'ExportaÃ§Ãµes de bens e serviÃ§os, observado o art. 8Âº da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'N', 'N', 'N', 'Sem AlÃ­quota', 'NFe,CTe,CTeOS,BPe,NF3e,NFCom,NFSE,BPeTA', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('410005', 'Fornecimentos realizados pela UniÃ£o, pelos Estados, pelo Distrito Federal e pelos MunicÃ­pios, observado o art. 9Âº da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'N', 'N', 'N', 'Sem AlÃ­quota', 'NFe,NFCe,NFSE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('410006', 'Fornecimentos realizados por entidades religiosas e templos de qualquer culto, inclusive suas organizaÃ§Ãµes assistenciais e beneficentes, observado o art. 9Âº da Lei Complementar ', 0, 0, 'N', 'N', 'N', 'N', 'Sem AlÃ­quota', 'NFe,NFCe,NFSE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('410007', 'Fornecimentos realizados por partidos polÃ­ticos, inclusive suas fundaÃ§Ãµes, entidades sindicais dos trabalhadores e instituiÃ§Ãµes de educaÃ§Ã£o e de assistÃªncia social, sem fin', 0, 0, 'N', 'N', 'N', 'N', 'Sem AlÃ­quota', 'NFe,NFCe,NFSE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('410008', 'Fornecimentos de livros, jornais, periÃ³dicos e do papel destinado a sua impressÃ£o, observado o art. 9Âº da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'N', 'N', 'N', 'Sem AlÃ­quota', 'NFe,NFCe,NFCom,NFSE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('410009', 'Fornecimentos de fonogramas e videofonogramas musicais produzidos no Brasil contendo obras musicais ou literomusicais de autores brasileiros e/ou obras em geral interpretadas por a', 0, 0, 'N', 'N', 'N', 'N', 'Sem AlÃ­quota', 'NFe,NFCe,NFCom,NFSE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('410010', 'Fornecimentos de serviÃ§o de comunicaÃ§Ã£o nas modalidades de radiodifusÃ£o sonora e de sons e imagens de recepÃ§Ã£o livre e gratuita, observado o art. 9Âº da Lei Complementar nÂº ', 0, 0, 'N', 'N', 'N', 'N', 'Sem AlÃ­quota', 'NFCom,NFSE,DERE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('410011', 'Fornecimentos de ouro, quando definido em lei como ativo financeiro ou instrumento cambial, observado o art. 9Âº da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'N', 'N', 'N', 'Sem AlÃ­quota', '', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('410012', 'Fornecimento de condomÃ­nio edilÃ­cio nÃ£o optante pelo regime regular, observado o art. 26 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'N', 'N', 'N', 'Sem AlÃ­quota', 'NFe,NFCe,NFSE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('410013', 'ExportaÃ§Ãµes de combustÃ­veis, observado o art. 98 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'N', 'N', 'N', 'Sem AlÃ­quota', 'NFe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('410014', 'Fornecimento de produtor rural nÃ£o contribuinte, observado o art. 164 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'N', 'S', 'N', 'Sem AlÃ­quota', 'NFe,NFCe,NFSE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('410015', 'Fornecimento por transportador autÃ´nomo nÃ£o contribuinte, observado o art. 169 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'N', 'N', 'N', 'Sem AlÃ­quota', 'CTe,NFSE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('410016', 'Fornecimento ou aquisiÃ§Ã£o de resÃ­duos sÃ³lidos, observado o art. 170 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'N', 'S', 'N', 'Sem AlÃ­quota', 'NFe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('410017', 'AquisiÃ§Ã£o de bem mÃ³vel com crÃ©dito presumido sob condiÃ§Ã£o de revenda realizada, observado o art. 171 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'N', 'N', 'N', 'Sem AlÃ­quota', 'NFe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('410018', 'OperaÃ§Ãµes relacionadas aos fundos garantidores e executores de polÃ­ticas pÃºblicas, inclusive de habitaÃ§Ã£o, previstos em lei, assim entendidas os serviÃ§os prestados ao fundo ', 0, 0, 'N', 'N', 'N', 'N', 'Sem AlÃ­quota', 'NFABI,DERE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('410019', 'ExclusÃ£o da gorjeta na base de cÃ¡lculo no fornecimento de alimentaÃ§Ã£o, observado o art. 274 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'N', 'N', 'N', 'Sem AlÃ­quota', 'NFe,NFCe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('410020', 'ExclusÃ£o do valor de intermediaÃ§Ã£o na base de cÃ¡lculo no fornecimento de alimentaÃ§Ã£o, observado o art. 274 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'N', 'N', 'N', 'Sem AlÃ­quota', 'NFe,NFCe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('410021', 'ContribuiÃ§Ã£o de que trata o art. 149-A da ConstituiÃ§Ã£o Federal, observado o art. 12 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'N', 'N', 'N', 'Sem AlÃ­quota', 'NF3e', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('410022', 'ConsolidaÃ§Ã£o da propriedade pelo credor de bens mÃ³veis ou imÃ³veis que tenham sido objeto de garantia, observado o art. 200 da Lei Complementar nÂº 214, de 2025.
', 0, 0, 'N', 'N', 'N', 'N', 'Sem AlÃ­quota', 'NFABI', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('410023', 'AlienaÃ§Ã£o de bens mÃ³veis ou imÃ³veis que tenham sido objeto de garantia constituÃ­da em favor de credor em que o prestador da garantia nÃ£o seja contribuinte, observado o art. 2', 0, 0, 'N', 'N', 'N', 'N', 'Sem AlÃ­quota', 'NFABI', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('410024', 'ConsolidaÃ§Ã£o da propriedade pelo grupo de consÃ³rcio de bem que tenha sido objeto de garantia, observado o art. 204 da Lei Complementar nÂº 214, de 2025.
', 0, 0, 'N', 'N', 'N', 'N', 'Sem AlÃ­quota', 'NFABI', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('410025', 'AlienaÃ§Ã£o de bem que tenha sido objeto de garantia constituÃ­da em favor do grupo de consÃ³rcio em que o prestador da garantia nÃ£o seja contribuinte, observado o art. 204 da Lei', 0, 0, 'N', 'N', 'N', 'N', 'Sem AlÃ­quota', 'NFABI', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('410026', 'DoaÃ§Ãµes sem contraprestaÃ§Ã£o em benefÃ­cio do doador, com anulaÃ§Ã£o de crÃ©dito apropriados pelo doador referente ao fornecimento doado, observado o art. 6Âº da Lei Complementa', 0, 0, 'N', 'N', 'N', 'S', 'Sem AlÃ­quota', 'NFe,NFCe,CTe,CTeOS,BPe,NF3e,NFCom,NFSE,BPeTM,BPeTA,NFAg,NFSVIA,NFABI,NFGas', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('410999', 'OperaÃ§Ãµes nÃ£o onerosas sem previsÃ£o de tributaÃ§Ã£o, nÃ£o especificadas anteriormente, observado o art. 4Âº da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'N', 'N', 'N', 'Sem AlÃ­quota', 'NFe,NFCe,CTe,CTeOS,BPe,NF3e,NFCom,NFSE,BPeTM,BPeTA,NFAg,NFABI,NFGas', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('510001', 'OperaÃ§Ãµes, sujeitas a diferimento, com energia elÃ©trica ou com direitos a ela relacionados, relativas Ã  geraÃ§Ã£o, comercializaÃ§Ã£o, distribuiÃ§Ã£o e transmissÃ£o, observado o', 0, 0, 'N', 'N', 'N', 'N', 'Sem AlÃ­quota', 'NFe,NF3e', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('515001', 'OperaÃ§Ãµes, sujeitas a diferimento, com insumos agropecuÃ¡rios e aquÃ­colas destinados a produtor rural nÃ£o contribuinte, observado o art. 138 da Lei Complementar nÂº 214, de 202', 60, 60, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFe,NFSE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('550001', 'ExportaÃ§Ãµes de bens materiais, observado o art. 82 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'S', 'N', 'N', 'Sem AlÃ­quota', 'NFe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('550002', 'Regime de TrÃ¢nsito, observado o art. 84 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'S', 'N', 'N', 'Sem AlÃ­quota', 'NFe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('550003', 'Regimes de DepÃ³sito, observado o art. 85 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'S', 'N', 'N', 'Sem AlÃ­quota', 'NFe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('550004', 'Regimes de DepÃ³sito, observado o art. 87 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'S', 'N', 'N', 'Sem AlÃ­quota', 'NFe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('550005', 'Regimes de DepÃ³sito, observado o art. 87 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'S', 'N', 'N', 'Sem AlÃ­quota', 'NFe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('550006', 'Regimes de PermanÃªncia TemporÃ¡ria, observado o art. 88 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'S', 'N', 'N', 'Sem AlÃ­quota', 'NFe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('550007', 'Regimes de AperfeiÃ§oamento, observado o art. 90 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'S', 'N', 'N', 'Sem AlÃ­quota', 'NFe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('550008', 'ImportaÃ§Ã£o de bens para o Regime de Repetro-TemporÃ¡rio, de que tratam o inciso I do art. 93 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'S', 'N', 'N', 'Sem AlÃ­quota', 'NFe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('550009', 'GNL-TemporÃ¡rio, de que trata o inciso II do art. 93 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'S', 'N', 'N', 'Sem AlÃ­quota', 'NFe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('550010', 'Repetro-Permanente, de que trata o inciso III do art. 93 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'S', 'N', 'N', 'Sem AlÃ­quota', 'NFe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('550011', 'Repetro-IndustrializaÃ§Ã£o, de que trata o inciso IV do art. 93 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'S', 'N', 'N', 'Sem AlÃ­quota', 'NFe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('550012', 'Repetro-Nacional, de que trata o inciso V do art. 93 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'S', 'N', 'N', 'Sem AlÃ­quota', 'NFe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('550013', 'Repetro-Entreposto, de que trata o inciso VI do art. 93 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'S', 'N', 'N', 'Sem AlÃ­quota', 'NFe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('550014', 'Zona de Processamento de ExportaÃ§Ã£o, observado os arts. 99, 100 e 102 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'S', 'N', 'N', 'Sem AlÃ­quota', 'NFe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('550015', 'Regime TributÃ¡rio para Incentivo Ã  ModernizaÃ§Ã£o e Ã  AmpliaÃ§Ã£o da Estrutura PortuÃ¡ria - Reporto, observado o art. 105 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'S', 'N', 'N', 'Sem AlÃ­quota', 'NFe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('550016', 'Regime Especial de Incentivos para o Desenvolvimento da Infraestrutura - Reidi, observado o art. 106 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'S', 'N', 'N', 'Sem AlÃ­quota', 'NFe,NFSE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('550017', 'Regime TributÃ¡rio para Incentivo Ã  Atividade EconÃ´mica Naval â€“ Renaval, observado o art. 107 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'S', 'N', 'N', 'Sem AlÃ­quota', 'NFe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('550018', 'DesoneraÃ§Ã£o da aquisiÃ§Ã£o de bens de capital, observado o art. 109 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'S', 'N', 'N', 'Sem AlÃ­quota', 'NFe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('550019', 'ImportaÃ§Ã£o de bem material por indÃºstria incentivada para utilizaÃ§Ã£o na Zona Franca de Manaus, observado o art. 443 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'S', 'N', 'N', 'Sem AlÃ­quota', 'NFe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('550020', 'Ãreas de livre comÃ©rcio, observado o art. 461 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'S', 'N', 'N', 'Sem AlÃ­quota', 'NFe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('550021', 'Fornecimento de produtos agropecuÃ¡rios in natura para contribuinte do regime regular que promova industrializaÃ§Ã£o destinada a exportaÃ§Ã£o, observado o art. 82 da Lei Complement', 0, 0, 'N', 'S', 'N', 'N', 'Sem AlÃ­quota', 'NFe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('620001', 'TributaÃ§Ã£o monofÃ¡sica sobre combustÃ­veis, observados os art. 172 e   art. 179 I da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFe,NFCe,NFGas', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('620002', 'TributaÃ§Ã£o monofÃ¡sica com responsabilidade pela retenÃ§Ã£o sobre combustÃ­veis, observado o art. 178 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFe,NFCe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('620003', 'TributaÃ§Ã£o monofÃ¡sica com tributos retidos por responsabilidade sobre combustÃ­veis, observado o art. 178 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFe,NFCe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('620004', 'TributaÃ§Ã£o monofÃ¡sica sobre mistura de EAC com gasolina A em percentual superior ou inferior ao obrigatÃ³rio, observado o art. 179 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFe,NFCe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('620005', 'TributaÃ§Ã£o monofÃ¡sica sobre mistura de EAC com gasolina A em percentual superior ou inferior ao obrigatÃ³rio, observado o art. 179 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFe,NFCe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('620006', 'TributaÃ§Ã£o monofÃ¡sica sobre combustÃ­veis cobrada anteriormente, observador o art. 180 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFe,NFCe,NFGas', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('800001', 'FusÃ£o, cisÃ£o ou incorporaÃ§Ã£o, observado o art. 55 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'N', 'N', 'N', 'Sem AlÃ­quota', 'NFe,NFSE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('800002', 'TransferÃªncia de crÃ©dito do associado, inclusive as cooperativas singulares, para cooperativa de que participa das operaÃ§Ãµes antecedentes Ã s operaÃ§Ãµes em que fornece bens e ', 0, 0, 'N', 'N', 'N', 'N', 'Sem AlÃ­quota', 'NFe,NFSE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('810001', 'CrÃ©dito presumido sobre o valor apurado nos fornecimentos a partir da Zona Franca de Manaus, observado o art. 450 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'N', 'S', 'N', 'Sem AlÃ­quota', 'NFe', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('811001', 'AnulaÃ§Ã£o de crÃ©dito proporcional ao valor das operaÃ§Ãµes imunes e isentas, observado o art. 51 da Lei Complementar nÂº 214, de 2025.
', 0, 0, 'N', 'N', 'N', 'N', 'Sem AlÃ­quota', 'NFe,NFSE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('811002', 'DÃ©bitos de notas fiscais nÃ£o processadas na apuraÃ§Ã£o, observado o art. 45 da Lei Complementar nÂº 214, de 2025.
', 0, 0, 'N', 'N', 'N', 'N', 'Sem AlÃ­quota', 'NFe,NFSE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('811003', 'DÃ©bitos apurados apÃ³s o desenquadramento do regime Simples Nacional, observado o art. 41 da Lei Complementar nÂº 214, de 2025.
', 0, 0, 'N', 'N', 'N', 'N', 'Sem AlÃ­quota', 'NFe,NFSE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('820001', 'Documento com informaÃ§Ãµes de fornecimento de serviÃ§os de planos de assinstÃªncia Ã  saÃºde, mas com tributaÃ§Ã£o realizada por outro meio, observado o art. 235 da Lei Complement', 0, 0, 'N', 'N', 'N', 'N', 'Sem AlÃ­quota', 'NFSE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('820002', 'Documento com informaÃ§Ãµes de fornecimento de serviÃ§os de planos de assinstÃªncia funerÃ¡ria, mas com tributaÃ§Ã£o realizada por outro meio, observado o art. 236 da Lei Complemen', 0, 0, 'N', 'N', 'N', 'N', 'Sem AlÃ­quota', 'NFSE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('820003', 'Documento com informaÃ§Ãµes de fornecimento de serviÃ§os de planos de assinstÃªncia Ã  saÃºde de animais domÃ©sticos, mas com tributaÃ§Ã£o realizada por outro meio, observado o art', 0, 0, 'N', 'N', 'N', 'N', 'Sem AlÃ­quota', 'NFSE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('820004', 'Documento com informaÃ§Ãµes de prestaÃ§Ã£o de serviÃ§os de consursos de prognÃ³sticos, mas com tributaÃ§Ã£o realizada por outro meio, observado o art. 248 da Lei Complementar nÂº 2', 0, 0, 'N', 'N', 'N', 'N', 'Sem AlÃ­quota', 'NFSE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('820005', 'Documento com informaÃ§Ãµes de alienaÃ§Ã£o de bens imÃ³veis, mas com tributaÃ§Ã£o realizada por outro meio,, observado o art. 254 da Lei Complementar nÂº 214, de 2025.', 0, 0, 'N', 'N', 'N', 'N', 'Sem AlÃ­quota', 'NFABI,DERE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('820006', 'Documento com informaÃ§Ãµes de fornecimento de serviÃ§os de exploraÃ§Ã£o de via, mas com tributaÃ§Ã£o realizada por outro meio, observado o art. 11 da Lei Complementar nÂº 214, de ', 0, 0, 'N', 'N', 'N', 'N', 'Sem AlÃ­quota', 'NFSE', 0);
INSERT INTO CLASSTRIB (ID, DESCRICAO, TXREDIBS, TXREDCBS, REDUCAOBC, TRIBREGULAR, CREDITOPRESUMIDO, ESTORNOCREDITO, TIPOALIQUOTA, DFEASSOCIADO, ANEXO) VALUES ('830001', 'Documento com  exclusÃ£o da base de cÃ¡lculo da CBS e do IBS refrente Ã  energia elÃ©trica fornecida pela distribuidora Ã  unidade consumidora, conforme  Art 28, parÃ¡grafos 3Â° e ', 0, 0, 'N', 'N', 'N', 'N', 'PadrÃ£o', 'NFe,NF3e', 0);


COMMIT WORK;

INSERT INTO CSTIBSCBS (ID, DESCRICAO, TRIBUTACAO, REDUCAO, TRANSFCREDITO, DIFERIMENTO, MONOFASICA, CREDITOPRESUMIDOZFM, AJUSTECREDITO) VALUES ('000', 'TributaÃ§Ã£o integral', 'S', 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO CSTIBSCBS (ID, DESCRICAO, TRIBUTACAO, REDUCAO, TRANSFCREDITO, DIFERIMENTO, MONOFASICA, CREDITOPRESUMIDOZFM, AJUSTECREDITO) VALUES ('010', 'TributaÃ§Ã£o com alÃ­quotas uniformes', 'N', 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO CSTIBSCBS (ID, DESCRICAO, TRIBUTACAO, REDUCAO, TRANSFCREDITO, DIFERIMENTO, MONOFASICA, CREDITOPRESUMIDOZFM, AJUSTECREDITO) VALUES ('011', 'TributaÃ§Ã£o com alÃ­quotas uniformes reduzidas', 'N', 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO CSTIBSCBS (ID, DESCRICAO, TRIBUTACAO, REDUCAO, TRANSFCREDITO, DIFERIMENTO, MONOFASICA, CREDITOPRESUMIDOZFM, AJUSTECREDITO) VALUES ('200', 'AlÃ­quota reduzida', 'S', 'A', 'N', 'N', 'N', 'N', 'N');
INSERT INTO CSTIBSCBS (ID, DESCRICAO, TRIBUTACAO, REDUCAO, TRANSFCREDITO, DIFERIMENTO, MONOFASICA, CREDITOPRESUMIDOZFM, AJUSTECREDITO) VALUES ('220', 'AlÃ­quota fixa', 'S', 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO CSTIBSCBS (ID, DESCRICAO, TRIBUTACAO, REDUCAO, TRANSFCREDITO, DIFERIMENTO, MONOFASICA, CREDITOPRESUMIDOZFM, AJUSTECREDITO) VALUES ('221', 'AlÃ­quota fixa proporcional', 'N', 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO CSTIBSCBS (ID, DESCRICAO, TRIBUTACAO, REDUCAO, TRANSFCREDITO, DIFERIMENTO, MONOFASICA, CREDITOPRESUMIDOZFM, AJUSTECREDITO) VALUES ('222', 'ReduÃ§Ã£o de Base de CÃ¡lculo', 'S', 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO CSTIBSCBS (ID, DESCRICAO, TRIBUTACAO, REDUCAO, TRANSFCREDITO, DIFERIMENTO, MONOFASICA, CREDITOPRESUMIDOZFM, AJUSTECREDITO) VALUES ('400', 'IsenÃ§Ã£o', 'N', 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO CSTIBSCBS (ID, DESCRICAO, TRIBUTACAO, REDUCAO, TRANSFCREDITO, DIFERIMENTO, MONOFASICA, CREDITOPRESUMIDOZFM, AJUSTECREDITO) VALUES ('410', 'Imunidade e nÃ£o incidÃªncia', 'N', 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO CSTIBSCBS (ID, DESCRICAO, TRIBUTACAO, REDUCAO, TRANSFCREDITO, DIFERIMENTO, MONOFASICA, CREDITOPRESUMIDOZFM, AJUSTECREDITO) VALUES ('510', 'Diferimento', 'S', 'N', 'N', 'S', 'N', 'N', 'N');
INSERT INTO CSTIBSCBS (ID, DESCRICAO, TRIBUTACAO, REDUCAO, TRANSFCREDITO, DIFERIMENTO, MONOFASICA, CREDITOPRESUMIDOZFM, AJUSTECREDITO) VALUES ('515', 'Diferimento com reduÃ§Ã£o de alÃ­quota', 'S', 'A', 'N', 'S', 'N', 'N', 'N');
INSERT INTO CSTIBSCBS (ID, DESCRICAO, TRIBUTACAO, REDUCAO, TRANSFCREDITO, DIFERIMENTO, MONOFASICA, CREDITOPRESUMIDOZFM, AJUSTECREDITO) VALUES ('550', 'SuspensÃ£o', 'S', 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO CSTIBSCBS (ID, DESCRICAO, TRIBUTACAO, REDUCAO, TRANSFCREDITO, DIFERIMENTO, MONOFASICA, CREDITOPRESUMIDOZFM, AJUSTECREDITO) VALUES ('620', 'TributaÃ§Ã£o MonofÃ¡sica', 'N', 'N', 'N', 'N', 'S', 'N', 'N');
INSERT INTO CSTIBSCBS (ID, DESCRICAO, TRIBUTACAO, REDUCAO, TRANSFCREDITO, DIFERIMENTO, MONOFASICA, CREDITOPRESUMIDOZFM, AJUSTECREDITO) VALUES ('800', 'TransferÃªncia de crÃ©dito', 'N', 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO CSTIBSCBS (ID, DESCRICAO, TRIBUTACAO, REDUCAO, TRANSFCREDITO, DIFERIMENTO, MONOFASICA, CREDITOPRESUMIDOZFM, AJUSTECREDITO) VALUES ('810', 'Ajuste de IBS na ZFM', 'N', 'N', 'S', 'N', 'N', 'N', 'N');
INSERT INTO CSTIBSCBS (ID, DESCRICAO, TRIBUTACAO, REDUCAO, TRANSFCREDITO, DIFERIMENTO, MONOFASICA, CREDITOPRESUMIDOZFM, AJUSTECREDITO) VALUES ('811', 'Ajustes', 'N', 'N', 'N', 'N', 'N', 'N', 'S');
INSERT INTO CSTIBSCBS (ID, DESCRICAO, TRIBUTACAO, REDUCAO, TRANSFCREDITO, DIFERIMENTO, MONOFASICA, CREDITOPRESUMIDOZFM, AJUSTECREDITO) VALUES ('820', 'TributaÃ§Ã£o em declaraÃ§Ã£o de regime especÃ­fico', 'N', 'N', 'N', 'N', 'N', 'N', 'N');
INSERT INTO CSTIBSCBS (ID, DESCRICAO, TRIBUTACAO, REDUCAO, TRANSFCREDITO, DIFERIMENTO, MONOFASICA, CREDITOPRESUMIDOZFM, AJUSTECREDITO) VALUES ('830', 'ExclusÃ£o da Base de CÃ¡lculo', 'S', 'N', 'N', 'N', 'N', 'N', 'N');


COMMIT WORK;


SET TERM ^ ;

CREATE OR ALTER procedure CTRCTE (
    ECODIGO smallint,
    ID integer)
returns (
    CFOP varchar(4),
    NATOP varchar(60),
    FORMAPGTO smallint,
    NUMERO integer,
    EMISSAO timestamp,
    TIPOCTE smallint,
    CTEREF varchar(44),
    TIPOSERV smallint,
    CODCIDADEINI integer,
    CIDADEINI varchar(60),
    UFINI char(2),
    CODCIDADEFIM integer,
    CIDADEFIM varchar(60),
    UFFIM char(2),
    RETIRA smallint,
    OPERADOR varchar(20),
    OBS varchar(2000),
    VLTOTAL numeric(9,2),
    DESCONTO numeric(9,2),
    FRETEPESO numeric(9,2),
    FRETEVALOR numeric(9,2),
    SECCAT numeric(9,2),
    DESPACHO numeric(9,2),
    ITR numeric(9,2),
    PEDAGIO numeric(9,2),
    COLETA numeric(9,2),
    SEGURO numeric(9,2),
    CST char(2),
    TXRDBC numeric(4,2),
    BCICMS numeric(9,2),
    TXICMS numeric(4,2),
    VLICMS numeric(9,2),
    VLNF numeric(9,2),
    NATPRD varchar(60),
    ESPECIE varchar(30),
    UN char(2),
    TPMED varchar(20),
    QUANTIDADE numeric(9,4),
    VOLUME smallint,
    PESO numeric(9,4),
    M3LITRO numeric(9,4),
    RESPSEGURO char(1),
    SEGURADORA varchar(30),
    APOLICE varchar(20),
    AVERBACAO varchar(20),
    VLSEGURADO numeric(9,2),
    REMETENTE varchar(14),
    DESTINATARIO varchar(14),
    PAGADOR varchar(14),
    REDESPACHO varchar(14),
    EXPEDIDOR varchar(14),
    JUSTCANCELAMENTO varchar(255),
    VLPIS numeric(9,2),
    VLCOFINS numeric(9,2),
    VLIR numeric(9,2),
    VLINSS numeric(9,2),
    VLCSLL numeric(9,2),
    /* Reforma Trib */
    ENTEGOV smallint,
    TXREDUTORGOV numeric(9,4),
    CLASTRIBIBSCBS char(6),
    CLASTRIBIBSCBS_REG char(6),
    BCIBSCBS numeric(9,2),
    TXIBSUF numeric(9,4),
    TXDIFIBSUF numeric(9,4),
    VLDEVTRIBIBSUF numeric(9,2),
    TXIBSMUN numeric(9,4),
    TXDIFIBSMUN numeric(9,4),
    VLDEVTRIBIBSMUN numeric(9,2),
    TXCBS numeric(9,4),
    TXDIFCBS numeric(9,4),
    VLDEVTRIBCBS numeric(9,2),
    IBSEstCred numeric(9,2),
    CBSEstCred numeric(9,2))
as
declare variable STFRETE char(1);
declare variable TPUN char(1);
declare variable IDMUNICIPIOINI integer;
declare variable IDMUNICIPIOFIM integer;
BEGIN
   SELECT ct.CFOP, (SELECT SUBSTRING(CFOPDESCRICAO FROM 1 FOR 60) FROM CFOP WHERE CFOP = ct.CFOP), ct.STFRETE,
          ct.NUMERO, ct.DATA, ct.TIPOSERV, ct.RETIRA, ct.OPERADOR, ct.OBSI||' '||ct.OBSII, ct.TOTAL, ct.DESCONTO,
          ct.FRETEPVOLUME, ct.FRETEVALOR, ct.SECCATE, ct.DESPACHO, ct.ITR, ct.PEDAGIO,
          ct.COLETA, ct.CST, ct.TXRDBC, ct.BCICMS, ct.TXICMS, ct.ICMS, ct.VALORNF,
          ct.NATUREZA, ct.ESPECIE, ct.UNID, ct.VOLUME, ct.PESO, ct.M3LITRO, ct.REMETENTE,
          ct.DESTINATARIO, ct.PAGADOR, ct.REDESPACHO, ct.EXPEDIDOR, ct.CTEREF, ct.TIPOCTE,
          ct.IDMUNICIPIOINI, ct.IDMUNICIPIOFIM, ct.CLASTRIBIBSCBS, ct.TXIBSUF, ct.TXIBSMUN,
          ct.TXCBS
   FROM CTRC ct WHERE ct.ID = :ID AND ct.ECODIGO = :ECODIGO
   INTO :CFOP, :NATOP, :STFRETE, :NUMERO, :EMISSAO, :TIPOSERV, :RETIRA, :OPERADOR, :OBS, :VLTOTAL,
        :DESCONTO, :FRETEPESO, :FRETEVALOR, :SECCAT, :DESPACHO, :ITR, :PEDAGIO, :COLETA,
        :CST, :TXRDBC, :BCICMS, :TXICMS, :VLICMS, :VLNF, :NATPRD, :ESPECIE, :UN, :VOLUME, :PESO,
        :M3LITRO, :REMETENTE, :DESTINATARIO, :PAGADOR, :REDESPACHO, :EXPEDIDOR, :CTEREF, :TIPOCTE,
        :IDMUNICIPIOINI, :IDMUNICIPIOFIM, :CLASTRIBIBSCBS, :TXIBSUF, :TXIBSMUN, :TXCBS;

   RESPSEGURO = '4';
   SELECT SEGURADORA, APOLICE FROM CONFIGURACAO WHERE ECODIGO = :ECODIGO INTO :SEGURADORA, :APOLICE;
   AVERBACAO = '';
   VLSEGURADO = 0;
   VLPIS = 0;
   VLCOFINS = 0;
   VLIR = 0;
   VLINSS = 0;
   VLCSLL = 0;

   select dadosadicionais from ctrce where ID = :ID AND ECODIGO = :ECODIGO into :obs;

   IF (:STFRETE = 'P') THEN
      FORMAPGTO = 0;
   ELSE IF (:STFRETE = 'A') THEN
      FORMAPGTO = 1;
   ELSE
      FORMAPGTO = 2;
   SEGURO = 0;

   /* Reforma Trib */
   BCIBSCBS = :VLTOTAL - :DESCONTO;
      
   TXDIFIBSUF = 0;
   VLDEVTRIBIBSUF = 0;
   TXDIFIBSMUN = TXDIFIBSUF;
   VLDEVTRIBIBSMUN = VLDEVTRIBIBSUF;
   TXDIFCBS = 0;
   VLDEVTRIBCBS = 0;
   CLASTRIBIBSCBS_REG = '';
   IBSEstCred = 0;
   CBSEstCred = 0;

   SELECT ENTEGOV, TXREDUTORGOV FROM CTRCDFE WHERE (ID = :ID) INTO :ENTEGOV, :TXREDUTORGOV;
   /* Reforma Trib */

   SELECT TIPO FROM UNIDADE WHERE ID = :UN INTO :TPUN;
   IF (:TPUN = 'P') THEN
   BEGIN
      TPMED = 'PESO BRUTO';
      QUANTIDADE = :PESO;
   END ELSE IF (:TPUN = 'C') THEN
   BEGIN
      TPMED = 'PESO CUBADO';
      QUANTIDADE = :M3LITRO;
   END ELSE IF (:TPUN = 'U') THEN
   BEGIN
      TPMED = 'CAIXAS';
      QUANTIDADE = :VOLUME;
   END ELSE IF (:TPUN = 'L') THEN
   BEGIN
      TPMED = 'LITRAGEM';
      QUANTIDADE = :M3LITRO;
   END

   /* JUSTIFICATIVA DE CANCELAMENTO */
   SELECT SUBSTRING(l.LDESCRICAO FROM 1 FOR 255) FROM LOG l WHERE l.ECODIGO = :ECODIGO AND l.IDORIGEM = :ID INTO :JUSTCANCELAMENTO;
   /* MUNICIPIO DE INICIO DA PRESTACAO */
   IF ((:EXPEDIDOR = '') OR (:EXPEDIDOR IS NULL)) THEN
   BEGIN
      SELECT m.IDCIDADE, m.DESCRICAO, m.UF FROM MUNICIPIO m WHERE m.CODIGO = :IDMUNICIPIOINI
      INTO :CODCIDADEINI, :CIDADEINI, :UFINI;
   END ELSE
   BEGIN
      SELECT m.IDCIDADE, m.DESCRICAO, m.UF
      FROM CLIENTE c JOIN MUNICIPIO m ON m.CODIGO = c.CODIGOMUNIC
      WHERE c.CCNPJ = :EXPEDIDOR
      INTO :CODCIDADEINI, :CIDADEINI, :UFINI;
   END
   /* MUNICIPIO DE TERMINO DA PRESTACAO */
   IF ((:REDESPACHO = '') OR (:REDESPACHO IS NULL)) THEN
   BEGIN
      SELECT m.IDCIDADE, m.DESCRICAO, m.UF FROM MUNICIPIO m WHERE m.CODIGO = :IDMUNICIPIOFIM
      INTO :CODCIDADEFIM, :CIDADEFIM, :UFFIM;
   END ELSE
   BEGIN
      SELECT m.IDCIDADE, m.DESCRICAO, m.UF
      FROM CLIENTE c JOIN MUNICIPIO m ON m.CODIGO = c.CODIGOMUNIC
      WHERE c.CCNPJ = :REDESPACHO
      INTO :CODCIDADEFIM, :CIDADEFIM, :UFFIM;
   END

   SUSPEND;
END^

SET TERM ; ^

