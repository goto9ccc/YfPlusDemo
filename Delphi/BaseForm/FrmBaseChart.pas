unit FrmBaseChart;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, TeeProcs, TeEngine, Chart, DBChart, DB, ADODB, Menus;

type
  TFormBaseChart = class(TForm)
    dbcht: TDBChart;
    qry: TADOQuery;
    pm1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    dlgSave: TSaveDialog;
    procedure N3Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure N2Click(Sender: TObject);
    procedure qryAfterOpen(DataSet: TDataSet);
    procedure qryBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormBaseChart: TFormBaseChart;

implementation

uses Common_Module;

{$R *.dfm}

procedure TFormBaseChart.N3Click(Sender: TObject);
begin
  Close;
end;

procedure TFormBaseChart.N1Click(Sender: TObject);
begin
  Self.BorderStyle := bsNone;
  Self.WindowState := wsMaximized;
end;

procedure TFormBaseChart.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if   Key=VK_ESCAPE   then
    Close;
end;

procedure TFormBaseChart.N2Click(Sender: TObject);
begin
     IF dlgSave.Execute then
      Self.dbcht.SaveToBitmapFile(dlgSave.FileName);
end;

procedure TFormBaseChart.qryAfterOpen(DataSet: TDataSet);
begin
  Screen.Cursor := crDefault;
end;

procedure TFormBaseChart.qryBeforeOpen(DataSet: TDataSet);
begin
  Screen.Cursor := crHourGlass;
end;

end.
