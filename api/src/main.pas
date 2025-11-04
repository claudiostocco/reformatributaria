unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  Buttons, StrUtils, DateUtils, InterBaseUniProvider, Uni, ssockets, RESTRequest4D, fpjson,
  jsonparser, DB;

type

  { TfmMain }

  TfmMain = class(TForm)
    bbJsonFile: TBitBtn;
    bConectar: TBitBtn;
    bbCert: TBitBtn;
    bExecCff: TBitBtn;
    bExecJsonFile: TBitBtn;
    cbUrlCff: TComboBox;
    eBD: TEdit;
    eCertificado: TEdit;
    eJsonFile: TEdit;
    eSenhaCert: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    mmResposta: TMemo;
    odCert: TOpenDialog;
    odJson: TOpenDialog;
    pcApi: TPageControl;
    qClassTribNcm: TUniQuery;
    qClassTribANEXO: TSmallintField;
    qClassTribCREDITOPRESUMIDO: TStringField;
    qClassTribDESCRICAO: TStringField;
    qClassTribDFEASSOCIADO: TStringField;
    qClassTribESTORNOCREDITO: TStringField;
    qClassTribID: TStringField;
    qClassTribNcmID: TStringField;
    qClassTribNcmNCM: TStringField;
    qClassTribNcmVIGENCIAATE: TDateField;
    qClassTribNcmVIGENCIADE: TDateField;
    qClassTribREDUCAOBC: TStringField;
    qClassTribTIPOALIQUOTA: TStringField;
    qClassTribTRIBREGULAR: TStringField;
    qClassTribTXREDCBS: TFloatField;
    qClassTribTXREDIBS: TFloatField;
    qCstAJUSTECREDITO: TStringField;
    qCstCREDITOPRESUMIDOZFM: TStringField;
    qCstDESCRICAO: TStringField;
    qCstDIFERIMENTO: TStringField;
    qCstID: TStringField;
    qCstMONOFASICA: TStringField;
    qCstREDUCAO: TStringField;
    qCstTRANSFCREDITO: TStringField;
    qCstTRIBUTACAO: TStringField;
    stb: TStatusBar;
    tsFile: TTabSheet;
    tsCff: TTabSheet;
    dbCn: TUniConnection;
    qCst: TUniQuery;
    qClassTrib: TUniQuery;
    procedure bbJsonFileClick(Sender: TObject);
    procedure bCertClick(Sender: TObject);
    procedure bExecCffClick(Sender: TObject);
    procedure bExecJsonFileClick(Sender: TObject);
    procedure odCertShow(Sender: TObject);
    procedure odJsonShow(Sender: TObject);
  private
    function hasDFe(json: TJSONObject): String;
    procedure ProcessTheContent(Value: TJSONData);
    procedure ProcessTheFileContent(Value: TJSONData);
  public
  end;

const aDFe: Array of String = ('NFe','NFCe','CTe','CTeOS','BPe','NF3e','NFCom','NFSE','BPeTM','BPeTA','NFAg','NFSVIA','NFABI','NFGas','DERE');

var
  fmMain: TfmMain;

implementation

{$R *.lfm}

uses
  httpsend, blcksock, ssl_openssl;

{ TfmMain }

function GetJSONFromAPI(const URL, CertFile, KeyPass: string): TJSONData;
var
  HTTP: THTTPSend;
  sResult: string;
begin
  HTTP := THTTPSend.Create;
  try
    if (not CertFile.IsEmpty) and (not KeyPass.IsEmpty) then
    begin
      // Configura o certificado digital para autenticação cliente
      HTTP.Sock.SSL.CertCAFile := ''; // CA se necessário
      HTTP.Sock.SSL.PFXfile := CertFile;
      HTTP.Sock.SSL.KeyPassword := KeyPass;
      HTTP.Sock.SSL.SSLType := LT_TLSv1_2;
    end;

    if HTTP.HTTPMethod('GET', URL) then
    begin
      SetString(sResult, PAnsiChar(HTTP.Document.Memory), HTTP.Document.Size);
      if HTTP.ResultCode div 200 = 1 then
      begin
        Result := GetJSON(sResult);
      end else
        raise Exception.Create(IntToStr(HTTP.ResultCode)+' - '+sResult);
    end else
      raise Exception.Create('Erro ao acessar API: '+IntToStr(HTTP.ResultCode)+' - '+HTTP.ResultString);
  finally
    HTTP.Free;
  end;
end;

procedure TfmMain.bCertClick(Sender: TObject);
begin
  if odCert.Execute then
  begin
    eCertificado.Text := odCert.FileName;
  end;
end;

procedure TfmMain.bbJsonFileClick(Sender: TObject);
begin
  if odJson.Execute then
  begin
    eJsonFile.Text := odJson.FileName;
  end;
end;

procedure TfmMain.bExecCffClick(Sender: TObject);
var response: IResponse;
    //jsonData: TJSONData;
begin
  try
  response := TRequest.New
                      .BaseURL(cbUrlCff.Text)
                      .Accept('application/json')
                      .Certificate(eCertificado.Text,eSenhaCert.Text)
                      .Get;

  if response.StatusCode = 200 then
    begin
      mmResposta.Lines.Text := response.JSONValue.AsJSON;
    end else
      mmResposta.Lines.Text := response.Content;
      ProcessTheContent(response.JSONValue);
    // Ajustar certificados e URL da API
    //jsonData := GetJSONFromAPI(cbUrlCff.Text,eCertificado.Text,eSenhaCert.Text);
    //mmResposta.Lines.Text := jsonData.AsJSON;
    //ContentProccess(jsonData);
      // Trabalhe com jsonData conforme necessidade

  except on e: Exception do
    mmResposta.Lines.Text := e.Message;
  end;
end;

procedure TfmMain.bExecJsonFileClick(Sender: TObject);
var aValue: TJSONData;
    streamFile: TStringStream;
begin
  try
    if not ((eJsonFile.Text <> '') and (FileExists(eJsonFile.Text))) then
      raise Exception.Create('Arquivo JSON não encontrado!');

    try
      streamFile := TStringStream.Create;
      streamFile.LoadFromFile(eJsonFile.Text);
      aValue := GetJSON(streamFile);
    finally
      FreeAndNil(streamFile);
    end;
    try
      ProcessTheFileContent(aValue);
    finally
      FreeAndNil(aValue);
    end;
  except on e: Exception do
    mmResposta.Lines.Text := e.Message;
  end;
end;

procedure TfmMain.odCertShow(Sender: TObject);
begin
  odCert.InitialDir := ExtractFilePath(ParamStr(0));
end;

procedure TfmMain.odJsonShow(Sender: TObject);
begin
  odJson.InitialDir := ExtractFilePath(ParamStr(0));
end;

function TfmMain.hasDFe(json: TJSONObject): String;
var i: Integer;
begin
  Result := '';
  for i := 0 to Length(aDFe) - 1 do
    if json.Get('Ind'+aDFe[i],false) then
      Result := Result+IfThen(Result.IsEmpty,'',',')+aDFe[i];
end;

procedure TfmMain.ProcessTheContent(Value: TJSONData);
var cst, classTrib: TJSONObject;
    aClassTrib: TJSONArray;
    i, j: Integer;
    sCSTId, sClassTribId: String;
begin
  if Value is TJSONArray then
  begin
    for i := 0 to (Value as TJSONArray).Count - 1 do
    begin
      cst := (Value as TJSONArray).Objects[i];
      sCSTId := cst.Get('CST','');
      qCst.Close;
      qCst.ParamByName('ID').Text := sCSTId;
      qCst.Open;
      if qCst.IsEmpty then
        qCst.Append
      else
        qCst.Edit;
      qCstID.Text := sCSTId;
      qCstDESCRICAO.Text := cst.Get('DescricaoCST','');
      qCstTRIBUTACAO.Text := IfThen(cst.Get('IndIBSCBS',false),'S','N');
      qCstREDUCAO.Text := IfThen(cst.Get('IndRedBC',false),'B',IfThen(cst.Get('IndRedAliq',false),'A','N'));
      qCstTRANSFCREDITO.Text := IfThen(cst.Get('IndTransfCred',false),'S','N');
      qCstDIFERIMENTO.Text := IfThen(cst.Get('IndDif',false),'S','N');
      qCstMONOFASICA.Text := IfThen(cst.Get('IndIBSCBSMono',false),'S','N');
      qCstCREDITOPRESUMIDOZFM.Text := IfThen(cst.Get('IndCredPresIBSZFM',false),'S','N');
      qCstAJUSTECREDITO.Text := IfThen(cst.Get('IndAjusteCompet',false),'S','N');
      qCst.Post;
      qCst.Close;

      aClassTrib := cst.Get('classificacoesTributarias',TJSONArray.Create);
      for j := 0 to aClassTrib.Count - 1 do
      begin
        classTrib := aClassTrib.Objects[j];
        sClassTribId := classTrib.Get('cClassTrib','');
        qClassTrib.Close;
        qClassTrib.ParamByName('ID').Text := sClassTribId;
        qClassTrib.Open;
        if qClassTrib.IsEmpty then
          qClassTrib.Append
        else
          qClassTrib.Edit;
        qClassTribID.Text := sClassTribId;
        qClassTribDESCRICAO.Text := classTrib.Get('DescricaoClassTrib','');
        qClassTribTIPOALIQUOTA.Text := classTrib.Get('TipoAliquota','');
        qClassTribTXREDIBS.Value := classTrib.Get('pRedIBS',0.0);
        qClassTribTXREDCBS.Value := classTrib.Get('pRedCBS',0.0);
        qClassTribREDUCAOBC.Text := IfThen(classTrib.Get('IndRedutorBC',false),'S','N');
        qClassTribTRIBREGULAR.Text := IfThen(classTrib.Get('IndTribRegular',false),'S','N');
        qClassTribCREDITOPRESUMIDO.Text := IfThen(classTrib.Get('IndCredPresOper',false),'S','N');
        qClassTribESTORNOCREDITO.Text := IfThen(classTrib.Get('IndEstornoCred',false),'S','N');
        qClassTribDFEASSOCIADO.Text := hasDFe(classTrib);
        qClassTribANEXO.Value := classTrib.Get('Anexo',0);
        qClassTrib.Post;
        qClassTrib.Close;
      end;
    end;
  end;
end;

procedure TfmMain.ProcessTheFileContent(Value: TJSONData);
var cst, classTrib, anexo: TJSONObject;
    aClassTrib, aAnexos: TJSONArray;
    i, j, k: Integer;
    {sCSTId, }sClassTribId, sNCM: String;
    dTmp: TDateTime;
begin
  if Value is TJSONArray then
  begin
    for i := 0 to (Value as TJSONArray).Count - 1 do
    begin
      cst := (Value as TJSONArray).Objects[i];
      //sCSTId := cst.Get('Cst','');
      //qCst.Close;
      //qCst.ParamByName('ID').Text := sCSTId;
      //qCst.Open;
      //if qCst.IsEmpty then
      //  qCst.Append
      //else
      //  qCst.Edit;
      //qCstID.Text := sCSTId;
      //qCstDESCRICAO.Text := cst.Get('DescricaoCST','');
      //qCstTRIBUTACAO.Text := IfThen(cst.Get('IndIBSCBS',false),'S','N');
      //qCstREDUCAO.Text := IfThen(cst.Get('IndRedBC',false),'B',IfThen(cst.Get('IndRedAliq',false),'A','N'));
      //qCstTRANSFCREDITO.Text := IfThen(cst.Get('IndTransfCred',false),'S','N');
      //qCstDIFERIMENTO.Text := IfThen(cst.Get('IndDif',false),'S','N');
      //qCstMONOFASICA.Text := IfThen(cst.Get('IndIBSCBSMono',false),'S','N');
      //qCstCREDITOPRESUMIDOZFM.Text := IfThen(cst.Get('IndCredPresIBSZFM',false),'S','N');
      //qCstAJUSTECREDITO.Text := IfThen(cst.Get('IndAjusteCompet',false),'S','N');
      //qCst.Post;
      //qCst.Close;

      aClassTrib := cst.Get('ClassificacoesTributarias',TJSONArray.Create);
      for j := 0 to aClassTrib.Count - 1 do
      begin
        classTrib := aClassTrib.Objects[j];
        sClassTribId := classTrib.Get('CodClassTrib','');
        //qClassTrib.Close;
        //qClassTrib.ParamByName('ID').Text := sClassTribId;
        //qClassTrib.Open;
        //if qClassTrib.IsEmpty then
        //  qClassTrib.Append
        //else
        //  qClassTrib.Edit;
        //qClassTribID.Text := sClassTribId;
        //qClassTribDESCRICAO.Text := classTrib.Get('DescricaoClassTrib','');
        //qClassTribTIPOALIQUOTA.Text := classTrib.Get('TipoAliquota','');
        //qClassTribTXREDIBS.Value := classTrib.Get('pRedIBS',0.0);
        //qClassTribTXREDCBS.Value := classTrib.Get('pRedCBS',0.0);
        //qClassTribREDUCAOBC.Text := IfThen(classTrib.Get('IndRedutorBC',false),'S','N');
        //qClassTribTRIBREGULAR.Text := IfThen(classTrib.Get('IndTribRegular',false),'S','N');
        //qClassTribCREDITOPRESUMIDO.Text := IfThen(classTrib.Get('IndCredPresOper',false),'S','N');
        //qClassTribESTORNOCREDITO.Text := IfThen(classTrib.Get('IndEstornoCred',false),'S','N');
        //qClassTribDFEASSOCIADO.Text := hasDFe(classTrib);
        //qClassTribANEXO.Value := classTrib.Get('Anexo',0);
        //qClassTrib.Post;
        //qClassTrib.Close;
        aAnexos := classTrib.Get('Anexos',TJSONArray.Create);
        for k := 0 to aAnexos.Count - 1 do
        begin
          anexo := aAnexos.Objects[k];
          sNCM := anexo.Get('CodNcmNbs','');
          if sNCM.Length = 8 then
          begin
            qClassTribNcm.Close;
            qClassTribNcm.ParamByName('ID').Text := sClassTribId;
            qClassTribNcm.ParamByName('NCM').Text := sNCM;
            qClassTribNcm.Open;
            if qClassTribNcm.IsEmpty then
              qClassTribNcm.Append
            else
              qClassTribNcm.Edit;
            qClassTribNcmID.Text := sClassTribId;
            qClassTribNcmNCM.Text := sNCM;
            dTmp := ISO8601ToDateDef(anexo.Get('DthIniVig',''),0);
            if dTmp > 0 then
              qClassTribNcmVIGENCIADE.Value := dTmp
            else
              qClassTribNcmVIGENCIADE.Clear;

            dTmp := ISO8601ToDateDef(anexo.Get('DthFimVig',''),0);
            if dTmp > 0 then
              qClassTribNcmVIGENCIAATE.Value := dTmp
            else
              qClassTribNcmVIGENCIAATE.Clear;

            qClassTribNcm.Post;
            qClassTribNcm.Close;
            stb.Panels[0].Text := 'Progresso --> Id: '+sClassTribId+'  NCM: '+sNCM;
          end;
        end;
        Application.ProcessMessages;
      end;
    end;
  end;
end;

end.

