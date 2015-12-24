unit Auth_Moduls;

interface

// 认证模块
// 在登录时或在第一次检查权限时，从服务器获取权限清单，减少数据库连接，缺点是权限修改后不能立刻生效。

uses
  SysUtils, Classes;

type
  TAuthModule = class(TDataModule)
  private
    { Private declarations }
    permission :String;  //权限串
  public
    { Public declarations }
    function checkPermission(permission:String):Boolean;
  end;

var
  AuthModule: TAuthModule;

implementation

{$R *.dfm}

{ TAuthModule }

function TAuthModule.checkPermission(permission: String): Boolean;
begin
  Result := True;
end;

end.
