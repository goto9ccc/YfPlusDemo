unit Auth_Moduls;

interface

// ��֤ģ��
// �ڵ�¼ʱ���ڵ�һ�μ��Ȩ��ʱ���ӷ�������ȡȨ���嵥���������ݿ����ӣ�ȱ����Ȩ���޸ĺ���������Ч��

uses
  SysUtils, Classes;

type
  TAuthModule = class(TDataModule)
  private
    { Private declarations }
    permission :String;  //Ȩ�޴�
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
