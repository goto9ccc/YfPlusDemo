unit frm_Sfctc_kb;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FrmBaseDBCrtlGrid, DB, ADODB, DBCtrls, dbcgrids, ComCtrls,
  StdCtrls, ExtCtrls, Buttons;

type
  TFormSFCTC_KB = class(TBaseCtrlGrid)
    edtCMSMD: TEdit;
    lbl3: TLabel;
    lbl7: TLabel;
    dbtxtTD016: TDBText;
    lbl4: TLabel;
    dbtxtTD009: TDBText;
    lbl5: TLabel;
    lbl8: TLabel;
    edtTA006: TEdit;
    btnTA006: TSpeedButton;
    btnTA005: TSpeedButton;
    lbl2: TLabel;
    procedure dtp1Change(Sender: TObject);
    procedure dbctrlgrdDblClick(Sender: TObject);
    procedure edtTA006KeyPress(Sender: TObject; var Key: Char);
    procedure btnTA006Click(Sender: TObject);
    procedure btnTA005Click(Sender: TObject);
  private
    { Private declarations }
    procedure OpenData;
  public
    { Public declarations }
  end;

var
  FormSFCTC_KB: TFormSFCTC_KB;

implementation

uses Frm_OpenSearch;

{$R *.dfm}

procedure TFormSFCTC_KB.dtp1Change(Sender: TObject);
begin
  inherited;
  OpenData;
end;

procedure TFormSFCTC_KB.dbctrlgrdDblClick(Sender: TObject);
var
  sSQL :string;

begin
    inherited;
      sSQL := ' Select SFCTC.TC004 ��������,SFCTC.TC005 ��������,MOCTA.TA006 ��ƷƷ��, '
              +'MOCTA.TA034 ��ƷƷ��,MOCTA.TA035 ��Ʒ���,SFCTC.TC036 ת������,SFCTC.TC042 ת�ư�װ����,MOCTA.TA015 Ԥ������,SFCTA.TA011 �ۼƺϸ�ת��,MOCTA.TA026 ��������,MOCTA.TA027 ��������,convert(datetime,COPTD.TD013) Ԥ������,SFCTC.TC006 �Ƴ�����'

           +' from SFCTB INNER JOIN SFCTC ON SFCTB.TB001 = SFCTC.TC001 AND '
           +' SFCTB.TB002 = SFCTC.TC002 Left join MOCTA ON SFCTC.TC004 = MOCTA.TA001'
           +' AND SFCTC.TC005 = MOCTA.TA002 LEFT JOIN COPTD ON MOCTA.TA026 = COPTD.TD001 AND MOCTA.TA027 = COPTD.TD002 AND MOCTA.TA028 = COPTD.TD003 '
           +' left join SFCTA ON SFCTC.TC004 = SFCTA.TA001 AND SFCTC.TC005 = SFCTA.TA002 AND SFCTC.TC006 = SFCTA.TA003  '
           +' Where  SFCTB.TB015 Like '''
           + qry.FieldByName('TB003A').AsString
           + '%'' AND SFCTB.TB005 = ''' + edtTA006.Text
           + ''' AND SFCTC.TC007 Like ''%' + edtCMSMD.Text + '%''';
      FormOpenSearch := TFormOpenSearch.Create(Application,sSQL,'Ʒ��','���','MOCTA.TA034','MOCTA.TA035');
      FormOpenSearch.qry.Open;
      FormOpenSearch.Caption := 'ת����ϸ';
      FormOpenSearch.ShowModal;
      FormOpenSearch.Free;

end;

procedure TFormSFCTC_KB.edtTA006KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
     OpenData;
  end;
end;

procedure TFormSFCTC_KB.OpenData;
begin
    if (Trim(edtCMSMD.Text) <> '') or (Trim(edtTA006.Text) <> '') then
    begin
      qry.Close;
      qry.SQL.Text :=
           ' Select SUM(SFCTC.TC036) AS TC036,Right(SFCTB.TB015,2) TB003 ,SFCTB.TB015 as TB003A,Count(SFCTB.TB001) as TB001 '
           +' from SFCTB INNER JOIN SFCTC ON SFCTB.TB001 = SFCTC.TC001 AND '
           +' SFCTB.TB002 = SFCTC.TC002 Where  SFCTB.TB015 Like '''
           + FormatDateTime('YYYYMM',dtp.Date)
           + '%'' AND SFCTB.TB005 = ''' + edtTA006.Text
           + ''' AND SFCTC.TC007 Like ''%' + edtCMSMD.Text
           + '%''   Group by SFCTB.TB015 order by SFCTB.TB015';
      qry.Open;
    end;
end;

procedure TFormSFCTC_KB.btnTA006Click(Sender: TObject);
var
  sSQL :string;
begin
    inherited;
    sSQL := 'SELECT MD001,MD002 FROM CMSMD ';
    FormOpenSearch := TFormOpenSearch.Create(Application,sSQL,'�������ı��','������������','MD001','MD002');
    FormOpenSearch.qry.Open;
    FormOpenSearch.Caption := '���������嵥';
    FormOpenSearch.ShowModal;
    edtTA006.Text := FormOpenSearch.resultOne;
    FormOpenSearch.Free;
    OpenData;

end;

procedure TFormSFCTC_KB.btnTA005Click(Sender: TObject);
var
  sSQL :string;
begin
    inherited;
    sSQL := 'SELECT MW001,MW002 FROM CMSMW ';
    FormOpenSearch := TFormOpenSearch.Create(Application,sSQL,'���ձ��','��������','MW001','MW002');
    FormOpenSearch.qry.Open;
    FormOpenSearch.Caption := '�����嵥';
    FormOpenSearch.ShowModal;
    edtCMSMD.Text := FormOpenSearch.resultOne;
    FormOpenSearch.Free;
    OpenData;
end;

end.
