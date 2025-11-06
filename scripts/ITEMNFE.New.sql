SET TERM ^ ;

CREATE OR ALTER procedure ITEMNFE (
    ID bigint)
returns (
    ITEM smallint,
    PCODIGO varchar(13),
    PCODIGONFE varchar(13),
    USAGTIN char(1),
    DESCRICAO varchar(120),
    COMPLEMENTO varchar(500),
    CODIGOANP varchar(9),
    DESCRICAOANP varchar(95),
    TXGLP numeric(9,4),
    TXGNN numeric(9,4),
    TXGNI numeric(9,4),
    TXBIO numeric(9,4),
    INDIMPORTORIGCOMB smallint,
    CUFORIGCOMB smallint,
    TXORIGCOMB numeric(9,4),
    INDTOT char(1),
    CFOP varchar(5),
    UN varchar(6),
    QUANTIDADE numeric(15,4),
    UNITARIO numeric(18,8),
    UNTRIB varchar(6),
    QUANTIDADETRIB numeric(15,4),
    UNITARIOTRIB numeric(18,8),
    VLPRODUTO numeric(9,2),
    FRETE numeric(9,2),
    SEGURO numeric(9,2),
    DESCONTO numeric(9,2),
    ICMSDESON numeric(9,2),
    DESPESAACESSORIA numeric(9,2),
    CST char(3),
    CSOSN char(3),
    MODDETBCICMS char(1),
    BCICMS numeric(9,2),
    TXREDBC numeric(4,2),
    TXICMS numeric(4,2),
    VLICMS numeric(9,2),
    REPASSEICMSST char(1),
    VLICMSSUBSTITUTO numeric(9,2),
    BCST numeric(9,2),
    TXST numeric(4,2),
    VLST numeric(9,2),
    BCSTRET numeric(9,2),
    TXSTRET numeric(4,2),
    VLSTRET numeric(9,2),
    CSTIPI char(2),
    BCIPI numeric(9,2),
    TXIPI numeric(4,2),
    VLIPI numeric(9,2),
    ENQIPI smallint,
    PERCDEVOLVIDO numeric(4,2),
    BCII numeric(9,2),
    VLDESPADUANEIRAS numeric(9,2),
    VLII numeric(9,2),
    VLIOF numeric(9,2),
    CSTPIS char(2),
    BCPIS numeric(9,2),
    TXPIS numeric(4,2),
    VLPIS numeric(9,2),
    CSTCOFINS char(2),
    BCCOFINS numeric(9,2),
    TXCOFINS numeric(4,2),
    VLCOFINS numeric(9,2),
    BCISS numeric(9,2),
    VLISS numeric(9,2),
    CODIGOSERVLC varchar(5),
    CODTRIBISS char(1),
    CLFISCAL varchar(10),
    NDRAWBACK varchar(11),
    NREXP varchar(12),
    CHAVENFEEXP varchar(44),
    TPTRANSPIMP smallint,
    VLAFRMM numeric(9,2),
    TPINTERMEDIMP char(1),
    CNPJINTERMEDIMP varchar(14),
    UFINTERMEDIMP char(2),
    CEST integer,
    INDESCALA char(1),
    CNPJFAB varchar(14),
    CODIGOBENEFICIO varchar(10),
    NRMS varchar(13),
    NRMSMOTIVOISENCAO varchar(200),
    PMC numeric(9,2),
    XPED varchar(15),
    NITEMPED integer,
    MOTDESICMS smallint,
    /* Reforma Trib */
    INDBEMMOVELUSADO smallint,
    CLASTRIBIS char(6),
    BCIS numeric(9,2),
    TXIS numeric(9,4),
    VLIS numeric(9,2),
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
    DFEREF_CHAVE VARCHAR(44),
    DFEREF_NITEM SMALLINT)
    /* Reforma Trib */
as
declare variable ACODIGO char(2);
declare variable VLTOTAL numeric(9,2);
declare variable VLIPICOMPRA numeric(9,2);
declare variable SQL varchar(610); /* AO MUDAR O SQL, NAO ESQUECER QUE IDNO=62 E MAIOR */
declare variable ECODIGO smallint;
declare variable IDNO integer;
declare variable INDOPFINAL char(1);
declare variable INDDESTINO char(1);
declare variable FINNFE char(1);
declare variable IDMDF char(2);
declare variable DIGCFOP char(1);
declare variable UFENT smallint;
declare variable UFEMITENTE smallint;
declare variable PEDCLIENTE varchar(15);
declare variable FCUNTRIB numeric(9,4);
declare variable ITEMBD varchar(6);
declare variable QTDEMBALAGEM numeric(9,3);
declare variable TEMP numeric(9,3);
declare variable VENDAPOR char(1);
declare variable XQTDEMBALAGEM varchar(10);
declare variable XTEMP varchar(10);
BEGIN
   ITEM = 0;
   SQL = 'SELECT i.ITEM, i.PCODIGO, i.CFOPCODIGO, i.QUANTIDADE, i.UNITARIO, i.SUBTOTAL, i.DESCONTO, i.ICMSDESON, '||
         'i.TOTAL, i.ACODIGO, i.CST, i.TXBCR, i.BCICMS, i.ALIQUOTAUF, i.VALORICMS, i.BCST, i.VALORST, '||
         'i.IDCSTIPI, i.TXIPI, i.VALORIPI, i.VALORISS, i.IDCSTPIS, i.BCPIS, i.TXPIS, i.VLPIS, i.IDCSTCOFINS, i.BCCOFINS, '||
         'i.TXCOFINS, i.VLCOFINS, i.DACESSORIA, i.FRETE, i.NDRAWBACK, i.ENQIPI, COALESCE(i.INDTOT,''1''), i.CLASTRIBIBSCBS, '||
         'i.CLASTRIBIS, i.TXIS, i.TXIBSUF, i.TXIBSMUN, i.TXCBS ';
   SELECT n.ECODIGO, n.IDNO, SUBSTRING(ne.IDMUNICIPIO FROM 1 FOR 2), n.INDOPFINAL, n.INDDESTINO, op.FINNFE, ne.IDMDF FROM NFC n
        INNER JOIN NFCE ne ON n.ID = ne.ID INNER JOIN NATUREZAOP op ON op.ID = n.IDNO
        WHERE n.ID = :ID INTO :ECODIGO, :IDNO, :UFENT, :INDOPFINAL, :INDDESTINO, :FINNFE, :IDMDF;
   SELECT e.CTISS, SUBSTRING(e.IDMUNICIPIO FROM 1 FOR 2) FROM EMPRESA e WHERE e.CODIGO = :ECODIGO INTO :CODTRIBISS, :UFEMITENTE;
   IF (:IDNO = 62) THEN
      SQL = :SQL || 'FROM NFCI i, NFCIAC ac WHERE i.ID = ac.IDCUPOM AND ac.IDNF = '||ID||' AND i.STATUS <> ''C''';
   ELSE
      SQL = :SQL || 'FROM NFCI i WHERE i.ID = '||ID||' AND i.STATUS <> ''C''';
   SQL = :SQL || ' AND COALESCE(i.INDTOT,''1'') <> ''9'' ORDER BY i.ID, i.ITEM';

   FOR EXECUTE STATEMENT :SQL
   INTO :ITEMBD, :PCODIGO, :CFOP, :QUANTIDADE, :UNITARIO, :VLPRODUTO, :DESCONTO, :ICMSDESON,
        :VLTOTAL, :ACODIGO, :CST, :TXREDBC, :BCICMS, :TXICMS, :VLICMS, :BCST,
        :VLST, :CSTIPI, :TXIPI, :VLIPI, :VLISS, :CSTPIS, :BCPIS, :TXPIS, :VLPIS, :CSTCOFINS,
        :BCCOFINS, :TXCOFINS, :VLCOFINS, :DESPESAACESSORIA, :FRETE, :NDRAWBACK,
        :ENQIPI, :INDTOT, :CLASTRIBIBSCBS, :CLASTRIBIS, :TXIS, :TXIBSUF, :TXIBSMUN, :TXCBS
   DO BEGIN
      ITEM = :ITEM + 1;
      IF (:IDNO = 62) THEN
      BEGIN
         IF (:ACODIGO CONTAINING 'F') THEN
            SELECT CFOPST FROM NATUREZAOP WHERE ID = 62 INTO :CFOP;
         ELSE
            SELECT CFOP FROM NATUREZAOP WHERE ID = 62 INTO :CFOP;
         IF ((:UFENT <> :UFEMITENTE) AND (:INDDESTINO = '2')) THEN
            DIGCFOP = '6';
         ELSE
            DIGCFOP = '5';
         CFOP = :DIGCFOP || SUBSTRING(:CFOP FROM 2 FOR 3);
         IF (CAST(:QUANTIDADE * :UNITARIO AS NUMERIC(9,2)) <> :VLPRODUTO) THEN QUANTIDADE = CAST(:VLPRODUTO / :UNITARIO AS NUMERIC(9,4));
      END
      PCODIGONFE = NULL;
      SELECT FIRST 1 CODIGO FROM PRODUTOCODIGO WHERE PCODIGO = :PCODIGO AND STATUS = 'N' INTO :PCODIGONFE;

      /* Reforma Trib */
      INDBEMMOVELUSADO = 0;
      BCIS = :VLPRODUTO + :DESPESAACESSORIA + :FRETE - :DESCONTO;
      VLIS = CAST(:BCIS * :TXIS AS NUMERIC(9,2));
      BCIBSCBS = :VLPRODUTO + :DESPESAACESSORIA + :FRETE + :VLIS - :DESCONTO;
      
      TXDIFIBSUF = 0;
      VLDEVTRIBIBSUF = 0;
      TXDIFIBSMUN = TXDIFIBSUF;
      VLDEVTRIBIBSMUN = VLDEVTRIBIBSUF;
      TXDIFCBS = 0;
      VLDEVTRIBCBS = 0;
      CLASTRIBIBSCBS_REG = '';

      DFEREF_CHAVE = '';
      DFEREF_NITEM = 0;
      /* Reforma Trib */

      SELECT ALIQUOTAICMSST FROM ESTADO WHERE ID = :UFENT INTO :TXST;
      SELECT p.DESCRICAO, p.UNIDADE, COALESCE(p.IDCF,'99')
           , (SELECT ts.CODIGO FROM TIPOSERVICO ts WHERE ts.ID = p.IDTS)
           , p.DCOMPLEMENTO
           , p.CODIGOANP
           , p.CEST
           , '' --p.NRMS
           , p.PRECO
           , p.USAGTIN
           , p.QTDEMBALAGEM
           , (SELECT u.VENDAPOR FROM UNIDADE u WHERE u.ID = p.UNIDADE)
        FROM PRODUTO p WHERE p.CODIGO = :PCODIGO
        INTO :DESCRICAO, :UN, :CLFISCAL, :CODIGOSERVLC, :COMPLEMENTO, :CODIGOANP, :CEST, :NRMS, :PMC,
             :USAGTIN, :QTDEMBALAGEM, :VENDAPOR;

      IF ((:QTDEMBALAGEM > 1) AND ((SELECT VALOR FROM CFG WHERE TIPO = 'NFe' AND NOME = 'ADICIONA MSG QTDEMB X UN') = 'S')) THEN
      BEGIN
         IF (:QTDEMBALAGEM - ROUND(:QTDEMBALAGEM) = 0) THEN
            XQTDEMBALAGEM = CAST(:QTDEMBALAGEM AS INTEGER);
         ELSE
            XQTDEMBALAGEM = REPLACE(:QTDEMBALAGEM,'.',',');

         IF (:VENDAPOR = 'E') THEN
         BEGIN
            TEMP = :QUANTIDADE * :QTDEMBALAGEM;
            IF (:TEMP - ROUND(:TEMP) = 0) THEN
               XTEMP = CAST(:TEMP AS INTEGER);
            ELSE
               XTEMP = REPLACE(:TEMP,'.',',');
            COMPLEMENTO = COALESCE(:COMPLEMENTO,'') || ' ' || TRIM(:UN) || ' com ' || :XQTDEMBALAGEM || ' (' || :XTEMP || ' unidades)';
         END ELSE
         BEGIN
            TEMP = :QUANTIDADE / :QTDEMBALAGEM;
            IF (:TEMP - ROUND(:TEMP) = 0) THEN
               XTEMP = CAST(:TEMP AS INTEGER);
            ELSE
               XTEMP = REPLACE(:TEMP,'.',',');
            COMPLEMENTO = COALESCE(:COMPLEMENTO,'') || ' ' || :XTEMP || ' ' || TRIM(:UN) || ' com ' || :XQTDEMBALAGEM;
         END
      END

      SELECT a.CSOSN FROM ALIQUOTA a WHERE a.CODIGO = :ACODIGO INTO :CSOSN;
      IF (:INDOPFINAL = '1') THEN
         SELECT a.CSOSN FROM ALIQUOTACSOSNEXCECAO a WHERE a.ACODIGO = :ACODIGO AND a.REGRA = 1 INTO :CSOSN;

      IF (:VLIPI > 0) THEN
         BCIPI = :VLPRODUTO;
      ELSE
         BCIPI = 0;

      SELECT PEDIDONUMERO, PEDIDOITEM FROM NFCIPEDIDOCLIENTE WHERE ID = :ID AND ITEM = :ITEMBD
      INTO :XPED, :NITEMPED;
      PEDCLIENTE = :XPED;
      if (COALESCE(:PEDCLIENTE,'') <> '') then COMPLEMENTO = COALESCE(:COMPLEMENTO,'') || '  PEDIDO: ' || :PEDCLIENTE;

      IF ((:CODIGOANP <> '') AND (:CODIGOANP IS NOT NULL)) THEN
         SELECT DESCRICAO, TXGLP, TXGNN, TXGNI, REPASSEICMSST FROM PRODUTOANP WHERE ID = :CODIGOANP
            INTO :DESCRICAOANP, :TXGLP, :TXGNN, :TXGNI, :REPASSEICMSST;
      ELSE
      BEGIN
         DESCRICAOANP = '';
         TXGLP = 0;
         TXGNN = 0;
         TXGNI = 0;
      END

      UNTRIB = '';
      SELECT IDUNIDADE,FC FROM PRODUTOUNTRIB WHERE PCODIGO = :PCODIGO INTO :UNTRIB, :FCUNTRIB;
      IF ((:UNTRIB <> '') AND (:UNTRIB IS NOT NULL)) THEN
      BEGIN
         QUANTIDADETRIB = QUANTIDADE * :FCUNTRIB;
         UNITARIOTRIB = UNITARIO / :FCUNTRIB;
      END ELSE
      BEGIN
         QUANTIDADETRIB = QUANTIDADE;
         UNITARIOTRIB = UNITARIO;
         UNTRIB = :UN;
      END

      BCSTRET = 0;
      TXSTRET = 0;
      VLSTRET = 0;
      VLICMSSUBSTITUTO = 0;
      MOTDESICMS = 9;
      SELECT ICMSSTRETBC, ICMSSTRETALIQUOTA, ICMSSTRETVALOR, ICMSSTRETSUBSTITUTO, MOTDESICMS FROM NFCITRIBUTO WHERE ID = :ID AND ITEM = :ITEMBD
      INTO :BCSTRET, :TXSTRET, :VLSTRET, :VLICMSSUBSTITUTO, :MOTDESICMS;
      IF ((ROW_COUNT = 0) AND (SUBSTRING(:CST FROM 2 FOR 2) IN ('41','60','61'))) THEN
      BEGIN
         INSERT INTO NFCITRIBUTO (ID, ITEM, ICMSSTRETBC, ICMSSTRETALIQUOTA, ICMSSTRETVALOR, ICMSSTRETSUBSTITUTO, MOTDESICMS)
         SELECT FIRST 1 :ID, LPAD(:ITEMBD,3,'0'), t.ICMSSTRETBC / t.QTDTRIB * :QUANTIDADE * p.FC
                                  , t.ICMSSTRETALIQUOTA
                                  , t.ICMSSTRETVALOR / t.QTDTRIB * :QUANTIDADETRIB
                                  , t.ICMSSTRETSUBSTITUTO / t.QTDTRIB * :QUANTIDADETRIB
                                  , 9
         FROM NFEITRIBUTO t
         INNER JOIN NFEI i ON i.ID = t.ID AND i.ITEM = t.ITEM
         INNER JOIN NFE e ON e.ID = t.ID
         INNER JOIN PRODUTOUNTRIB p ON p.PCODIGO = i.PCODIGO
         WHERE e.ECODIGO = :ECODIGO
         AND e.STATUS = 'F'
         AND t.ICMSSTRETVALOR > 0
         AND T.QTDTRIB > 0
         AND i.PCODIGO = :PCODIGO
         ORDER BY E.ENTRADA DESC
         RETURNING ICMSSTRETBC, ICMSSTRETALIQUOTA, ICMSSTRETVALOR, ICMSSTRETSUBSTITUTO, MOTDESICMS
         INTO :BCSTRET, :TXSTRET, :VLSTRET, :VLICMSSUBSTITUTO, :MOTDESICMS;
      END

      IF (:FINNFE = '4') THEN
      BEGIN
         SELECT ei.VLIPI FROM NFEI ei INNER JOIN NFCDV dv ON dv.IDORIGEM = ei.ID AND ei.ITEM = dv.ITEMORIGEM
              WHERE dv.IDNFC = :ID AND dv.ITEMNFC = :ITEMBD AND dv.STATUS = 'F' AND ei.ID > 0 INTO :VLIPICOMPRA;
         IF (:VLIPICOMPRA > :VLIPI) THEN
            PERCDEVOLVIDO = CAST(:VLIPI / :VLIPICOMPRA * 100 AS NUMERIC(4,2));
         ELSE
            PERCDEVOLVIDO = 100;
      END

      SEGURO = 0;
      MODDETBCICMS = 1;
      BCII = 0; /* IMPORTACAO */
      VLDESPADUANEIRAS = 0; /* IMPORTACAO */
      VLII = 0; /* IMPORTACAO */
      VLIOF = 0; /* IMPORTACAO */
      TPTRANSPIMP = 7; /* Rodoviaria */
      VLAFRMM = 0; /* Informar caso seja maritima (tptranspimp = 1) */
      TPINTERMEDIMP = '1'; /* Imp por conta propria */
      CNPJINTERMEDIMP = '';
      UFINTERMEDIMP = '';
      NRMSMOTIVOISENCAO = '';
      TXBIO = -1;
      INDIMPORTORIGCOMB = -1;
      CUFORIGCOMB = 0;
      TXORIGCOMB = 0;

      INDESCALA = 'S';
      CNPJFAB = '';
      CODIGOBENEFICIO = '';

      /* RELATIVO A EXPORTACAO */
      NREXP = '';
      CHAVENFEEXP = '';

      /* RELATIVO A SERVICO */
      BCISS = :VLTOTAL;

      IF (:INDTOT = '0') THEN
      BEGIN
         UNITARIO = 0;
         UNITARIOTRIB = 0;
         VLPRODUTO = 0;
         DESCONTO = 0;
         VLTOTAL = 0;
         TXREDBC = 0;
         BCICMS = 0;
         TXICMS = 0;
         VLICMS = 0;
         BCST = 0;
         VLST = 0;
         TXIPI = 0;
         VLIPI = 0;
         VLISS = 0;
         BCISS = 0;
         BCPIS = 0;
         TXPIS = 0;
         VLPIS = 0;
         BCCOFINS = 0;
         TXCOFINS = 0;
         VLCOFINS = 0;
         IF (:IDMDF = '65') THEN INDTOT = 1;
      END

      SUSPEND;
   END
END^

SET TERM ; ^
