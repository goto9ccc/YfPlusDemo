unit FrmINVMC;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBaseSearch, ImgList, DB, ADODB, ComCtrls, ToolWin, GridsEh,
  DBGridEh, StdCtrls, ExtCtrls, Buttons, Menus;

type
  TINVMCForm = class(TBaseSearchForm)
    edtMB003: TEdit;
    lbl1: TLabel;
    btn1: TButton;
    lbl2: TLabel;
    edtMC002: TEdit;
    btnMC002: TButton;
    lblMC002: TLabel;
    lbl3: TLabel;
    edtYS: TEdit;
    lbl4: TLabel;
    edtky: TEdit;
    lbl5: TLabel;
    edtzt: TEdit;
    pm1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    chk1: TCheckBox;
    edtMB001: TEdit;
    lbl6: TLabel;
    btn3: TToolButton;
    btn2: TToolButton;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    procedure btnMC002Click(Sender: TObject);
    procedure btnsearchClick(Sender: TObject);
    procedure dbgrdhDblClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure dbgrdhDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure btn3Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
   INVMCForm: TINVMCForm;

implementation


{$R *.dfm}

procedure TINVMCForm.btnMC002Click(Sender: TObject);
VAR
  sSQL:String;
begin
  inherited;
    sSQL := 'SELECT MC001 仓库编号,MC002 仓库名称 from CMSMC Where 1 = 1 ';
    BOMMESearchForm := TBOMMESearchForm.Create(nil,sSQL,'仓库编号','仓库名称','MC001','MC002',1);
    BOMMESearchForm.Caption := '仓库查询';
    BOMMESearchForm.dbgrdh.Font.Size := 12;
    BOMMESearchForm.qry.Open;
    BOMMESearchForm.ShowModal;
    edtMC002.Text := Trim(BOMMESearchForm.r1);
    lblMC002.Caption := BOMMESearchForm.r2;
    BOMMESearchForm.Free;
end;

procedure TINVMCForm.btnsearchClick(Sender: TObject);
begin
  inherited;
    qry.Close;
    qry.SQL.Text := 'SELECT INVMC.MC001 品号, INVMB.MB002 品名, INVMB.MB003 规格,INVMC.MC002 仓库,INVMC.MC007 库存数量,INVMC.MC014 库存包装数量,'
                  +'COPTD.TD008 预计销售量,COPMF.MF008 计划销售量, INVMC.MC007 - COPTD.TD008 库存减计划销售量,MOCTA.TA015 预计生产量,MOCTB.TB004 预计领用量,PURTD.TD008 预计进货量,INVMB.MB008 分类'
                  +' FROM INVMC INNER JOIN  '
                  + ' INVMB ON INVMC.MC001 = INVMB.MB001 '
                  + ' LEFT OUTER JOIN '
                  +' (SELECT COPTD.TD004, SUM(COPTD.TD008 - COPTD.TD009) TD008 '
                  + ' FROM COPTD LEFT JOIN '      //连接订单
                  +' CMSMC(NOLOCK) ON TD007 = MC001 '
                  + ' WHERE COPTD.TD008 + COPTD.TD024 > COPTD.TD009 + COPTD.TD025 + COPTD.TD058 '
                  + ' AND COPTD.TD021 = ''Y'' AND COPTD.TD016 = ''N'' '
                  + ' GROUP BY COPTD.TD004) COPTD ON INVMC.MC001 = COPTD.TD004 '
                  + ' LEFT OUTER JOIN '            //连接工单  逻辑为所有未完工工单
                  +' (select TA006,SUM(TA015-TA017) TA015 '
                  + ' from MOCTA '
                  + ' where TA011 <>''y'' and TA011 <>''Y'' '
                  + ' group by TA006) MOCTA ON INVMC.MC001 = MOCTA.TA006 '
                  + ' LEFT OUTER JOIN '            //连接工单单身  逻辑为所有未完工工单
                  +' (select TB003,SUM(TB004 - TB005) TB004 '
                  + ' from MOCTA LEFT JOIN MOCTB '
                  + ' on TB001 = TA001 AND TB002 = TA002 AND TB004 - TB005 > 0'
                  + ' where TA011 <>''y'' and TA011 <>''Y'' '
                  + ' Group by TB003 '
                  + ' ) MOCTB ON MOCTB.TB003 = INVMC.MC001 '
                  + ' LEFT OUTER JOIN '            //连接采购单
                  + '(Select TD004,SUM(TD008-TD015) TD008 '
                  + ' From PURTD where TD016 = ''N'' '
                  + ' GROUP BY TD004'
                  + ') PURTD ON PURTD.TD004 = MC001 '
                  + ' LEFT OUTER JOIN '            //连接请购单 条件为未抛转采购单的请购单
                  + '(Select MF003,SUM(MF008-MF009) MF008 '
                  + ' FROM COPMF Where MF008-MF009 > 0 '
                  + ' Group by MF003'
                  + ') COPMF on COPMF.MF003 = INVMC.MC001 '
                  + ' WHERE INVMB.MB002 Like ''%'
                  + edtName.Text + '%'' and INVMB.MB003 like ''%'
                  + edtMB003.Text +'%'' AND INVMB.MB001 like ''%' + edtMB001.Text +'%'' ';

  if edtMC002.Text <> '' then
  begin
    qry.SQL.Text := qry.SQL.Text + ' and (MC002 ='''+ edtMC002.Text+ ''') ';
  end;


  if not chk1.Checked  then
  qry.SQL.Text := qry.SQL.Text + ' and (INVMC.MC007 >0 or INVMC.MC014>0) ';


  qry.Open;
   dbgrdh.FooterRowCount := 1;
   dbgrdh.SumList.Active := True;
   dbgrdh.Columns.Items[4].Footer.FieldName := '库存数量';
   dbgrdh.Columns.Items[4].Footer.ValueType := fvtSum;
   dbgrdh.Columns.Items[5].Footer.FieldName := '库存包装数量';
   dbgrdh.Columns.Items[5].Footer.ValueType := fvtSum;

end;

procedure TINVMCForm.dbgrdhDblClick(Sender: TObject);
begin
  inherited;
  if QRY.FieldByName('品号').AsString = '' then exit;
  SysDM.qrySeek.Close;
  SysDM.qrySeek.SQL.Text := 'select COPTD.TD004,SUM(COPTD.TD008-COPTD.TD009) TD008'
                            + ' from COPTD '
                            + ' left join CMSMC (NOLOCK)  on TD007=MC001'
                            + ' where COPTD.TD008+COPTD.TD024>COPTD.TD009+COPTD.TD025+COPTD.TD058 and COPTD.TD021=''Y'' and COPTD.TD016=''N''  and  '
                            + ' TD004='''  +QRY.FieldByName('品号').AsString + ''' group by TD004';
  SysDM.qrySeek.Open;
  edtys.Text := CurrToStr(SysDM.qrySeek.FieldByName('TD008').AsCurrency);
  edtky.Text := CurrToStr(QRY.FieldByName('库存数量').AsCurrency - SysDM.qrySeek.FieldByName('TD008').AsCurrency);
  SysDM.qrySeek.Close;
  SysDM.qrySeek.SQL.Text := 'select TA006,SUM(TA015-TA017) TA015'
                            + ' from MOCTA '
                            + ' where TA006 ='''
                              +QRY.FieldByName('品号').AsString + ''' group by TA006';
  SysDM.qrySeek.Open;
  edtzt.Text := CurrToStr(SysDM.qrySeek.FieldByName('TA015').AsCurrency);
  SysDM.qrySeek.Close;
end;

procedure TINVMCForm.N1Click(Sender: TObject);
VAR
  sSQL:String;
begin
  inherited;
   sSQL := 'SELECT MOCTA.TA001 AS 单别, MOCTA.TA002 AS 单号, MOCTA.TA003 AS 单据日期, ' +
      ' MOCTA.TA006 AS 品号, MOCTA.TA015 AS 工单数量, MOCTA.TA046 AS 工单重量,'+
      'MOCTA.TA026 AS 订单单别, MOCTA.TA027 AS 订单单号, MOCTA.TA028 AS 订单序号,' +
     ' MOCTA.TA034 AS 品名, MOCTA.TA035 AS 规格, CASE MOCTA.TA011 WHEN ''1'' THEN ''未生产''  WHEN ''2'' THEN ''已领料'' WHEN ''3'' THEN ''生产中'' WHEN ''Y'' THEN ''已完工'' WHEN ''y'' then ''指定完工'' ELSE ''其他'' END AS 工单状况, ' +
     ' COPTD.TD008 AS 订单数量, COPTD.TD009 AS 已交数量, COPTD.TD013 预交货日' +
     ' FROM MOCTA LEFT OUTER JOIN ' +
     ' COPTD ON MOCTA.TA026 = COPTD.TD001 AND MOCTA.TA027 = COPTD.TD002 AND' +
     ' MOCTA.TA028 = COPTD.TD003 '  +
     ' WHERE  MOCTA.TA006 ='''
       +QRY.FieldByName('品号').AsString + ''' and MOCTA.TA011 <>''Y'' AND  MOCTA.TA011 <>''y''';
    BOMMESearchForm := TBOMMESearchForm.Create(nil,sSQL,'工单单号','订单单号','MOCTA.TA002','MOCTA.TA027',1);
    BOMMESearchForm.Caption := '未完工工单查询';
    BOMMESearchForm.dbgrdh.Font.Size := 12;
    BOMMESearchForm.qry.Open;
    BOMMESearchForm.ShowModal;
    BOMMESearchForm.Free;

end;

procedure TINVMCForm.N2Click(Sender: TObject);
VAR
  sSQL:String;
begin
  inherited;
      sSQL := 'SELECT COPMA.MA002 AS 客户简称,COPTC.TC001 AS 订单单别, COPTC.TC002 AS 订单单号, '
      + 'COPTD.TD003 AS 订单序号, CONVERT(datetime,COPTC.TC003) AS 订单日期,MOCTA.TA001 AS 工单单别, MOCTA.TA002 AS 工单单号,case MOCTA.TA003  when null then '''' else  CONVERT(datetime,MOCTA.TA003) end AS 工单日期,'
      + 'CASE MOCTA.TA011 WHEN ''1'' THEN ''未生产''  WHEN ''2'' THEN ''已领料'' WHEN ''3'' THEN ''生产中'' WHEN ''Y'' THEN ''已完工'' WHEN ''y'' then ''指定完工'' ELSE ''其他'' END AS 工单状况'
      + ' ,COPTD.TD016 订单状态,COPTD.TD004 AS 品号, INVMB.MB002 AS 品名, INVMB.MB003 AS 规格,COPTD.TD010 AS 计价单位,'
      + 'COPTD.TD008 AS 订单数量,COPTD.TD008-COPTD.TD009 AS 未交数量,COPTD.UDF51 重量价格,COPTD.TD011 按件单价, COPTD.TD032 AS 订单重量, MOCTA.TA015 AS 工单数量,MOCTA.TA017 AS 已入库数量,  '
      + 'MOCTA.TA045 AS 工单包装数量, MOCTA.TA046 AS 已入库包装数量,COPTD.TD008-MOCTA.TA015 AS 预差数量,'
      +' COPTD.TD032-MOCTA.TA045 AS 预差数量,COPTD.TD008-MOCTA.TA017 AS 现差数量,COPTD.TD032-MOCTA.TA046 AS 现差重量,CONVERT(datetime,COPTD.TD013) AS 预交货日,datediff(day,getdate(),CONVERT(datetime,COPTD.TD013)) as 离交货日还有,COPTD.TD038 AS 税前金额, '
      + 'COPTD.TD038 + COPTD.TD039 AS 总价, COPTD.TD039 AS 税额, '
      + 'COPTD.TD011 AS 单价, CMSMV.MV002 AS 业务员, COPTD.TD020 备注 '
      + ' FROM COPTC INNER JOIN  '
      + 'COPTD ON COPTC.TC001 = COPTD.TD001 AND '
      + 'COPTC.TC002 = COPTD.TD002 INNER JOIN  '
      + 'COPMA ON COPTC.TC004 = COPMA.MA001 INNER JOIN  '
      + 'INVMB ON COPTD.TD004 = INVMB.MB001 LEFT OUTER JOIN  '
      + 'CMSMV ON COPTC.TC006 = CMSMV.MV001 LEFT OUTER JOIN  '
      + 'MOCTA ON COPTD.TD001 = MOCTA.TA026 AND COPTD.TD002 = MOCTA.TA027 AND '
      + 'COPTD.TD003 = MOCTA.TA028  where (COPTD.TD016 = ''N'' and COPTD.TD021 = ''Y'') and  '
      + ' COPTD.TD004='''  +QRY.FieldByName('品号').AsString + '''';
    BOMMESearchForm := TBOMMESearchForm.Create(nil,sSQL,'客户简称','订单单号','COPMA.MA002','COPTC.TC002',1);
    BOMMESearchForm.Caption := '相关订单查询';
    BOMMESearchForm.dbgrdh.Font.Size := 12;
    BOMMESearchForm.qry.Open;
    BOMMESearchForm.ShowModal;
  //  edtMC002.Text := BOMMESearchForm.r1;
  //  lblMC002.Caption := BOMMESearchForm.r2;
    BOMMESearchForm.Free;

end;

procedure TINVMCForm.dbgrdhDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  Re : TRect;
begin
  inherited;
  Re := Rect;

  With (Sender as TDBGridEh) do
  begin
    if NOT(gdSelected IN State) then
    begin
      if ds.DataSet.FieldByName('库存减计划销售量').AsCurrency < 0 then
      begin
         Canvas.Font.Color := RGB(255,0,0);
      end;
    end;
   DefaultDrawColumnCell(Re,DataCol,Column,State);   //宋锦程
  end;

end;

procedure TINVMCForm.btn3Click(Sender: TObject);
var
  sSQL :string;
begin
  inherited;

    sSQL := 'SELECT INVMB.MB002 牌号, sum(INVMC.MC007) 库存数量,sum(INVMC.MC014) 库存包装数量'

                  +' FROM INVMC INNER JOIN  '
                  + ' INVMB ON INVMC.MC001 = INVMB.MB001 '


                  + ' WHERE INVMB.MB002 Like ''%'
                  + edtName.Text + '%'' and INVMB.MB003 like ''%'
                  + edtMB003.Text +'%'' AND INVMB.MB001 like ''%' + edtMB001.Text +'%'' ';




    sSQL := sSQL + ' and MC002 ='''+ edtMC002.Text+ ''' ';


  if not chk1.Checked  then
  sSQL := sSQL + ' and (INVMC.MC007 >0 or INVMC.MC014>0) Group by MB002';

    BOMMESearchForm := TBOMMESearchForm.Create(nil,sSQL,'品名','库存数量','MB002','INVMC.MC007',1);
    BOMMESearchForm.Caption := '牌号分类汇总';
    BOMMESearchForm.dbgrdh.Font.Size := 12;
    BOMMESearchForm.qry.Open;
    BOMMESearchForm.ShowModal;
    BOMMESearchForm.Free;
end;

procedure TINVMCForm.btn2Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TINVMCForm.N5Click(Sender: TObject);
VAR
  sSQL: String;
begin
  inherited;
   sSQL := 'SELECT MF001 预测编号,MF003 品号, MF004 品名,MF005 规格,MF008 预测数量,MF009 已受订量 ' +
     ' FROM COPMF ' +
     ' WHERE  MF003 ='''
       +QRY.FieldByName('品号').AsString + ''' and MF008 - MF009 > 0  ';
    BOMMESearchForm := TBOMMESearchForm.Create(nil,sSQL,'预测编号','预测品号','MF001','MF003',1);
    BOMMESearchForm.Caption := '未完成销售预测查询';
    BOMMESearchForm.dbgrdh.Font.Size := 12;
    BOMMESearchForm.qry.Open;
    BOMMESearchForm.ShowModal;
    BOMMESearchForm.Free;
end;

procedure TINVMCForm.N3Click(Sender: TObject);
var
  sSQL:string;
begin
  inherited;
   sSQL := 'SELECT MOCTA.TA001 AS 单别, MOCTA.TA002 AS 单号, MOCTA.TA003 AS 单据日期, '
   + 'MOCTB.TB003 材料品号,MOCTB.TB004 需领料量,MOCTB.TB005 已领用量,MOCTB.TB006 未领用量,'
   + 'MOCTB.TB012 材料品名,MOCTB.TB013 材料规格,' +
      ' MOCTA.TA006 AS 品号, MOCTA.TA015 AS 工单数量, MOCTA.TA046 AS 工单重量,'+
      'MOCTA.TA026 AS 订单单别, MOCTA.TA027 AS 订单单号, MOCTA.TA028 AS 订单序号,' +
     ' MOCTA.TA034 AS 品名, MOCTA.TA035 AS 规格 ' +
     ' FROM MOCTA LEFT OUTER JOIN MOCTB '
     + ' on TB001 = TA001 AND TB002 = TA002 AND TB004 - TB005 > 0'
     +' WHERE  MOCTB.TB003  ='''
       +QRY.FieldByName('品号').AsString + ''' and MOCTA.TA011 <>''Y'' AND  MOCTA.TA011 <>''y''';
    BOMMESearchForm := TBOMMESearchForm.Create(nil,sSQL,'工单单号','工单品号','MOCTA.TA002','MOCTA.TA006',1);
    BOMMESearchForm.Caption := '领料未完成工单查询';
    BOMMESearchForm.dbgrdh.Font.Size := 12;
    BOMMESearchForm.qry.Open;
    BOMMESearchForm.ShowModal;
    BOMMESearchForm.Free;
end;

procedure TINVMCForm.N4Click(Sender: TObject);
var
  sSQL:string;
begin
  inherited;
   sSQL := 'SELECT TD001 采购单别,TD002 采购单号,TD003 采购序号,TD004 采购品号,TD005 品名,TD006 规格,'
   + 'TD008 采购数量,TD015 已交数量,TD008-TD015 欠交数量 '

     + ' FROM PURTD '

     +' WHERE  TD016 = ''N'' AND TD004  ='''
       +QRY.FieldByName('品号').AsString + '''';
    BOMMESearchForm := TBOMMESearchForm.Create(nil,sSQL,'采购单别','采购单号','TD001','TD002',1);
    BOMMESearchForm.Caption := '未完成采购单';
    BOMMESearchForm.dbgrdh.Font.Size := 12;
    BOMMESearchForm.qry.Open;
    BOMMESearchForm.ShowModal;
    BOMMESearchForm.Free;

end;

end.
