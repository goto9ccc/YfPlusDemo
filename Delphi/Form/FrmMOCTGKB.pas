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
    BOMMESearchForm := TBOMMESearchForm.Create(nil,sSQL,'工作中心编号','工作中心名称','MD001','MD002',1);
    BOMMESearchForm.qry.Open;
    BOMMESearchForm.Caption := '工作中心清单';
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
      sSQL :=   ' Select TG004 品号,TG005 品名,TG006 规格,TG014 工单单别,TG015 工单单号,TG011 入库数量,TG012 报废数量, ' +
      ' TG032 破坏数量,TG013 合格数量,MB151 标准工时,TG025 入库包装数量,  '+
      'TG026 报废包装数量,TG033 破坏包装数量,TG027 合格包装数量 ' +

     ' FROM MOCTG LEFT OUTER JOIN ' +
     ' MOCTF ON TG001 = TF001 AND TG002 = TF002' +
     ' LEFT JOIN INVMB  ON TG004 = MB001 '  +

     '  where TF006 = ''Y'' and TF003 = '''
                                    + qry.FieldByName('TA009A').AsString + ''' AND TF011 = '''+ edtCMSMD.Text +'''';
      BOMMESearchForm := TBOMMESearchForm.Create(nil,sSQL,'品名','规格','TG005','TG006',0);
      BOMMESearchForm.qry.Open;
      BOMMESearchForm.Caption := '完工入库明细';
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
    BOMMESearchForm := TBOMMESearchForm.Create(nil,sSQL,'工作中心编号','工作中心名称','MD001','MD002',1);
    BOMMESearchForm.qry.Open;
    BOMMESearchForm.Caption := '工作中心清单';
    BOMMESearchForm.ShowModal;
    edtCMSMD.Text := BOMMESearchForm.r1;
    BOMMESearchForm.Free;
    OpenData;

end;

end.
