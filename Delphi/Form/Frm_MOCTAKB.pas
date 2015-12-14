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
    FormOpenSearch := TFormOpenSearch.Create(Application,sSQL,'工作中心编号','工作中心名称','MD001','MD002');
    FormOpenSearch.qry.Open;
    FormOpenSearch.Caption := '工作中心清单';
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
      sSQL :=   'SELECT MOCTA.TA001 AS 单别, MOCTA.TA002 AS 单号, convert(datetime,MOCTA.TA003) AS 单据日期, ' +
      ' MOCTA.TA006 AS 品号, TA017/TA015 百分比,MOCTA.TA015 AS 工单数量,TA017 完工量,TA015-TA017 AS 工单欠量, MOCTA.TA045 AS 预计包装数量,'+
      'MOCTA.TA026 AS 订单单别, MOCTA.TA027 AS 订单单号, MOCTA.TA028 AS 订单序号,' +
     ' MOCTA.TA034 AS 品名, MOCTA.TA035 AS 规格, CASE MOCTA.TA011 WHEN ''1'' THEN ''未生产''  WHEN ''2'' THEN ''已领料'' WHEN ''3'' THEN ''生产中'' WHEN ''Y'' THEN ''已完工'' WHEN ''y'' then ''指定完工'' ELSE ''其他'' END AS 工单状况, ' +
     ' COPTD.TD008 AS 订单数量, COPTD.TD009 AS 已交数量, CONVERT(datetime,COPTD.TD013) 预交货日' +
     ' FROM MOCTA LEFT OUTER JOIN ' +
     ' COPTD ON MOCTA.TA026 = COPTD.TD001 AND MOCTA.TA027 = COPTD.TD002 AND' +
     ' MOCTA.TA028 = COPTD.TD003 '  +

     '  where TA011 <> ''Y'' AND TA011 <> ''y'' and MOCTA.TA009 = '''
                                    + qry.FieldByName('TA009A').AsString + ''' AND TA021 = '''+ edtCMSMD.Text +'''';
      FormOpenSearch := TFormOpenSearch.Create(nil,sSQL,'品名','规格','MOCTA.TA034','MOCTA.TA035');
      FormOpenSearch.qry.Open;
      FormOpenSearch.Caption := '未完工工单明细';
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
    FormOpenSearch := TFormOpenSearch.Create(application,sSQL,'工作中心编号','工作中心名称','MD001','MD002');
    FormOpenSearch.qry.Open;
    FormOpenSearch.Caption := '工作中心清单';
    FormOpenSearch.ShowModal;
    edtCMSMD.Text := FormOpenSearch.resultOne;
    FormOpenSearch.Free;
    OpenData;

end;

end.
