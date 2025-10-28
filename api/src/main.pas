unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  Buttons, InterBaseUniProvider, Uni, ssockets, RESTRequest4D, fpjson,
  jsonparser, DB;

type

  { TfmMain }

  TfmMain = class(TForm)
    bConectar: TBitBtn;
    bbCert: TBitBtn;
    bExecCff: TBitBtn;
    cbUrlCff: TComboBox;
    eBD: TEdit;
    eCertificado: TEdit;
    eSenhaCert: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    mmResposta: TMemo;
    odCert: TOpenDialog;
    pcApi: TPageControl;
    qCstAJUSTECREDITO: TStringField;
    qCstCREDITOPRESUMIDOZFM: TStringField;
    qCstDESCRICAO: TStringField;
    qCstDIFERIMENTO: TStringField;
    qCstID: TStringField;
    qCstMONOFASICA: TStringField;
    qCstREDUCAO: TStringField;
    qCstTRANSFCREDITO: TStringField;
    qCstTRIBUTACAO: TStringField;
    StatusBar1: TStatusBar;
    tsCff: TTabSheet;
    dbCn: TUniConnection;
    qCst: TUniQuery;
    procedure bbCertClick(Sender: TObject);
    procedure bExecCffClick(Sender: TObject);
    procedure odCertShow(Sender: TObject);
  private
    procedure ContentProccess(Value: TJSONData);
  public

  end;

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

procedure TfmMain.bbCertClick(Sender: TObject);
begin
  if odCert.Execute then
  begin
    eCertificado.Text := odCert.FileName;
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
      ContentProccess(response.JSONValue);
    // Ajustar certificados e URL da API
    //jsonData := GetJSONFromAPI(cbUrlCff.Text,eCertificado.Text,eSenhaCert.Text);
    //mmResposta.Lines.Text := jsonData.AsJSON;
    //ContentProccess(jsonData);
      // Trabalhe com jsonData conforme necessidade

  except on e: Exception do
    mmResposta.Lines.Text := e.Message;
  end;
end;

procedure TfmMain.odCertShow(Sender: TObject);
begin
  odCert.InitialDir := ExtractFilePath(ParamStr(0));
end;

procedure TfmMain.ContentProccess(Value: TJSONData);
var cst, classTrib: TJSONObject;
    aClassTrib: TJSONArray;
    i, j: Integer;
begin
  if Value is TJSONArray then
  begin
    for i := 0 to (Value as TJSONArray).Count - 1 do
    begin
      cst := (Value as TJSONArray).Objects[i];
      qCst.Close;
      qCst.ParamByName('ID').Text := cst.Get('CST','');
      qCst.Open;
      if qCst.IsEmpty then
        qCst.Append
      else
        qCst.Edit;
      qCstID.Text := cst.Get('CST','');

      aClassTrib := cst.Get('classificacoesTributarias',TJSONArray.Create);
      for j := 0 to aClassTrib.Count - 1 do
      begin
        classTrib := aClassTrib.Objects[i];
        ShowMessage(classTrib.AsJSON);
      end;
    end;
  end;
end;

end.

