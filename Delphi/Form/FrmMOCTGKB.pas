unit FrmMOCTGKB;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FrmBaseDBCrtlGrid, DB, ADODB, DBCtrls, dbcgrids, ComCtrls,
  StdCtrls, ExtCtrls, Menus, Buttons;

type
  TMOCTGKBForm = class(TBaseCtrlGrid)
    lbl3: TLabel;
    edtCMSMD: TEdit;
    lbl7: TLabel;
    dbtxtTD016: TDBText;
    lbl4: TLabel;
    dbtxtTD009: TDBText;
    lbl5: TLabel;
    btnTA033: TSpeedButton;
    lbl2: TLabel;
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
  MOCTGKBForm: TMOCTGKBForm;

implementation

uses  FrmBOMME, FrmGatte, DMSys;

{$R *.dfm}

procedure TMOCTGKBForm.btn1Click(Sender: TObject);
var
  sSQL :string;
begin
    inherited;
    sSQL := 'SELECT MD001,MD002 FROM CMSMD ';
    BOMMESearchForm := TBOMMESearchForm.Create(nil,sSQL,'�������ı��','������������','MD001','MD002',1);
    BOMMESearchForm.qry.Open;
    BOMMESearchForm.Caption := '���������嵥';
    BOMMESearchForm.ShowModal;
    edtCMSMD.Text := BOMMESearchForm.r1;
    BOMMESearchForm.Free;
    OpenData;
end;

procedure TMOCTGKBForm.dtp1Change(Sender: TObject);
begin
  inherited;
  OpenData;
end;

procedure TMOCTGKBForm.dbctrlgrdDblClick(Sender: TObject);
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
                                    + qry.FieldByName('TA009A').AsString + ''' AND TF011 = '''+ edtCMSMD.Text +'''';
      BOMMESearchForm := TBOMMESearchForm.Create(nil,sSQL,'Ʒ��','���','TG005','TG006',0);
      BOMMESearchForm.qry.Open;
      BOMMESearchForm.Caption := '�깤�����ϸ';
      BOMMESearchForm.ShowModal;
      BOMMESearchForm.Free;

end;

procedure TMOCTGKBForm.OpenData;
begin
    if Trim(edtCMSMD.Text) <> '' then
    begin
      qry.Close;
      qry.SQL.Text :=
               ' Select SUM(TG013) AS TA015,Right(TF003,2) TA009 ,TF003 as TA009A,Count(TF003) as TA009B '
               +' from MOCTG  INNER JOIN MOCTF ON MOCTG.TG001 = TF001 AND TG002 = TF002 '
               +' LEFT JOIN CMSMD ON MOCTF.TF011 = CMSMD.MD001 ' +
               ' Where TF006 = ''Y''   AND TF003 Like '''
               + FormatDateTime('YYYYMM',dtp1.Date) + '%'' AND TF011 = '''+ edtCMSMD.Text +''' group by TF003';
      qry.Open;
    end;
end;

procedure TMOCTGKBForm.btnTA033Click(Sender: TObject);
var
  sSQL :string;
begin
    inherited;
    sSQL := 'SELECT MD001,MD002 FROM CMSMD Where 1 = 1';
    BOMMESearchForm := TBOMMESearchForm.Create(nil,sSQL,'�������ı��','������������','MD001','MD002',1);
    BOMMESearchForm.qry.Open;
    BOMMESearchForm.Caption := '���������嵥';
    BOMMESearchForm.ShowModal;
    edtCMSMD.Text := BOMMESearchForm.r1;
    BOMMESearchForm.Free;
    OpenData;

end;

end.
