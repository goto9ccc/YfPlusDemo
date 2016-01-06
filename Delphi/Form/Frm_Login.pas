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
    cbbDB: TComboBox;
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
     CommonModule.condbConnection(cbbDB.Text);
     CommonModule.SetLogin(True);
     CommonModule.SetLoginUser(edtUser.Text);

       configIni := TIniFile.Create(ExtractFilePath(Application.ExeName)+'config.ini');
       configIni.WriteString('Login','USER',edtUser.Text);
       ConfigIni.WriteInteger('Login','DataBase',cbbDB.ItemIndex);
       configIni.Free;

     Close;
  end
  else
  begin
    CommonModule.SetLogin(False);
    edtPassword.SetFocus;
    ShowMessage('µÇÂ¼Ê§°Ü');
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
       configIni := TIniFile.Create(ExtractFilePath(Application.ExeName)+'config.ini');
       edtUser.Text := configIni.ReadString('Login','USER','');
       edtPassword.Text := '';
       CommonModule.LoadComboBox('select MB002  from DSCMB  order by DSCMB.MB001',cbbDB,1);
       if cbbDB.Items.Count > 0 then
          cbbDB.ItemIndex := ConfigIni.ReadInteger('Login','DataBase',0);

       configIni.Free;

end;

end.
