unit Frm_Sfcta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FrmBaseDBCrtlGrid, DB, ADODB, DBCtrls, dbcgrids, ComCtrls,
  StdCtrls, ExtCtrls, Buttons;

type
  TFormSfcta = class(TBaseCtrlGrid)
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
  FormSfcta: TFormSfcta;

implementation

uses Frm_OpenSearch;

{$R *.dfm}

procedure TFormSfcta.dtp1Change(Sender: TObject);
begin
  inherited;
  OpenData;
end;

procedure TFormSfcta.dbctrlgrdDblClick(Sender: TObject);
var
  sSQL :string;

begin
    inherited;
      sSQL := ' Select MOCTA.TA001 ��������,MOCTA.TA002 ��������,convert(datetime,MOCTA.TA003) ��������,MOCTA.TA006 ��ƷƷ��,SFCTA.TA011/MOCTA.TA015 �ٷֱ�,MOCTA.TA015 Ԥ������, '
              +'MOCTA.TA015-SFCTA.TA011 AS ��Ƿ����,MOCTA.TA034 ��ƷƷ��,MOCTA.TA035 ��Ʒ���,'
            +'convert(datetime,SFCTA.TA008) as ������� '
           +' from SFCTA INNER JOIN MOCTA ON SFCTA.TA001 = MOCTA.TA001 AND '
           +' SFCTA.TA002 = MOCTA.TA002 Where  SFCTA.TA008 Like '''
           + qry.FieldByName('TA008A').AsString + '%'' AND SFCTA.TA004 LIKE ''%' + edtCMSMD.Text +'%'''
           + ' AND SFCTA.TA006 LIKE ''' + edtTA006.Text + '%'' '
           +' and MOCTA.TA015-SFCTA.TA011 > 0 ';
      FormOpenSearch := TFormOpenSearch.Create(Application,sSQL,'Ʒ��','���','MOCTA.TA034','MOCTA.TA035');
      FormOpenSearch.qry.Open;
      FormOpenSearch.Caption := '������ϸ';
      FormOpenSearch.ShowModal;
      FormOpenSearch.Free;

end;

procedure TFormSfcta.edtTA006KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
     OpenData;
  end;
end;

procedure TFormSfcta.OpenData;
begin
    if (Trim(edtCMSMD.Text) <> '') or (Trim(edtTA006.Text) <> '') then
    begin
      qry.Close;
      qry.SQL.Text :=
           ' Select SUM(MOCTA.TA015-SFCTA.TA011) AS TA011,Right(SFCTA.TA008,2) TA008 ,SFCTA.TA008 as TA008A,Count(SFCTA.TA003) as TA003 '
           +' from SFCTA INNER JOIN MOCTA ON SFCTA.TA001 = MOCTA.TA001 AND '
           +' SFCTA.TA002 = MOCTA.TA002 Where  SFCTA.TA008 Like '''
           + FormatDateTime('YYYYMM',dtp.Date)
           + '%'' AND SFCTA.TA004 LIKE ''%' + edtCMSMD.Text +'%'''
           + ' AND SFCTA.TA006 LIKE ''' + edtTA006.Text + '%'' '
           +' and MOCTA.TA015-SFCTA.TA011 > 0 Group by SFCTA.TA008';
      qry.Open;
    end;
end;

procedure TFormSfcta.btnTA006Click(Sender: TObject);
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

procedure TFormSfcta.btnTA005Click(Sender: TObject);
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
