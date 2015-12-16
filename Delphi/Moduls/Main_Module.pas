unit Main_Module;

interface

uses
  SysUtils, Classes, DB, ADODB,Forms;

type
  TMainModule = class(TDataModule)
    qryMain: TADOQuery;
  private
    { Private declarations }
  public
    { Public declarations }

    procedure getCoptg();
  end;

var
  MainModule: TMainModule;

implementation

uses Common_Module;

{$R *.dfm}

{ TMainModule }

procedure TMainModule.getCoptg;
begin
    qryMain.Close;
    qryMain.SQL.Text := 'Select Convert(datetime,TG003) ÈÕÆÚ,sum(TH013) ½ð¶î from COPTH '
                    + '  LEFT JOIN COPTG on TH001=TG001 AND TH002=TG002 Where TG003 like '
                    + ' left(CONVERT(varchar(100), GETDATE(), 112),6)+'
                    + '''%''  Group by TG003 order by TG003 ';
    qryMain.Open;
end;



end.
