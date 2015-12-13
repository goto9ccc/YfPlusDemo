unit frmBaseSearch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FrmBaseList, ImgList, ComCtrls, ToolWin, DB, ADODB, GridsEh,
  DBGridEh, ExtCtrls, StdCtrls,DBGridEhImpExp, Buttons;

type
  TBaseSearchForm = class(TBaseListForm)
    clbr1: TCoolBar;
    tlb1: TToolBar;
    btnNew: TToolButton;
    btnedit: TToolButton;
    btndel: TToolButton;
    btn4: TToolButton;
    btnPrint: TToolButton;
    btnexit: TToolButton;
    il1: TImageList;
    btnOut: TToolButton;
    lblName: TLabel;
    edtName: TEdit;
    btnsearch: TButton;
    dlgSave: TSaveDialog;
    stat1: TStatusBar;
    procedure btnexitClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnOutClick(Sender: TObject);
    procedure edtNameKeyPress(Sender: TObject; var Key: Char);
    procedure qryAfterOpen(DataSet: TDataSet);
    procedure qryBeforeOpen(DataSet: TDataSet);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BaseSearchForm: TBaseSearchForm;

implementation

uses  uKingFilter, FormColSelect;

{$R *.dfm}

procedure TBaseSearchForm.btnexitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TBaseSearchForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then btnsearch.Click;
end;

procedure TBaseSearchForm.btnOutClick(Sender: TObject);
begin
  inherited;
  if qry.Active = False then
  begin
    Application.MessageBox('没有任何记录，请点击查询按纽查询记录再选择导出！','提示');
    exit;
  end;
  if qry.RecordCount < 1 then
  begin
    Application.MessageBox('没有任何记录，请修改查询条件查询后再选择导出！','提示');
    exit;
  end;
  if dlgSave.Execute then
    SaveDBGridEhToExportFile(TDBGridEhExportAsXLS,dbgrdh,dlgSave.FileName,True);
end;

procedure TBaseSearchForm.edtNameKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    btnsearch.Click;
end;

procedure TBaseSearchForm.qryAfterOpen(DataSet: TDataSet);
var
  i :Integer;
begin
  inherited;
  for i:=0 to dbgrdh.Columns.Count-1 do
    begin
      dbgrdh.Columns[i].OptimizeWidth;
      dbgrdh.Columns[i].Width := dbgrdh.Columns[i].Width + 10;
      dbgrdh.Columns[i].Title.TitleButton := True;
    end;
    Screen.Cursor := crDefault;
end;

procedure TBaseSearchForm.qryBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  Screen.Cursor := crHourGlass;
end;

procedure TBaseSearchForm.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i:Integer;
begin
  inherited;
  case Key of

    VK_F8 :
    begin
        if dbgrdh.DataSource.DataSet.Active then
          ShowFilterForm(dbgrdh.DataSource.DataSet);
    end;
    VK_F7 :
    begin
        if dbgrdh.DataSource.DataSet.Active then
          ShowGridColEditor(dbgrdh);
    end;
  end;
end;

end.
