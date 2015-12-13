program YfWin32;

uses
  Forms,
  Frm_Login in 'Form\Frm_Login.pas' {frmLogin},
  Common_Module in 'Moduls\Common_Module.pas' {CommonModule: TDataModule},
  Base_Module in 'Moduls\Base_Module.pas' {BaseModule: TDataModule},
  LoginModule in 'Moduls\LoginModule.pas' {Module_Login: TDataModule},
  ThreadFuntion in 'Unit\ThreadFuntion.pas',
  Frm_Main in 'Form\Frm_Main.pas' {FormMain},
  BaseForm in 'BaseForm\BaseForm.pas' {FormBase},
  FrmBaseChart in 'BaseForm\FrmBaseChart.pas' {FormBaseChart},
  Frm_DbSet in 'Form\Frm_DbSet.pas' {FormDbSet},
  Frm_DbConnMsg in 'Form\Frm_DbConnMsg.pas' {FormDbConnMsg},
  FrmBaseDBCrtlGrid in 'BaseForm\FrmBaseDBCrtlGrid.pas' {BaseCtrlGrid},
  FrmBaseList in 'BaseForm\FrmBaseList.pas' {BaseListForm},
  frmBaseSearch in 'BaseForm\frmBaseSearch.pas' {BaseSearchForm},
  uKingFilter in 'BaseForm\uKingFilter.pas' {KingFilter},
  FormColSelect in 'BaseForm\FormColSelect.pas' {FrmColSelect},
  Frm_OpenSearch in 'Form\Frm_OpenSearch.pas' {FormOpenSearch},
  Frm_Pur in 'Form\Frm_Pur.pas' {FormPur};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TCommonModule, CommonModule);
  frmLogin := TfrmLogin.Create(Application);
  frmLogin.ShowModal;
  if CommonModule.Getlogin then
  begin
    Application.CreateForm(TFormMain, FormMain);
    Application.Run;
  end
  else
    Application.Terminate;
end.
