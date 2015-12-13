unit Common_Module;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TCommonModule = class(TDataModule)
    conComm: TADOConnection;
    conDb: TADOConnection;
    procedure DataModuleCreate(Sender: TObject);



  private
    { Private declarations }
     isLogin:Boolean;   //登录成功标志


  public
    { Public declarations }
    function Getlogin: Boolean;
    procedure SetLogin(const Value: Boolean);
  end;

var
  CommonModule: TCommonModule;

implementation

{$R *.dfm}

{ TCommonModule }

function TCommonModule.Getlogin: Boolean;
begin
   Result := islogin;
end;

procedure TCommonModule.SetLogin(const Value: Boolean);
begin
   isLogin := Value;
end;

procedure TCommonModule.DataModuleCreate(Sender: TObject);
begin
  isLogin := False;
end;

end.
