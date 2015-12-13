unit Frm_DbSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseForm,IniFiles, StdCtrls;

type
  TFormDbSet = class(TFormBase)
    btnSave: TButton;
    btnTest: TButton;
    edtDB: TEdit;
    lbl4: TLabel;
    lbl3: TLabel;
    edtPW: TEdit;
    lbl2: TLabel;
    edtUser: TEdit;
    lbl1: TLabel;
    edtHost: TEdit;
    procedure btnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormDbSet: TFormDbSet;

implementation

uses Common_Module;

{$R *.dfm}

procedure TFormDbSet.btnSaveClick(Sender: TObject);
var
  ConfigIni : TIniFile;
begin
  ConfigIni := TIniFile.Create(ExtractFilePath(Application.ExeName)+'Config.ini');
  ConfigIni.writestring('DB','dbPassword',edtPW.Text);
  ConfigIni.writestring('DB','user',edtUser.Text);
  ConfigIni.writestring('DB','host',edtHost.Text);
  ConfigIni.writestring('DB','DB',edtDB.Text);
  ConfigIni.Free;
  

end;

procedure TFormDbSet.FormCreate(Sender: TObject);
var
   ConfigIni :TIniFile;
begin
  ConfigIni := TIniFile.Create(ExtractFilePath(Application.ExeName)+'Config.ini');
  edtPW.Text := ConfigIni.ReadString('DB','dbPassword','');
  edtUser.Text := ConfigIni.ReadString('DB','user','sa');
  edtHost.Text := ConfigIni.ReadString('DB','host','192.168.15.1');
  edtDB.Text := ConfigIni.ReadString('DB','DB','DSCSYS');
  ConfigIni.Free;
end;

procedure TFormDbSet.btnTestClick(Sender: TObject);
begin
  inherited;
  btnSave.Click;
  CommonModule.GetSetting;
  if CommonModule.conCommConnection then
    Application.MessageBox('���ӳɹ�','�ɹ�')
  else
    Application.MessageBox('����ʧ��','��ʾ');
end;

end.
