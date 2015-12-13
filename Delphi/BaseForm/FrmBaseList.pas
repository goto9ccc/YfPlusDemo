unit FrmBaseList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, ADODB, GridsEh, DBGridEh,BaseForm;

type
  TBaseListForm = class(TFormBase)
    pnltop: TPanel;
    qry: TADOQuery;
    ds: TDataSource;
    dbgrdh: TDBGridEh;
    procedure dbgrdhDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BaseListForm: TBaseListForm;

implementation

uses Common_Module;



{$R *.dfm}

procedure TBaseListForm.dbgrdhDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  mRecNo:Integer;
begin
  With (Sender as TDBGridEh) do
  begin
    mRecNo:=DS.DataSet.RecNo;
    if NOT(gdSelected IN State) then
    begin
      if Odd(mRecNo) then
      begin
        Canvas.Brush.Color := $00F4DEDD;
      end
      else
      begin
        Canvas.Brush.Color :=$00F9FDFE;
      end;
    end;
   DefaultDrawColumnCell(Rect,DataCol,Column,State);   //кн╫УЁл
  end;

end;

procedure TBaseListForm.FormCreate(Sender: TObject);
begin
  if qry.SQL.Text <> '' then
     qry.Open;
end;



end.
