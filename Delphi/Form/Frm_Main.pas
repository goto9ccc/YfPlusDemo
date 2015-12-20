unit Frm_Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin,BaseForm, ImgList, ExtCtrls, TeEngine, Series,
  TeeProcs, Chart, DBChart, Menus;

type
  TFormMain = class(TFormBase)
    statInfo: TStatusBar;
    clbrMain: TCoolBar;
    tlb1: TToolBar;
    ilToolbar: TImageList;
    btnPur: TToolButton;
    btnMcota: TToolButton;
    btnCoptd: TToolButton;
    btnSfc: TToolButton;
    btn3: TToolButton;
    btnMoctg: TToolButton;
    btn5: TToolButton;
    btnInvmc: TToolButton;
    btnMocta: TToolButton;
    dbcht: TDBChart;
    MainSeries: TBarSeries;
    pmChart: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure btnPurClick(Sender: TObject);
    procedure btnMcotaClick(Sender: TObject);
    procedure btnSfcClick(Sender: TObject);
    procedure btnCoptdClick(Sender: TObject);
    procedure btnMoctgClick(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btnInvmcClick(Sender: TObject);
    procedure btnMoctaClick(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

uses Common_Module, Frm_Pur, Frm_MOCTAKB, frm_Sfctc_kb, Frm_Coptc_kb,
  Frm_MOCTG, Frm_Sfcta, Frm_Invmc, Frm_Mocta, Main_Module, FrmBaseChart;

{$R *.dfm}

procedure TFormMain.FormCreate(Sender: TObject);
begin
  inherited;
  statInfo.Panels[0].Text := '服务器:'+ CommonModule.GetHost;
  statInfo.Panels[1].Text := '主数据库:' + CommonModule.GetSysDb;
  statInfo.Panels[2].Text := '帐套数据库:' + CommonModule.GetSelectorDb;
  statInfo.Panels[3].Text := '用户名:' + CommonModule.GetLoginUser;
  MainModule := TMainModule.Create(Application);
  MainModule.getCoptg;
  dbcht.Title.Text.Text := '本月销售额柱形图';
  MainSeries.XValues.ValueSource := '日期';
  MainSeries.XValues.DateTime:=True;
  MainSeries.yValues.ValueSource := '金额';

end;

procedure TFormMain.btnPurClick(Sender: TObject);
begin
  inherited;
  FormPur := TFormPur.Create(Application);
  FormPur.ShowModal;
  FormPur.Free;
end;

procedure TFormMain.btnMcotaClick(Sender: TObject);
begin
  inherited;
  FormMOCTAKB := TFormMOCTAKB.Create(Application);
  FormMOCTAKB.ShowModal;
  FormMOCTAKB.Free;
end;

procedure TFormMain.btnSfcClick(Sender: TObject);
begin
  inherited;
  FormSfcta := TFormSfcta.Create(Application);
  FormSfcta.ShowModal;
  FormSfcta.Free;
end;

procedure TFormMain.btnCoptdClick(Sender: TObject);
begin
  inherited;
  FormCoptd_KB := TFormCoptd_KB.Create(Application);
  FormCoptd_KB.ShowModal;
  FormCoptd_KB.Free;
  
end;

procedure TFormMain.btnMoctgClick(Sender: TObject);
begin
  inherited;
  FormMoctg := TFormMoctg.Create(Application);
  FormMoctg.ShowModal;
  FormMoctg.Free;
end;

procedure TFormMain.btn3Click(Sender: TObject);
begin
  inherited;
  FormSFCTC_KB := TFormSFCTC_KB.Create(Application);
  FormSFCTC_KB.ShowModal;
  FormSFCTC_KB.Free;
end;

procedure TFormMain.btnInvmcClick(Sender: TObject);
begin
  inherited;
  FormInvmc := TFormInvmc.Create(Application);
  FormInvmc.ShowModal;
  FormInvmc.Free;
end;

procedure TFormMain.btnMoctaClick(Sender: TObject);
begin
  inherited;
  Form_Mocta := TForm_Mocta.Create(Application);
  Form_Mocta.ShowModal;
  Form_Mocta.Free;
end;

procedure TFormMain.btn5Click(Sender: TObject);
begin
  inherited;
  Application.MessageBox('请点击下拉箭头选择示例','提示')
end;

procedure TFormMain.N2Click(Sender: TObject);
var
  bar :TBarSeries;
begin
  inherited;
  FormBaseChart := TFormBaseChart.Create(Application);
  FormBaseChart.Caption := '柱状图演示';
  FormBaseChart.qry.SQL.Text :=  'Select Convert(datetime,TG003) 日期,sum(TH013) 金额 from COPTH '
                    + '  LEFT JOIN COPTG on TH001=TG001 AND TH002=TG002 Where TG003 like '
                    + ' left(CONVERT(varchar(100), GETDATE(), 112),6)+'
                    + '''%''  Group by TG003 order by TG003 ';
  FormBaseChart.qry.Open;
  FormBaseChart.dbcht.Title.Text.Clear;
  FormBaseChart.dbcht.Title.Text.Add('柱状图演示');
  FormBaseChart.dbcht.Title.Text.Add('当月销售');



  bar := TBarSeries.Create(Application);
  bar.ParentChart := FormBaseChart.dbcht;
  bar.DataSource := FormBaseChart.qry;
  bar.XValues.ValueSource := '日期';
  bar.XValues.DateTime:=True;
  bar.yValues.ValueSource := '金额';
  FormBaseChart.ShowModal;
  bar.Free;
  FormBaseChart.Free;

end;

procedure TFormMain.N1Click(Sender: TObject);
var
  pie :TPieSeries;
begin
  inherited;
  FormBaseChart := TFormBaseChart.Create(Application);
  FormBaseChart.Caption := '柱状图演示';
  FormBaseChart.qry.SQL.Text :=  'Select MV002 业务员,sum(TH013) 金额 from COPTH '
                    +'LEFT JOIN COPTG on TH001=TG001 AND TH002=TG002  '
                    + ' LEFT JOIN CMSMV ON TG006 = MV001 '
                    +' Where TG003 like left(CONVERT(varchar(100), GETDATE(), 112),6)+''%'' '
                    + ' Group by MV002 order by sum(TH013) desc ';
  FormBaseChart.qry.Open;
  FormBaseChart.dbcht.Title.Text.Clear;
  FormBaseChart.dbcht.Title.Text.Add('饼状图演示');
  FormBaseChart.dbcht.Title.Text.Add('当月业务员销售业绩');

  pie := TPieSeries.Create(Application);
  pie.ParentChart := FormBaseChart.dbcht;
  pie.DataSource := FormBaseChart.qry;
  pie.XLabelsSource := '业务员';
  pie.yValues.ValueSource := '金额';
  FormBaseChart.ShowModal;
  pie.Free;
  FormBaseChart.Free;
end;

procedure TFormMain.N3Click(Sender: TObject);
var
  line :TLineSeries;
begin
  inherited;
  FormBaseChart := TFormBaseChart.Create(Application);
  FormBaseChart.Caption := '折线图演示';
  FormBaseChart.qry.SQL.Text :=  'Select Convert(datetime,TG003) 日期,sum(TH013) 金额 from COPTH '
                    + '  LEFT JOIN COPTG on TH001=TG001 AND TH002=TG002 Where TG003 like '
                    + ' left(CONVERT(varchar(100), GETDATE(), 112),6)+'
                    + '''%''  Group by TG003 order by TG003 ';
  FormBaseChart.qry.Open;
  FormBaseChart.dbcht.Title.Text.Clear;
  FormBaseChart.dbcht.Title.Text.Add('折线图演示');
  FormBaseChart.dbcht.Title.Text.Add('当月销售');



  line := TLineSeries.Create(Application);
  line.ParentChart := FormBaseChart.dbcht;
  line.DataSource := FormBaseChart.qry;
  line.XValues.ValueSource := '日期';
  line.XValues.DateTime:=True;
  line.yValues.ValueSource := '金额';
  FormBaseChart.ShowModal;
  line.Free;
  FormBaseChart.Free;

end;

procedure TFormMain.N4Click(Sender: TObject);
var
  hBar :THorizBarSeries;
begin
  inherited;
  FormBaseChart := TFormBaseChart.Create(Application);
  FormBaseChart.Caption := '横道图演示';
  FormBaseChart.qry.SQL.Text :=  'Select TOP 10 MA002 客户,sum(TH013) 金额 from COPTH '
                    +' LEFT JOIN COPTG on TH001=TG001 AND TH002=TG002'
                    + ' LEFT JOIN COPMA ON COPTG.TG004 = COPMA.MA001  '
                    + '  Where TG003 like left(CONVERT(varchar(100), GETDATE(), 112),4)+''%'''
                    +' Group by MA002 order by sum(TH013) desc ';
  FormBaseChart.qry.Open;
  FormBaseChart.dbcht.Title.Text.Clear;
  FormBaseChart.dbcht.Title.Text.Add('横道图演示');
  FormBaseChart.dbcht.Title.Text.Add('本年客户TOP10');



  hBar := THorizBarSeries.Create(Application);
  hBar.ParentChart := FormBaseChart.dbcht;
  hBar.DataSource := FormBaseChart.qry;
  hBar.XLabelsSource := '客户';
  hBar.yValues.ValueSource := '金额';
  FormBaseChart.ShowModal;
  hBar.Free;
  FormBaseChart.Free;

end;

end.
