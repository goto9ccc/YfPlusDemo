unit Frm_Pur;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FrmBaseDBCrtlGrid, DB, ADODB, DBCtrls, dbcgrids, ComCtrls,
  StdCtrls, ExtCtrls;

type
  TFormPur = class(TBaseCtrlGrid)
    rbTB: TRadioButton;
    rbTD: TRadioButton;
    lbl3: TLabel;
    dbtxtTD016: TDBText;
    lbl4: TLabel;
    dbtxtTD009: TDBText;
    lbl5: TLabel;
    lbl2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure rbTBClick(Sender: TObject);
    procedure rbTDClick(Sender: TObject);
    procedure dtp1Change(Sender: TObject);
    procedure dbctrlgrdDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Opendata();
  end;

var
  FormPur: TFormPur;

implementation

uses Frm_OpenSearch, Pur_Module;



{$R *.dfm}

procedure TFormPur.FormCreate(Sender: TObject);
begin
  inherited;
  DataModulePur := TDataModulePur.Create(Self);
  Opendata;
end;

procedure TFormPur.rbTBClick(Sender: TObject);
begin
  inherited;
  Opendata;
end;

procedure TFormPur.rbTDClick(Sender: TObject);
begin
  inherited;
  Opendata;
end;

procedure TFormPur.dtp1Change(Sender: TObject);
begin
  inherited;
  Opendata;
end;

procedure TFormPur.dbctrlgrdDblClick(Sender: TObject);
var
  sSQL:string;
begin
  inherited;
  if rbTB.Checked then
  begin
      sSQL :=   'SELECT PURTB.TB001 AS 单别, PURTB.TB002 AS 单号, PURTB.TB003 AS 序号, ' +
      ' PURTB.TB004 AS 品号,PURTB.TB005 AS 品名,PURTB.TB006 AS 规格,PURTB.TB009 数量,PURTB.TB011 需求日'+
     ' FROM PURTB ' +
     '  where TB039 <> ''Y'' AND TB039 <> ''y'' and PURTB.TB011 = '''
           + qry.FieldByName('TB011A').AsString + '''';
      FormOpenSearch := TFormOpenSearch.Create(Application,sSQL,'品名','规格'
      ,'PURTB.TB005','PURTB.TB006');
  end;

  if rbTD.Checked then
  begin
      sSQL :=   'SELECT PURTC.TC004 AS 供应商, PURMA.MA002 AS 简称, '
      +'CMSMV.MV002 AS 采购员, PURTD.TD002 AS 采购单号,'      + 'PURTD.TD003 AS 采购序号, PURTC.UDF01 AS 制造单号,'      +'PURTD.TD012 AS 预交货日, PURTD.TD004 AS 品号, '      + 'PURTD.TD005 AS 品名, PURTD.TD006 AS 规格, PURTD.TD015/PURTD.TD008 AS 百分比,'      + 'PURTD.TD008 AS 采购数量, PURTD.TD009 AS 单位,PURTD.TD015 AS 已交数量,'      + '(PURTD.TD008 - PURTD.TD015) AS 未交数量, DATEDIFF([day], GETDATE(), CONVERT(datetime, '      + 'PURTD.TD012)) AS 离交货日还有,PURTD.TD024 AS 来源单号, PURTD.TD014 AS 备注,  '      + 'PURTD.TD026 AS 请购单别, PURTD.TD027 AS 请购单号, PURTD.TD028 AS 请购序号 '      + 'FROM PURTD LEFT OUTER JOIN PURMA left JOIN  '      + 'PURTC ON PURMA.MA001 = PURTC.TC004 left JOIN  '      + 'CMSMV ON PURTC.TC011 = CMSMV.MV001 ON   '      + 'PURTD.TD001 = PURTC.TC001 AND PURTD.TD002 = PURTC.TC002 '      + 'WHERE (PURTD.TD018 = ''Y'') AND (PURTD.TD016 = ''N'') and PURTD.TD012='''
      + qry.FieldByName('TB011A').AsString + '''';
      FormOpenSearch := TFormOpenSearch.Create(Application,sSQL,'品名','规格'
      ,'PURTD.TD005','PURTD.TD006');
  end;
  FormOpenSearch.qry.Open;
  FormOpenSearch.Caption := '未交货明细';
  FormOpenSearch.ShowModal;
  FormOpenSearch.Free;

end;


procedure TFormPur.Opendata;
begin
  if rbTB.Checked then
     DataModulePur.OpenPurtb(FormatDateTime('yyyymm',Date))
  else
     DataModulePur.OpenPurtd(FormatDateTime('yyyymm',Date));
end;

end.

