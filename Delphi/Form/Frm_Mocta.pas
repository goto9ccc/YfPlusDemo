unit Frm_Mocta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBaseSearch, ImgList, DB, ADODB, ComCtrls, ToolWin, GridsEh,
  DBGridEh, StdCtrls, ExtCtrls, Mask, DBCtrls, Buttons, Menus, RpRave,
  RpBase, RpSystem, RpDefine, RpCon, RpConDS,RVCsStd,RVClass;

type
  TForm_Mocta = class(TBaseSearchForm)
    lbl1: TLabel;
    edtMB002: TEdit;
    lbl2: TLabel;
    edtMB003: TEdit;
    dtpe: TDateTimePicker;
    lbl5: TLabel;
    dtpB: TDateTimePicker;
    lbl4: TLabel;
    edtTC002: TEdit;
    lbl3: TLabel;
    lbl6: TLabel;
    edtTA002: TEdit;
    lbl7: TLabel;
    cbbZT: TComboBox;
    qryrv: TADOQuery;
    rvcon: TRvDataSetConnection;
    rvprjct: TRvProject;
    pm: TPopupMenu;
    N1: TMenuItem;
    lbl17: TLabel;
    edtTA001: TEdit;
    rvsystm1: TRvSystem;
    procedure btnsearchClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgrdhDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure btnPrintClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
  private
    { Private declarations }
    procedure Generate2DCode(AStr: string; ASize: Integer; ABmp: TBitmap);
  public
    { Public declarations }
  end;

var
  Form_Mocta: TForm_Mocta;

implementation

uses  ECC200, Common_Module;

{$R *.dfm}

procedure TForm_Mocta.btnsearchClick(Sender: TObject);
VAR
  ssql :string;

begin
  inherited;

   ssql := 'SELECT MOCTA.TA001 AS 单别, MOCTA.TA002 AS 单号, CONVERT(datetime,MOCTA.TA003) AS 单据日期, ' +
      ' MOCTA.TA006 AS 品号, MOCTA.TA015 AS 工单数量, MOCTA.TA045 AS 工单包装数量,MOCTA.TA017 AS 已入库数量,MOCTA.TA017/MOCTA.TA015 百分比,'+
      'MOCTA.TA026 AS 订单单别, MOCTA.TA027 AS 订单单号, MOCTA.TA028 AS 订单序号,' +
     ' MOCTA.TA034 AS 品名, MOCTA.TA035 AS 规格, CASE MOCTA.TA011 WHEN ''1'' THEN ''未生产''  WHEN ''2'' THEN ''已领料'' WHEN ''3'' THEN ''生产中'' WHEN ''Y'' THEN ''已完工'' WHEN ''y'' then ''指定完工'' ELSE ''其他'' END AS 工单状况, ' +
     ' COPTD.TD008 AS 订单数量, COPTD.TD009 AS 已交数量, CONVERT(datetime,COPTD.TD013) 预交货日 ' +

     ' FROM MOCTA LEFT OUTER JOIN ' +
     ' COPTD ON MOCTA.TA026 = COPTD.TD001 AND MOCTA.TA027 = COPTD.TD002 AND' +
     ' MOCTA.TA028 = COPTD.TD003  '  +

     ' WHERE 1=1 '  ;
  if edtName.Text <> '' then
    ssql := ssql + ' AND MOCTA.TA006  like ''%' + edtName.Text + '%'' ';
  if edtMB002.Text <> '' then
    ssql := ssql + ' and MOCTA.TA034 Like ''%' + edtMB002.Text + '%'' ';
  if edtMB003.Text <> '' then
    ssql := ssql + ' and MOCTA.TA035 Like ''%' + edtMB003.Text + '%'' ';
  if edtTC002.Text <> '' then
    ssql := ssql + ' and COPTD.TD002 Like ''%' + edtTC002.Text + '%'' ';
  if edtTA002.Text <> '' then
    ssql := ssql + ' and MOCTA.TA002 Like ''%' + edtTA002.Text + '%'' ';
  if edtTA001.Text <> '' then
    ssql := ssql + ' and MOCTA.TA001 Like ''%' + edtTA001.Text + '%'' ';
  case cbbZT.ItemIndex of
      1 : ssql := ssql + ' AND MOCTA.TA011 = ''1'' ';
      2 : ssql := ssql + ' AND MOCTA.TA011 = ''2'' ';
      3 : ssql := ssql + ' AND MOCTA.TA011 = ''3'' ';
      4 : ssql := ssql + ' AND MOCTA.TA011 = ''Y'' ';
      5 : ssql := ssql + ' AND (MOCTA.TA011 = ''y'' or MOCAT.TA011 ISNULL) ';
  end;
  ssql := ssql + ' and MOCTA.TA003 >=''' + FormatDateTime('YYYYMMDD',dtpB.Date) + ''' and  MOCTA.TA003 <='''
  + FormatDateTime('YYYYMMDD',dtpe.Date) + ''' order by MOCTA.TA002';

  qry.Close;
  qry.SQL.Text := ssql;
    btnsearch.Enabled := False;
    Screen.Cursor := crHourGlass;
  qry.Open;
  btnsearch.Enabled := True;
  Screen.Cursor := crDefault;
   dbgrdh.FooterRowCount := 1;
   dbgrdh.SumList.Active := True;
end;

procedure TForm_Mocta.FormCreate(Sender: TObject);
begin
  inherited;
    dtpB.Date := Date-30;
    dtpe.Date := Date;
end;

procedure TForm_Mocta.dbgrdhDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  ProgressRect, ATextRect: TRect;
  DBGridEh: TDBGridEh;
  DataSet: TDataSet;
  Percent: Integer;
  PercentText: string;
begin
  inherited;
  DBGridEh := Sender as TDBGridEh;
  DataSet := DBGridEh.DataSource.DataSet;
  with DBGridEh.Canvas do
  begin
      if Column.FieldName = '百分比' then
      begin
        with DataSet do
          Percent := Round(FieldByName('已入库数量').AsInteger
            / FieldByName('工单数量').AsInteger * 100);
        ProgressRect := Rect;
        ProgressRect.Right  := ProgressRect.left + Round((ProgressRect.Right - ProgressRect.Left) * (Percent/100));
        Brush.Color := clWindow;
        Font.Color := clWindow;
        DBGridEh.DefaultDrawColumnCell(Rect, DataCol, Column, State);
        Brush.Color := $00FFCC00;//设置进度条颜色
        Font.Color := $00FFCC00;
        DBGridEh.DefaultDrawColumnCell(ProgressRect, DataCol, Column, State);
        PercentText := IntToStr(Percent) + '%';
        Brush.Style := bsClear;
        Font.Color := clBlack;
        with Rect do
        TextOut(Left + (Right-Left) div 2 -TextWidth(PercentText) div 2,
          Top+1, PercentText);//画出进度数字
      end;
   end;
end;

procedure TForm_Mocta.btnPrintClick(Sender: TObject);
var
  myBMP : TRaveBitmap;
  MyPage: TRavePage;
  bmp: TBitmap;

begin
  inherited;
  bmp := TBitmap.Create;
  Generate2DCode(Trim(qry.FieldByName('单别').AsString)+'-'+Trim(qry.FieldByName('单号').AsString)
                              +'-'+Trim(qry.FieldByName('品号').AsString),3,bmp);
  qryrv.Close;
  qryrv.SQL.Text := 'Select TA001,TA002,TA034,TA035,TA010,TA045,TA015,TA057 from MOCTA Where TA001 ='''
                  + qry.FieldByName('单别').AsString
                  + ''' AND TA002 = '''
                  + qry.FieldByName('单号').AsString
                  +'''';
  qryrv.Open;
  rvprjct.Close;
  rvprjct.ProjectFile :=  ExtractFilePath(Application.ExeName)+'\MOCBarcode.rav';
  rvprjct.Open;
  with rvprjct.ProjMan do
  begin
        MyPage := FindRaveComponent('Report1.Page1',nil) as TRavePage;  //查找PAGE
        myBMP := FindRaveComponent('Bitmap1',MyPage) as TRaveBitmap;
        myBMP.Image := bmp;
  end;
  FreeAndNil(bmp);
  rvprjct.Execute;
end;


procedure TForm_Mocta.Generate2DCode(AStr: string; ASize: Integer; ABmp: TBitmap);
var
    s : TByteArray;
    m : TByteArray;
    i, j: Integer;
    w, h : integer;
    cc: Integer;
begin
  if not Assigned(ABmp) then
      Exit;
  SetLength(s, Length(AStr));
  for i := 1 to Length(AStr) do
  begin
    s[i-1] := Ord(AStr[i]);
  end;
    // 此函数来自ECC200.pas
  CalcECC200(s, ecc200_Autosize, ecc200_Square, m, w, h);
  ABmp.Width := w * ASize;
  ABmp.Height := h * ASize;
  for i := 0 to h - 1 do
  begin
    for j := 0 to w - 1 do
    begin
      cc := m[i * w + j];
      if cc = 1 then
      begin
        ABmp.Canvas.Brush.Color := clBlack;
        ABmp.Canvas.Rectangle(Rect(
        j*ASize,
        i*ASize,
        j*ASize+ASize,
        i*ASize+ASize));
      end;
    end;
  end;
end;


procedure TForm_Mocta.N1Click(Sender: TObject);
begin
  inherited;
  btnPrint.Click;
end;

end.
