
unit Invmc_Module;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TInvmc_DataModule = class(TDataModule)
    qryInvmc: TADOQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    function getNonDeliverySum(TD004:String):Currency;
    function getInTransit(TA006:String):Currency;
  end;

var
  Invmc_DataModule: TInvmc_DataModule;

implementation

uses Common_Module;

{$R *.dfm}

{ TInvmc_DataModule }

function TInvmc_DataModule.getInTransit(TA006: String): Currency;
begin
  if TA006 = '' then
   begin
     Result := 0;
   end;
  qryInvmc.Close;
  qryInvmc.SQL.Text := 'select TA006,SUM(TA015-TA017) TA015'
                            + ' from MOCTA '
                            + ' where TA006 ='''
                            + TA006
                            + ''' group by TA006';
  qryInvmc.Open;
   if qryInvmc.RecordCount > 0 then
      Result := qryInvmc.FieldByName('TA015').AsCurrency
   else
      Result := 0;
end;

function TInvmc_DataModule.getNonDeliverySum(TD004: String): Currency;
begin
   if TD004 = '' then
   begin
     Result := 0;
   end;
   qryInvmc.Close;
   qryInvmc.SQL.Text := 'select COPTD.TD004,SUM(COPTD.TD008-COPTD.TD009) TD008'
                            + ' from COPTD '
                            + ' left join CMSMC (NOLOCK)  on TD007=MC001'
                            + ' where COPTD.TD008+COPTD.TD024>COPTD.TD009+COPTD.TD025+COPTD.TD058 and COPTD.TD021=''Y'' and COPTD.TD016=''N''  and  '
                            + ' TD004='''
                            + TD004
                            + ''' group by TD004';
   qryInvmc.Open;
   if qryInvmc.RecordCount > 0 then
      Result := qryInvmc.FieldByName('TD008').AsCurrency
   else
      Result := 0;
end;

end.
