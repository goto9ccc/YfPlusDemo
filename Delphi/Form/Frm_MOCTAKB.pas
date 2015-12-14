unit Frm_MOCTAKB;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FrmBaseDBCrtlGrid, DB, ADODB, DBCtrls, dbcgrids, ComCtrls,
  StdCtrls, ExtCtrls, Menus, Buttons;

type
  TFormMOCTAKB = class(TBaseCtrlGrid)
    lbl3: TLabel;
    edtCMSMD: TEdit;
    lbl7: TLabel;
    dbtxtTD016: TDBText;
    lbl4: TLabel;
    dbtxtTD009: TDBText;
    lbl5: TLabel;
    pm1: TPopupMenu;
    N1: TMenuItem;
    lbl8: TLabel;
    btnTA033: TSpeedButton;
    procedure btn1Click(Sender: TObject);
    procedure dtp1Change(Sender: TObject);
    procedure dbctrlgrdDblClick(Sender: TObject);
    procedure btnTA033Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure OpenData();
  end;

var
  FormMOCTAKB: TFormMOCTAKB;

implementation

uses  Frm_OpenSearch;

{$R *.dfm}

procedure TFormMOCTAKB.btn1Click(Sender: TObject);
var
  sSQL :string;
begin
    inherited;
    sSQL := 'SELECT MD001,MD002 FROM CMSMD ';
    FormOpenSearch := TFormOpenSearch.Create(Application,sSQL,'�������ı��','������������','MD001','MD002');
    FormOpenSearch.qry.Open;
    FormOpenSearch.Caption := '���������嵥';
    FormOpenSearch.ShowModal;
    edtCMSMD.Text := FormOpenSearch.resultOne;
    FormOpenSearch.Free;
    OpenData;
end;

procedure TFormMOCTAKB.dtp1Change(Sender: TObject);
begin
  inherited;
  OpenData;
end;

procedure TFormMOCTAKB.dbctrlgrdDblClick(Sender: TObject);
var
  sSQL :string;
begin
    inherited;
      sSQL :=   'SELECT MOCTA.TA001 AS ����, MOCTA.TA002 AS ����, convert(datetime,MOCTA.TA003) AS ��������, ' +
      ' MOCTA.TA006 AS Ʒ��, TA017/TA015 �ٷֱ�,MOCTA.TA015 AS ��������,TA017 �깤��,TA015-TA017 AS ����Ƿ��, MOCTA.TA045 AS Ԥ�ư�װ����,'+
      'MOCTA.TA026 AS ��������, MOCTA.TA027 AS ��������, MOCTA.TA028 AS �������,' +
     ' MOCTA.TA034 AS Ʒ��, MOCTA.TA035 AS ���, CASE MOCTA.TA011 WHEN ''1'' THEN ''δ����''  WHEN ''2'' THEN ''������'' WHEN ''3'' THEN ''������'' WHEN ''Y'' THEN ''���깤'' WHEN ''y'' then ''ָ���깤'' ELSE ''����'' END AS ����״��, ' +
     ' COPTD.TD008 AS ��������, COPTD.TD009 AS �ѽ�����, CONVERT(datetime,COPTD.TD013) Ԥ������' +
     ' FROM MOCTA LEFT OUTER JOIN ' +
     ' COPTD ON MOCTA.TA026 = COPTD.TD001 AND MOCTA.TA027 = COPTD.TD002 AND' +
     ' MOCTA.TA028 = COPTD.TD003 '  +

     '  where TA011 <> ''Y'' AND TA011 <> ''y'' and MOCTA.TA009 = '''
                                    + qry.FieldByName('TA009A').AsString + ''' AND TA021 = '''+ edtCMSMD.Text +'''';
      FormOpenSearch := TFormOpenSearch.Create(nil,sSQL,'Ʒ��','���','MOCTA.TA034','MOCTA.TA035');
      FormOpenSearch.qry.Open;
      FormOpenSearch.Caption := 'δ�깤������ϸ';
      FormOpenSearch.ShowModal;
      FormOpenSearch.Free;

end;

procedure TFormMOCTAKB.OpenData;
begin
    if Trim(edtCMSMD.Text) <> '' then
    begin
      qry.Close;
      qry.SQL.Text :=
               ' Select SUM(TA015-TA017) AS TA015,Right(TA009,2) TA009 ,TA009 as TA009A,Count(TA009) as TA009B '
               +' from MOCTA  INNER JOIN INVMB ON MOCTA.TA006 = INVMB.MB001 LEFT JOIN CMSMD ON MOCTA.TA021 = CMSMD.MD001 ' +
               ' Where TA011 <> ''Y'' AND TA011 <> ''y''  AND TA009 Like '''
               + FormatDateTime('YYYYMM',dtp.Date)
               + '%'' AND TA021 = '''+ edtCMSMD.Text +''' group by TA009';
      qry.Open;
    end;
end;

procedure TFormMOCTAKB.btnTA033Click(Sender: TObject);
var
  sSQL :string;
begin
    inherited;
    sSQL := 'SELECT MD001,MD002 FROM CMSMD Where 1 = 1';
    FormOpenSearch := TFormOpenSearch.Create(application,sSQL,'�������ı��','������������','MD001','MD002');
    FormOpenSearch.qry.Open;
    FormOpenSearch.Caption := '���������嵥';
    FormOpenSearch.ShowModal;
    edtCMSMD.Text := FormOpenSearch.resultOne;
    FormOpenSearch.Free;
    OpenData;

end;

end.
