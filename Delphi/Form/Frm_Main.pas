unit Frm_Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin,BaseForm, ImgList, ExtCtrls;

type
  TFormMain = class(TFormBase)
    statInfo: TStatusBar;
    clbr1: TCoolBar;
    tlb1: TToolBar;
    ilToolbar: TImageList;
    btnPur: TToolButton;
    btnMcota: TToolButton;
    btnCoptd: TToolButton;
    btnSfc: TToolButton;
    btn3: TToolButton;
    btnMoctg: TToolButton;
    btn5: TToolButton;
    btn6: TToolButton;
    btnInvmc: TToolButton;
    btn8: TToolButton;
    btnMocta: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure btnPurClick(Sender: TObject);
    procedure btnMcotaClick(Sender: TObject);
    procedure btnSfcClick(Sender: TObject);
    procedure btnCoptdClick(Sender: TObject);
    procedure btnMoctgClick(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btnInvmcClick(Sender: TObject);
    procedure btnMoctaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

uses Common_Module, Frm_Pur, Frm_MOCTAKB, frm_Sfctc_kb, Frm_Coptc_kb,
  Frm_MOCTG, Frm_Sfcta, Frm_Invmc, Frm_Mocta;

{$R *.dfm}

procedure TFormMain.FormCreate(Sender: TObject);
begin
  inherited;
  statInfo.Panels[0].Text := '服务器:'+ CommonModule.GetHost;
  statInfo.Panels[1].Text := '主数据库:' + CommonModule.GetSysDb;
  statInfo.Panels[2].Text := '帐套数据库:' + CommonModule.GetSelectorDb;
  statInfo.Panels[3].Text := '用户名:' + CommonModule.GetLoginUser;
end;

procedure TFormMain.btnPurClick(Sender: TObject);
begin
  inherited;
  FormPur := TFormPur.Create(Application);
  FormPur.ShowModal;
  FormPur.Free;
end;

procedure TFormMain.btnMcotaClick(Sender: TObject);
begin
  inherited;
  FormMOCTAKB := TFormMOCTAKB.Create(Application);
  FormMOCTAKB.ShowModal;
  FormMOCTAKB.Free;
end;

procedure TFormMain.btnSfcClick(Sender: TObject);
begin
  inherited;
  FormSfcta := TFormSfcta.Create(Application);
  FormSfcta.ShowModal;
  FormSfcta.Free;
end;

procedure TFormMain.btnCoptdClick(Sender: TObject);
begin
  inherited;
  FormCoptd_KB := TFormCoptd_KB.Create(Application);
  FormCoptd_KB.ShowModal;
  FormCoptd_KB.Free;
end;

procedure TFormMain.btnMoctgClick(Sender: TObject);
begin
  inherited;
  FormMoctg := TFormMoctg.Create(Application);
  FormMoctg.ShowModal;
  FormMoctg.Free;
end;

procedure TFormMain.btn3Click(Sender: TObject);
begin
  inherited;
  FormSFCTC_KB := TFormSFCTC_KB.Create(Application);
  FormSFCTC_KB.ShowModal;
  FormSFCTC_KB.Free;
end;

procedure TFormMain.btnInvmcClick(Sender: TObject);
begin
  inherited;
  FormInvmc := TFormInvmc.Create(Application);
  FormInvmc.ShowModal;
  FormInvmc.Free;
end;

procedure TFormMain.btnMoctaClick(Sender: TObject);
begin
  inherited;
  Form_Mocta := TForm_Mocta.Create(Application);
  Form_Mocta.ShowModal;
  Form_Mocta.Free;
end;

end.
