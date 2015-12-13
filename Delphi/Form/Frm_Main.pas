unit Frm_Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin,BaseForm, ImgList;

type
  TFormMain = class(TFormBase)
    statInfo: TStatusBar;
    clbr1: TCoolBar;
    tlb1: TToolBar;
    ilToolbar: TImageList;
    btnPur: TToolButton;
    btn1: TToolButton;
    btn2: TToolButton;
    btnSfc: TToolButton;
    btn3: TToolButton;
    btn4: TToolButton;
    btn5: TToolButton;
    btn6: TToolButton;
    btn7: TToolButton;
    btn8: TToolButton;
    btn9: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure btnPurClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

uses Common_Module, Frm_Pur;

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

end.
