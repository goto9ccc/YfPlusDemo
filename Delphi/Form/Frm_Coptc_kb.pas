unit Frm_Coptc_kb;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FrmBaseDBCrtlGrid, DB, ADODB, dbcgrids, ExtCtrls, StdCtrls,
  DBCtrls, ComCtrls;

type
  TFormCoptd_KB = class(TBaseCtrlGrid)
    dbtxtTD016: TDBText;
    dbtxtTD009: TDBText;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure dtpChange(Sender: TObject);
    procedure dbctrlgrd1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCoptd_KB: TFormCoptd_KB;

implementation

uses Frm_OpenSearch;



{$R *.dfm}

procedure TFormCoptd_KB.FormCreate(Sender: TObject);
begin
  inherited;
  qry.Close;
  qry.SQL.Text :=
           ' Select SUM(TD008-TD009) AS TD009,Right(TD013,2) TD013 ,TD013 as TD013A,Count(TD016) as TD016 '
           +' from COPTD Where TD016 = ''N'' AND TD013 Like '''
           + FormatDateTime('YYYYMM',Date) + '%'' and TD001 <> ''2204'' group by TD013';
  qry.Open;
  dtp.DateTime := Date();

end;

procedure TFormCoptd_KB.dtpChange(Sender: TObject);
begin
  inherited;
  qry.Close;
  qry.SQL.Text :=
           ' Select SUM(TD008-TD009) AS TD009,Right(TD013,2) TD013 ,TD013 as TD013A,Count(TD016) as TD016 '
           +' from COPTD Where TD016 = ''N'' AND TD013 Like '''
           + FormatDateTime('YYYYMM',dtp.Date) + '%'' and TD001 <> ''2204'' group by TD013';

  qry.Open;
end;

procedure TFormCoptd_KB.dbctrlgrd1DblClick(Sender: TObject);
var
  sSQL :string;

begin
    inherited;
      sSQL := 'SELECT COPMA.MA002 AS 客户简称,COPTC.TC001 AS 订单单别, COPTC.TC002 AS 订单单号, '
      + 'COPTD.TD003 AS 订单序号, CONVERT(datetime,COPTC.TC003) AS 订单日期,MOCTA.TA001 AS 工单单别, MOCTA.TA002 AS 工单单号,case MOCTA.TA003  when null then '''' else  CONVERT(datetime,MOCTA.TA003) end AS 工单日期,'
      + 'CASE MOCTA.TA011 WHEN ''1'' THEN ''未生产''  WHEN ''2'' THEN ''已领料'' WHEN ''3'' THEN ''生产中'' WHEN ''Y'' THEN ''已完工'' WHEN ''y'' then ''指定完工'' ELSE ''其他'' END AS 工单状况'
      + ' ,COPTD.TD016 订单状态,COPTD.TD004 AS 品号, INVMB.MB002 AS 品名, INVMB.MB003 AS 规格,COPTD.TD010 AS 计价单位,'
      + 'COPTD.TD008 AS 订单数量, COPTD.TD032 AS 订单重量, MOCTA.TA015 AS 工单数量,MOCTA.TA017 AS 已入库数量,  '
      + 'MOCTA.TA045 AS 工单重量, MOCTA.TA046 AS 已入库重量,COPTD.TD008-MOCTA.TA015 AS 预差数量,'
      +'COPTD.TD032-MOCTA.TA045 AS 预差数量,COPTD.TD008-MOCTA.TA017 AS 现差数量,COPTD.TD032-MOCTA.TA046 AS 现差重量,CONVERT(datetime,COPTD.TD013) AS 预交货日,datediff(day,getdate(),CONVERT(datetime,COPTD.TD013)) as 离交货日还有,COPTD.TD038 AS 税前金额, '
      + 'COPTD.TD038 + COPTD.TD039 AS 总价, COPTD.TD039 AS 税额, '
      + 'COPTD.TD011 AS 单价, CMSMV.MV002 AS 业务员, COPTD.TD020 备注 '
      + 'FROM COPTD INNER JOIN  '
      + 'COPTC ON COPTD.TD001 = COPTC.TC001 AND '
      + 'COPTD.TD002 = COPTC.TC002 left JOIN  '
      + 'COPMA ON COPTC.TC004 = COPMA.MA001 INNER JOIN  '
      + 'INVMB ON COPTD.TD004 = INVMB.MB001 LEFT OUTER JOIN  '
      + 'CMSMV ON COPTC.TC006 = CMSMV.MV001 LEFT OUTER JOIN  '
      + 'MOCTA ON COPTD.TD001 = MOCTA.TA026 AND COPTD.TD002 = MOCTA.TA027 AND '
      + 'COPTD.TD003 = MOCTA.TA028  where  TD016 = ''N'' and COPTD.TD013 = '''
                                    + qry.FieldByName('TD013A').AsString + ''' and TD001 <> ''2204''';
      FormOpenSearch := TFormOpenSearch.Create(nil,sSQL,'品名','规格','INVMB.MB002','INVMB.MB003');
      FormOpenSearch.qry.Open;
      FormOpenSearch.Caption := '超期订单明细';
      FormOpenSearch.ShowModal;
      FormOpenSearch.Free;

end;

end.
