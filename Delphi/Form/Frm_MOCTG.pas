unit Frm_MOCTG;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FrmBaseDBCrtlGrid, DB, ADODB, DBCtrls, dbcgrids, ComCtrls,
  StdCtrls, ExtCtrls, Menus, Buttons;

type
  TFormMoctg = class(TBaseCtrlGrid)
    lbl3: TLabel;
    edtCMSMD: TEdit;
    lbl7: TLabel;
    dbtxtTD016: TDBText;
    lbl4: TLabel;
    dbtxtTD009: TDBText;
    lbl5: TLabel;
    btnTA033: TSpeedButton;
    lbl2: TLabel;

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
  FormMoctg: TFormMoctg;

implementation

uses Frm_OpenSearch;



{$R *.dfm}



procedure TFormMoctg.dtp1Change(Sender: TObject);
begin
  inherited;
  OpenData;
end;

procedure TFormMoctg.dbctrlgrdDblClick(Sender: TObject);
var
  sSQL :string;
begin
    inherited;
      sSQL :=   ' Select TG004 Ʒ��,TG005 Ʒ��,TG006 ���,TG014 ��������,TG015 ��������,TG011 �������,TG012 ��������, ' +
      ' TG032 �ƻ�����,TG013 �ϸ�����,MB151 ��׼��ʱ,TG025 ����װ����,  '+
      'TG026 ���ϰ�װ����,TG033 �ƻ���װ����,TG027 �ϸ��װ���� ' +

     ' FROM MOCTG LEFT OUTER JOIN ' +
     ' MOCTF ON TG001 = TF001 AND TG002 = TF002' +
     ' LEFT JOIN INVMB  ON TG004 = MB001 '  +

     '  where TF006 = ''Y'' and TF003 = '''
                                    + qry.FieldByName('TA009A').AsString
                                    + ''' AND TF011 = '''+ edtCMSMD.Text +'''';
      FormOpenSearch := TFormOpenSearch.Create(Application,sSQL,'Ʒ��','���','TG005','TG006');
      FormOpenSearch.qry.Open;
      FormOpenSearch.Caption := '�깤�����ϸ';
      FormOpenSearch.ShowModal;
      FormOpenSearch.Free;

end;

procedure TFormMoctg.OpenData;
begin
    if Trim(edtCMSMD.Text) <> '' then
    begin
      qry.Close;
      qry.SQL.Text :=
               ' Select SUM(TG013) AS TA015,Right(TF003,2) TA009 ,TF003 as TA009A,Count(TF003) as TA009B '
               +' from MOCTG  INNER JOIN MOCTF ON MOCTG.TG001 = TF001 AND TG002 = TF002 '
               +' LEFT JOIN CMSMD ON MOCTF.TF011 = CMSMD.MD001 ' +
               ' Where TF006 = ''Y''   AND TF003 Like '''
               + FormatDateTime('YYYYMM',dtp.Date) + '%'' AND TF011 = '''
               + edtCMSMD.Text +''' group by TF003';
      qry.Open;
    end;
end;

procedure TFormMoctg.btnTA033Click(Sender: TObject);
var
  sSQL :string;
begin
    inherited;
    sSQL := 'SELECT MD001,MD002 FROM CMSMD Where 1 = 1';
    FormOpenSearch := TFormOpenSearch.Create(Application,sSQL,'�������ı��','������������','MD001','MD002');
    FormOpenSearch.qry.Open;
    FormOpenSearch.Caption := '���������嵥';
    FormOpenSearch.ShowModal;
    edtCMSMD.Text := FormOpenSearch.resultOne;
    FormOpenSearch.Free;
    OpenData;

end;

end.
