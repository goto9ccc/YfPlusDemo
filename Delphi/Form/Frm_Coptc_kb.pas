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
      sSQL := 'SELECT COPMA.MA002 AS �ͻ����,COPTC.TC001 AS ��������, COPTC.TC002 AS ��������, '
      + 'COPTD.TD003 AS �������, CONVERT(datetime,COPTC.TC003) AS ��������,MOCTA.TA001 AS ��������, MOCTA.TA002 AS ��������,case MOCTA.TA003  when null then '''' else  CONVERT(datetime,MOCTA.TA003) end AS ��������,'
      + 'CASE MOCTA.TA011 WHEN ''1'' THEN ''δ����''  WHEN ''2'' THEN ''������'' WHEN ''3'' THEN ''������'' WHEN ''Y'' THEN ''���깤'' WHEN ''y'' then ''ָ���깤'' ELSE ''����'' END AS ����״��'
      + ' ,COPTD.TD016 ����״̬,COPTD.TD004 AS Ʒ��, INVMB.MB002 AS Ʒ��, INVMB.MB003 AS ���,COPTD.TD010 AS �Ƽ۵�λ,'
      + 'COPTD.TD008 AS ��������, COPTD.TD032 AS ��������, MOCTA.TA015 AS ��������,MOCTA.TA017 AS ���������,  '
      + 'MOCTA.TA045 AS ��������, MOCTA.TA046 AS ���������,COPTD.TD008-MOCTA.TA015 AS Ԥ������,'
      +'COPTD.TD032-MOCTA.TA045 AS Ԥ������,COPTD.TD008-MOCTA.TA017 AS �ֲ�����,COPTD.TD032-MOCTA.TA046 AS �ֲ�����,CONVERT(datetime,COPTD.TD013) AS Ԥ������,datediff(day,getdate(),CONVERT(datetime,COPTD.TD013)) as �뽻���ջ���,COPTD.TD038 AS ˰ǰ���, '
      + 'COPTD.TD038 + COPTD.TD039 AS �ܼ�, COPTD.TD039 AS ˰��, '
      + 'COPTD.TD011 AS ����, CMSMV.MV002 AS ҵ��Ա, COPTD.TD020 ��ע '
      + 'FROM COPTD INNER JOIN  '
      + 'COPTC ON COPTD.TD001 = COPTC.TC001 AND '
      + 'COPTD.TD002 = COPTC.TC002 left JOIN  '
      + 'COPMA ON COPTC.TC004 = COPMA.MA001 INNER JOIN  '
      + 'INVMB ON COPTD.TD004 = INVMB.MB001 LEFT OUTER JOIN  '
      + 'CMSMV ON COPTC.TC006 = CMSMV.MV001 LEFT OUTER JOIN  '
      + 'MOCTA ON COPTD.TD001 = MOCTA.TA026 AND COPTD.TD002 = MOCTA.TA027 AND '
      + 'COPTD.TD003 = MOCTA.TA028  where  TD016 = ''N'' and COPTD.TD013 = '''
                                    + qry.FieldByName('TD013A').AsString + ''' and TD001 <> ''2204''';
      FormOpenSearch := TFormOpenSearch.Create(nil,sSQL,'Ʒ��','���','INVMB.MB002','INVMB.MB003');
      FormOpenSearch.qry.Open;
      FormOpenSearch.Caption := '���ڶ�����ϸ';
      FormOpenSearch.ShowModal;
      FormOpenSearch.Free;

end;

end.
