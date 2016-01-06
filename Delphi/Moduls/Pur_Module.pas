unit Pur_Module;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TDataModulePur = class(TDataModule)
    qry: TADOQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure OpenPurtb(date:string);
    procedure OpenPurtd(date:string);
  end;

var
  DataModulePur: TDataModulePur;

implementation

{$R *.dfm}

{ TDataModulePur }

procedure TDataModulePur.OpenPurtb(date: string);
begin
  qry.Close;
  qry.SQL.Text :=
           ' Select SUM(TB009) AS TB009,Right(TB011,2) TB011 ,TB011 as TB011A,Count(TB001) as TB001 '
           +' from PURTB Where TB039 = ''N'' AND TB011 Like '''
           + date + '%'' group by TB011';

  qry.Open;
end;

procedure TDataModulePur.OpenPurtd(date: string);
begin
  qry.Close;
  qry.SQL.Text :=
           ' Select SUM(TD008-TD015) AS TB009,Right(TD012,2) TB011 ,TD012 as TB011A,Count(TD001) as TB001 '
           +' from PURTD Where TD016 = ''N'' AND TD012 Like '''
           + date + '%'' group by TD012';
  qry.Open;
end;

end.
