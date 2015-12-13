unit Common_Module;

interface

uses
  SysUtils, Classes, DB, ADODB,IniFiles,Forms;

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

uses Frm_DbSet;

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
var
  ConfigIni : TIniFile;
  DB:string;
  host:string;
  user:string;
  dbPassword:string;
begin
  isLogin := False;
  ConfigIni := TIniFile.Create(ExtractFilePath(Application.ExeName)+'Config.ini');
  dbPassword := ConfigIni.ReadString('DB','dbPassword','');
  user := ConfigIni.ReadString('DB','user','sa');
  host := ConfigIni.ReadString('DB','host','192.168.1.1');
  DB := ConfigIni.ReadString('DB','DB','DSCSYS');
  ConfigIni.Free;
  conComm.ConnectionString := 'Provider=SQLOLEDB.1;Persist Security Info=False;'
                                    + 'User ID='+ user +';Initial Catalog=' + DB + ';PassWord='+ dbPassword+';'
                                    + 'Data Source=' + host ;
  try
    conComm.Open;
  except
    FormDBset := TFormDBset.Create(Application);
    FormDBset.ShowModal;
    FormDBset.free;
  end;



end;

end.
