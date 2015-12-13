unit Base_Module;

interface

uses
  SysUtils, Classes;

type
  TBaseModule = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BaseModule: TBaseModule;

implementation

uses Common_Module;

{$R *.dfm}

end.
