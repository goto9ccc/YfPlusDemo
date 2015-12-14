unit FrmBaseDBCrtlGrid;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, dbcgrids, DB, ADODB, DBCtrls, ComCtrls, StdCtrls;

type
  TBaseCtrlGrid = class(TForm)
    pnl1: TPanel;
    dbctrlgrd: TDBCtrlGrid;
    ds: TDataSource;
    qry: TADOQuery;
    lbl6: TLabel;
    dtp: TDateTimePicker;
    dbtxtTD013: TDBText;
    lblTitle: TLabel;
    procedure dbctrlgrdPaintPanel(DBCtrlGrid: TDBCtrlGrid;
      Index: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure qryBeforeOpen(DataSet: TDataSet);
    procedure qryAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BaseCtrlGrid: TBaseCtrlGrid;

implementation

uses Common_Module;


{$R *.dfm}

procedure TBaseCtrlGrid.dbctrlgrdPaintPanel(DBCtrlGrid: TDBCtrlGrid;
  Index: Integer);
var
    panelrect:trect;
begin
  dbctrlgrd.Canvas.Brush.Color:= $00FFE1CE;
  panelRect.TopLeft := Canvas.PenPos;
  panelRect.TopLeft.X:= panelRect.TopLeft.X+2;
  panelRect.TopLeft.y:= panelRect.TopLeft.y+2;
  panelRect.Bottom := dbctrlgrid.PanelHeight-2 ;
  panelRect.Right := dbctrlgrid.PanelWidth-2 ;
  dbctrlgrd.Canvas.FillRect(panelrect);
  DrawEdge(dbctrlgrd.canvas.Handle, PRect(@panelRect)^, BDR_RAISEDINNER, BF_RECT);

end;

procedure TBaseCtrlGrid.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if   Key=VK_ESCAPE   then
    Close;
end;

procedure TBaseCtrlGrid.FormCreate(Sender: TObject);
begin
  dtp.Date := Date;
  lblTitle.Left := (Self.Width - lblTitle.Width) div 2;
end;

procedure TBaseCtrlGrid.qryBeforeOpen(DataSet: TDataSet);
begin
  Screen.Cursor := crHourGlass;
end;

procedure TBaseCtrlGrid.qryAfterOpen(DataSet: TDataSet);
begin
  Screen.Cursor := crDefault;
end;

end.
