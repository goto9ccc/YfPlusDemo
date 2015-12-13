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

uses Frm_OpenSearch;



{$R *.dfm}

procedure TFormPur.FormCreate(Sender: TObject);
begin
  inherited;
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
      sSQL :=   'SELECT PURTB.TB001 AS ����, PURTB.TB002 AS ����, PURTB.TB003 AS ���, ' +
      ' PURTB.TB004 AS Ʒ��,PURTB.TB005 AS Ʒ��,PURTB.TB006 AS ���,PURTB.TB009 ����,PURTB.TB011 ������'+
     ' FROM PURTB ' +
     '  where TB039 <> ''Y'' AND TB039 <> ''y'' and PURTB.TB011 = '''
                                    + qry.FieldByName('TB011A').AsString + '''';
      FormOpenSearch := TFormOpenSearch.Create(Application,sSQL,'Ʒ��','���'
      ,'PURTB.TB005','PURTB.TB006');
  end;

  if rbTD.Checked then
  begin
      sSQL :=   'SELECT PURTC.TC004 AS ��Ӧ��, PURMA.MA002 AS ���, '
      +'CMSMV.MV002 AS �ɹ�Ա, PURTD.TD002 AS �ɹ�����,'      + 'PURTD.TD003 AS �ɹ����, PURTC.UDF01 AS ���쵥��,'      +'PURTD.TD012 AS Ԥ������, PURTD.TD004 AS Ʒ��, '      + 'PURTD.TD005 AS Ʒ��, PURTD.TD006 AS ���, PURTD.TD015/PURTD.TD008 AS �ٷֱ�,'      + 'PURTD.TD008 AS �ɹ�����, PURTD.TD009 AS ��λ,PURTD.TD015 AS �ѽ�����,'      + '(PURTD.TD008 - PURTD.TD015) AS δ������, DATEDIFF([day], GETDATE(), CONVERT(datetime, '      + 'PURTD.TD012)) AS �뽻���ջ���,PURTD.TD024 AS ��Դ����, PURTD.TD014 AS ��ע,  '      + 'PURTD.TD026 AS �빺����, PURTD.TD027 AS �빺����, PURTD.TD028 AS �빺��� '      + 'FROM PURTD LEFT OUTER JOIN PURMA left JOIN  '      + 'PURTC ON PURMA.MA001 = PURTC.TC004 left JOIN  '      + 'CMSMV ON PURTC.TC011 = CMSMV.MV001 ON   '      + 'PURTD.TD001 = PURTC.TC001 AND PURTD.TD002 = PURTC.TC002 '      + 'WHERE (PURTD.TD018 = ''Y'') AND (PURTD.TD016 = ''N'') and PURTD.TD012='''
      + qry.FieldByName('TB011A').AsString + '''';
      FormOpenSearch := TFormOpenSearch.Create(Application,sSQL,'Ʒ��','���'
      ,'PURTD.TD005','PURTD.TD006');
  end;

      FormOpenSearch.qry.Open;
      FormOpenSearch.Caption := 'δ������ϸ';
      FormOpenSearch.ShowModal;
      FormOpenSearch.Free;
  
end;

procedure TFormPur.Opendata;
begin
  qry.Close;
  if rbTB.Checked then
    qry.SQL.Text :=
           ' Select SUM(TB009) AS TB009,Right(TB011,2) TB011 ,TB011 as TB011A,Count(TB001) as TB001 '
           +' from PURTB Where TB039 = ''N'' AND TB011 Like '''
           + FormatDateTime('YYYYMM',dtp.Date) + '%'' group by TB011';
  if rbTD.Checked then
    qry.SQL.Text :=
           ' Select SUM(TD008-TD015) AS TB009,Right(TD012,2) TB011 ,TD012 as TB011A,Count(TD001) as TB001 '
           +' from PURTD Where TD016 = ''N'' AND TD012 Like '''
           + FormatDateTime('YYYYMM',dtp.Date) + '%'' group by TD012';
  qry.Open;
end;

end.
