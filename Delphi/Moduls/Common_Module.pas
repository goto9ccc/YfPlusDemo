unit Common_Module;

interface

uses
  SysUtils, Classes, DB, ADODB,IniFiles,Forms,StdCtrls;

type
  TCommonModule = class(TDataModule)
    conComm: TADOConnection;
    conDb: TADOConnection;
    procedure DataModuleCreate(Sender: TObject);



  private
    { Private declarations }
    isLogin:Boolean;   //登录成功标志
    DB:string;  //公用数据库名
    host:string;  //数据库主机名
    user:string;  //数据库用户名
    dbPassword:string;  //数据库密码
    selector_db:String;  //帐套数据库名
    loginUser:String;//登录用户


  public
    { Public declarations }
    function Getlogin: Boolean;
    function GetHost:String;
    function GetSysDb:String;
    function GetSelectorDb:string;
    procedure SetLoginUser(username:string);
    function GetLoginUser:string;
    function conCommConnection:Boolean;
    function condbConnection(dbName:String):Boolean;
    procedure SetLogin(const Value: Boolean);
    function GetSetting: Boolean;
    function LoadComboBox(const sSQL:String;crComboBox:TComboBox;IsClear :integer):boolean;
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
begin
  isLogin := False;
  GetSetting;
  if (Length(host) = 0) or (conCommConnection = False) then
  begin
    FormDBset := TFormDBset.Create(Application);
    FormDBset.ShowModal;
    FormDBset.free;
  end;
end;

function TCommonModule.conCommConnection: Boolean;
begin
  Result := True;
  conComm.ConnectionString := 'Provider=SQLOLEDB.1;Persist Security Info=False;'
                                    + 'User ID='
                                    + user
                                    + ';Initial Catalog='
                                    + DB + ';PassWord='
                                    + dbPassword+';'
                                    + 'Data Source='
                                    + host ;
  try
    conComm.Open;
    Result := True;
  except
    Result := False;
  end;
end;


function TCommonModule.LoadComboBox(const sSQL:String;crComboBox:TComboBox;IsClear :integer):boolean;
var
    qQuery:TADOQuery;
begin
    Result:=False;
    qQuery:=TADOQuery.Create(Application);
    qQuery.Connection := conComm;
    with qQuery do
    begin
      try
        if Active then Close;
        Sql.Clear;
        Sql.Add(sSql);
        Open;
        First;
        if IsClear =1 then
          crComboBox.Clear;
        while not eof do
        begin
          crComboBox.Items.Add(FieldS.FieldS[0].AsString);
          Next;
        end;
        Result:=True;
      finally
        if not Result then
          begin

          end;
        Close;
        qQuery.Free;
      end;
   end;
end;

function TCommonModule.condbConnection(dbName: String): Boolean;
var
  qQuery:TADOQuery;
begin
  Result := False;
  qQuery:=TADOQuery.Create(Application);
  qQuery.Connection := conComm;
  qQuery.SQL.Text := 'Select MB001,MB003 From DSCMB Where MB002 ='''
                              + dbName + '''';
  qQuery.Open;
  selector_db := qQuery.Fields[0].AsString;
  condb.ConnectionString := 'Provider=SQLOLEDB.1;Persist Security Info=False;'
                                    + 'User ID='
                                    + user
                                    +';Initial Catalog='
                                    + selector_db
                                    + ';PassWord='
                                    + dbPassword
                                    + ';Data Source='
                                    + host ;

  qQuery.Free;
  try
    condb.Open;
    Result := True;
  except

  end;  

end;

function TCommonModule.GetSetting: Boolean;
var
  ConfigIni : TIniFile;
begin
  Result := False;
  try
    ConfigIni := TIniFile.Create(ExtractFilePath(Application.ExeName)+'Config.ini');
    dbPassword := ConfigIni.ReadString('DB','dbPassword','');
    user := ConfigIni.ReadString('DB','user','');
    host := ConfigIni.ReadString('DB','host','');
    DB := ConfigIni.ReadString('DB','DB','');
    Result := True;
  finally
    ConfigIni.Free;
  end;
end;

function TCommonModule.GetHost: String;
begin
  Result := host;
end;

function TCommonModule.GetSysDb: String;
begin
  Result := DB;
end;

function TCommonModule.GetSelectorDb: string;
begin
  Result := selector_db;
end;

procedure TCommonModule.SetLoginUser(username: string);
begin
  loginUser := username;
end;

function TCommonModule.GetLoginUser: string;
begin
  Result := loginUser;
end;

end.
