unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  Buttons, ssockets, RESTRequest4D;

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
    StatusBar1: TStatusBar;
    tsCff: TTabSheet;
    procedure bbCertClick(Sender: TObject);
    procedure bExecCffClick(Sender: TObject);
    procedure odCertShow(Sender: TObject);
  private

  public

  end;

var
  fmMain: TfmMain;

implementation

{$R *.lfm}

uses
  httpsend, blcksock, ssl_openssl, fpjson, jsonparser;

{ TfmMain }

function GetJSONFromAPI(const URL, CertFile, KeyPass: string): TJSONData;
var
  HTTP: THTTPSend;
  sResult: string;
  bOk: Boolean;
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

procedure OnGetSocketHandler(Sender : TObject; Const UseSSL : Boolean; Out AHandler : TSocketHandler);
begin
  AHandler:=nil;
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
    jsonData: TJSONData;
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

    // Ajustar certificados e URL da API
    //jsonData := GetJSONFromAPI(cbUrlCff.Text,eCertificado.Text,eSenhaCert.Text);
    //mmResposta.Lines.Text := jsonData.AsJSON;
      // Trabalhe com jsonData conforme necessidade

  except on e: Exception do
    mmResposta.Lines.Text := e.Message;
  end;
end;

procedure TfmMain.odCertShow(Sender: TObject);
begin
  odCert.InitialDir := ExtractFilePath(ParamStr(0));
end;

end.

