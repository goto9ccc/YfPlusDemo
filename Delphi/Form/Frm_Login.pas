unit Frm_Login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls, Buttons,IniFiles,BaseForm;

type
  TfrmLogin = class(TFormBase)
    imgbg: TImage;
    edtUser: TEdit;
    edtPassword: TEdit;
    btnLogin: TSpeedButton;
    btnClose: TSpeedButton;
    btnSetting: TSpeedButton;
    procedure btnCloseClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure imgbgMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure edtUserKeyPress(Sender: TObject; var Key: Char);
    procedure edtPasswordKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

uses LoginModule, Common_Module;



{$R *.dfm}

procedure TfrmLogin.btnCloseClick(Sender: TObject);
begin
  CommonModule.SetLogin(False);
  Close;
end;

procedure TfrmLogin.btnLoginClick(Sender: TObject);
var
  configIni:TIniFile;
begin
  Module_Login := TModule_Login.Create(Application);
  if Module_Login.checkLogin(edtUser.Text,edtPassword.Text) then
  begin
     CommonModule.SetLogin(True);
     try
       configIni := TIniFile.Create(ExtractFilePath(Application.ExeName)+'config.ini');
       configIni.WriteString('Login','USER',edtUser.Text);
     finally
       configIni.Free;
     end;
     Close;
  end
  else
  begin
    CommonModule.SetLogin(False);
    edtPassword.SetFocus;
    ShowMessage('��¼ʧ��');
  end;
  Module_Login.Free;
end;

procedure TfrmLogin.imgbgMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  SendMessage(Handle,WM_SYSCOMMAND,$F012,0);
end;

procedure TfrmLogin.edtUserKeyPress(Sender: TObject; var Key: Char);
begin
  
  if key = #13 then
    edtPassword.SetFocus;
end;

procedure TfrmLogin.edtPasswordKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    btnLogin.Click;
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
var
  configIni:TIniFile;
begin
     try
       configIni := TIniFile.Create(ExtractFilePath(Application.ExeName)+'config.ini');
       edtUser.Text := configIni.ReadString('Login','USER','');
       edtPassword.Text := '';

     finally
       configIni.Free;
     end;
end;

end.
