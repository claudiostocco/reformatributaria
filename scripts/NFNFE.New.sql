SET TERM ^ ;

CREATE OR ALTER procedure NFNFE (
    ID bigint)
returns (
    ECODIGO smallint,
    CID varchar(8),
    NATOP varchar(60),
    NUMERO integer,
    EMISSAO timestamp,
    DTENTSAIDA timestamp,
    MODDOC char(2),
    INDFINAL smallint,
    INDPRES smallint,
    INDINTERMED smallint,
    CNPJINTERMED varchar(14),
    IDCADINTTRAN varchar(60),
    INDDEST smallint,
    TIPONF smallint,
    FINALIDADENFE smallint,
    BCST numeric(9,2),
    VLST numeric(9,2),
    TXICMSINTERNA numeric(4,2),
    TXFCP numeric(4,2),
    VLPRODUTOS numeric(9,2),
    FRETE numeric(9,2),
    SEGURO numeric(9,2),
    DESCONTO numeric(9,2),
    VLII numeric(9,2),
    VLIPI numeric(9,2),
    VLPIS numeric(9,2),
    VLCOFINS numeric(9,2),
    IDMUNFGISS integer,
    VLSERV numeric(9,2),
    BCISS numeric(9,2),
    VLISS numeric(9,2),
    VLPISISS numeric(9,2),
    VLCOFINSISS numeric(9,2),
    DESPESAS numeric(9,2),
    TOTALNF numeric(9,2),
    VLRETPIS numeric(9,2),
    VLRETCOFINS numeric(9,2),
    VLRETCSLL numeric(9,2),
    BCIRRF numeric(9,2),
    IRRF numeric(9,2),
    BCRETPREV numeric(9,2),
    RETPREV numeric(9,2),
    JUSTCANCELAMENTO varchar(60),
    IDNFEREF varchar(44),
    UFEMBARQUE char(2),
    LOCALEMBARQUE varchar(60),
    NDI varchar(10),
    DDI date,
    DD date,
    OBSFISCO varchar(2000),
    TIPONFNO smallint,
    /* Reforma Trib */
    TIPODEBCRED smallint,
    ENTEGOV smallint,
    TXREDUTORGOV numeric(9,4),
    OPERACAOGOV smallint,
    IBSEstCred numeric(9,2),
    CBSEstCred numeric(9,2))
    /* Reforma Trib */
as
declare variable ES char(1);
declare variable VENCIMENTO timestamp;
declare variable IDNFCOMPLEMENTAR bigint;
declare variable IDNO integer;
declare variable SQL varchar(125);
BEGIN
   IBSEstCred = 0;
   CBSEstCred = 0;

   SELECT TIPODEBCRED, ENTEGOV, TXREDUTORGOV, OPERACAOGOV FROM NFCDCNFE
   WHERE (ID = :ID) INTO :TIPODEBCRED, :ENTEGOV, :TXREDUTORGOV, :OPERACAOGOV;

   SELECT n.ECODIGO, n.CID, n.IDNO, (SELECT DESCRICAO FROM NATUREZAOP WHERE ID = n.IDNO)
        , n.NUMERONF, n.DATA, COALESCE((SELECT dc.DATASAIDA FROM NFCDC dc WHERE dc.ID = n.ID),n.DATA)
        , n.VALORIPI, n.FRETE, n.DESCONTO, n.VALORCSLL, n.TOTAL, n.DACESSORIA+n.VALORIPIDA+n.VALORSTDA
        , (SELECT dc.IDNFCOMPLEMENTAR FROM NFCDC dc WHERE dc.ID = n.ID)
        , (SELECT ES FROM NATUREZAOP WHERE ID = n.IDNO), n.INDOPFINAL, n.INDPRESENCA, n.INDDESTINO
        , (SELECT IDTIPONF FROM NATUREZAOP WHERE ID = n.IDNO)
   FROM NFC n WHERE (n.ID = :ID)
   INTO :ECODIGO, :CID, :IDNO, :NATOP, :NUMERO, :EMISSAO, :DTENTSAIDA, :VLIPI, :FRETE, :DESCONTO, 
        :VLRETCSLL, :TOTALNF, :DESPESAS, :IDNFCOMPLEMENTAR, :ES, :INDFINAL, :INDPRES, :INDDEST,
        :TIPONFNO;
   IF (UPPER(:ES) = 'E') THEN
      TIPONF = 0;
   ELSE
      TIPONF = 1;

   /* indicador de intermediador para venda n??o presencial */
   INDINTERMED = 0;
   IF (:INDINTERMED = 1) THEN
   BEGIN
      SELECT FIRST 1 CNPJINTERMED, IDCADINTTRAN FROM INTERMEDIADORVENDA INTO :CNPJINTERMED, :IDCADINTTRAN;
   END ELSE
   BEGIN
      CNPJINTERMED = '';
      IDCADINTTRAN = '';
   END

   /* JUSTIFICATIVA DE CANCELAMENTO */
   SELECT nd.JUSTCANCELAMENTO, nd.UFEMBARQUE, nd.LOCALEMBARQUE, nd.NDI, nd.DDI, nd.DD, nd.MSGFISCO FROM NFCDC nd WHERE nd.ID = :ID
   INTO :JUSTCANCELAMENTO, :UFEMBARQUE, :LOCALEMBARQUE, :NDI, :DDI, :DD, :OBSFISCO;

   VLPIS = 0;
   VLCOFINS = 0;
   VLSERV = 0;
   VLPISISS = 0;
   VLCOFINSISS = 0;
   IF (:IDNO = 62) THEN
      SQL = 'FROM NFCI i, NFCIAC ac WHERE i.ID = ac.IDCUPOM AND ac.IDNF = ';
   ELSE
      SQL = 'FROM NFCI i WHERE i.ID = ';
   SQL = :SQL||:ID||' AND i.STATUS <> ''C'' AND i.INDTOT = ''1''';
   /* TOTAIS DO ICMS */
   EXECUTE STATEMENT 'SELECT SUM(i.SUBTOTAL), SUM(i.VLPIS), SUM(i.VLCOFINS) '||:SQL||' AND i.VALORISS = 0'
      INTO :VLPRODUTOS, :VLPIS, :VLCOFINS;

   SELECT e.TXICMSINTERNA, e.TXFCP, ne.IDMDF FROM ESTADO e INNER JOIN NFCE ne ON e.ID = SUBSTRING(ne.IDMUNICIPIO FROM 1 FOR 2) WHERE ne.ID = :ID
     INTO :TXICMSINTERNA, :TXFCP, :MODDOC;

   EXECUTE STATEMENT 'SELECT COALESCE(SUM(i.BCST),0), COALESCE(SUM(i.VALORST),0) '||:SQL||' AND i.VALORISS = 0 AND SUBSTRING(i.CST FROM 2 FOR 2) IN (''10'',''30'',''70'',''90'')'
      INTO :BCST, :VLST;
   EXECUTE STATEMENT 'SELECT SUM(i.TOTAL), SUM(i.VALORISS), SUM(i.VLPIS), SUM(i.VLCOFINS) '||:SQL||' AND i.VALORISS > 0'
      INTO :VLSERV, :VLISS, :VLPISISS, :VLCOFINSISS;
   BCISS = :VLSERV;

   /* MANTER POR COMPATIBILIDADE */
   SEGURO = 0;
   VLII = 0;
   VLRETPIS = 0;
   VLRETCOFINS = 0;
   BCIRRF = 0;
   IRRF = 0;
   BCRETPREV = 0;
   RETPREV = 0;

   BEGIN SELECT FINNFE FROM NATUREZAOP WHERE ID = :IDNO INTO :FINALIDADENFE; WHEN ANY DO FINALIDADENFE = 1; END
   IF ((:FINALIDADENFE IS NULL) OR (:FINALIDADENFE = 0)) THEN FINALIDADENFE = 1;
   IDNFEREF = '';
   /* SE FOR UMA NFe COMPLEMENTAR OU DE AJUSTE ASSOCIA A NFe DE REFERENCIA */
   SELECT IDNFE FROM NFCE WHERE ID = :IDNFCOMPLEMENTAR AND ID > 0 INTO :IDNFEREF;

   /* MUNICIPIO QUE GEROU O SERVICO, PARA CALCULO DO ISS */
   SELECT e.IDMUNICIPIO FROM ENTIDADE e WHERE e.EID = :CID INTO :IDMUNFGISS;
   SUSPEND;
END^

SET TERM ; ^


