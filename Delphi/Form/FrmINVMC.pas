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
    sSQL := 'SELECT MC001 �ֿ���,MC002 �ֿ����� from CMSMC Where 1 = 1 ';
    BOMMESearchForm := TBOMMESearchForm.Create(nil,sSQL,'�ֿ���','�ֿ�����','MC001','MC002',1);
    BOMMESearchForm.Caption := '�ֿ��ѯ';
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
    qry.SQL.Text := 'SELECT INVMC.MC001 Ʒ��, INVMB.MB002 Ʒ��, INVMB.MB003 ���,INVMC.MC002 �ֿ�,INVMC.MC007 �������,INVMC.MC014 ����װ����,'
                  +'COPTD.TD008 Ԥ��������,COPMF.MF008 �ƻ�������, INVMC.MC007 - COPTD.TD008 �����ƻ�������,MOCTA.TA015 Ԥ��������,MOCTB.TB004 Ԥ��������,PURTD.TD008 Ԥ�ƽ�����,INVMB.MB008 ����'
                  +' FROM INVMC INNER JOIN  '
                  + ' INVMB ON INVMC.MC001 = INVMB.MB001 '
                  + ' LEFT OUTER JOIN '
                  +' (SELECT COPTD.TD004, SUM(COPTD.TD008 - COPTD.TD009) TD008 '
                  + ' FROM COPTD LEFT JOIN '      //���Ӷ���
                  +' CMSMC(NOLOCK) ON TD007 = MC001 '
                  + ' WHERE COPTD.TD008 + COPTD.TD024 > COPTD.TD009 + COPTD.TD025 + COPTD.TD058 '
                  + ' AND COPTD.TD021 = ''Y'' AND COPTD.TD016 = ''N'' '
                  + ' GROUP BY COPTD.TD004) COPTD ON INVMC.MC001 = COPTD.TD004 '
                  + ' LEFT OUTER JOIN '            //���ӹ���  �߼�Ϊ����δ�깤����
                  +' (select TA006,SUM(TA015-TA017) TA015 '
                  + ' from MOCTA '
                  + ' where TA011 <>''y'' and TA011 <>''Y'' '
                  + ' group by TA006) MOCTA ON INVMC.MC001 = MOCTA.TA006 '
                  + ' LEFT OUTER JOIN '            //���ӹ�������  �߼�Ϊ����δ�깤����
                  +' (select TB003,SUM(TB004 - TB005) TB004 '
                  + ' from MOCTA LEFT JOIN MOCTB '
                  + ' on TB001 = TA001 AND TB002 = TA002 AND TB004 - TB005 > 0'
                  + ' where TA011 <>''y'' and TA011 <>''Y'' '
                  + ' Group by TB003 '
                  + ' ) MOCTB ON MOCTB.TB003 = INVMC.MC001 '
                  + ' LEFT OUTER JOIN '            //���Ӳɹ���
                  + '(Select TD004,SUM(TD008-TD015) TD008 '
                  + ' From PURTD where TD016 = ''N'' '
                  + ' GROUP BY TD004'
                  + ') PURTD ON PURTD.TD004 = MC001 '
                  + ' LEFT OUTER JOIN '            //�����빺�� ����Ϊδ��ת�ɹ������빺��
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
   dbgrdh.Columns.Items[4].Footer.FieldName := '�������';
   dbgrdh.Columns.Items[4].Footer.ValueType := fvtSum;
   dbgrdh.Columns.Items[5].Footer.FieldName := '����װ����';
   dbgrdh.Columns.Items[5].Footer.ValueType := fvtSum;

end;

procedure TINVMCForm.dbgrdhDblClick(Sender: TObject);
begin
  inherited;
  if QRY.FieldByName('Ʒ��').AsString = '' then exit;
  SysDM.qrySeek.Close;
  SysDM.qrySeek.SQL.Text := 'select COPTD.TD004,SUM(COPTD.TD008-COPTD.TD009) TD008'
                            + ' from COPTD '
                            + ' left join CMSMC (NOLOCK)  on TD007=MC001'
                            + ' where COPTD.TD008+COPTD.TD024>COPTD.TD009+COPTD.TD025+COPTD.TD058 and COPTD.TD021=''Y'' and COPTD.TD016=''N''  and  '
                            + ' TD004='''  +QRY.FieldByName('Ʒ��').AsString + ''' group by TD004';
  SysDM.qrySeek.Open;
  edtys.Text := CurrToStr(SysDM.qrySeek.FieldByName('TD008').AsCurrency);
  edtky.Text := CurrToStr(QRY.FieldByName('�������').AsCurrency - SysDM.qrySeek.FieldByName('TD008').AsCurrency);
  SysDM.qrySeek.Close;
  SysDM.qrySeek.SQL.Text := 'select TA006,SUM(TA015-TA017) TA015'
                            + ' from MOCTA '
                            + ' where TA006 ='''
                              +QRY.FieldByName('Ʒ��').AsString + ''' group by TA006';
  SysDM.qrySeek.Open;
  edtzt.Text := CurrToStr(SysDM.qrySeek.FieldByName('TA015').AsCurrency);
  SysDM.qrySeek.Close;
end;

procedure TINVMCForm.N1Click(Sender: TObject);
VAR
  sSQL:String;
begin
  inherited;
   sSQL := 'SELECT MOCTA.TA001 AS ����, MOCTA.TA002 AS ����, MOCTA.TA003 AS ��������, ' +
      ' MOCTA.TA006 AS Ʒ��, MOCTA.TA015 AS ��������, MOCTA.TA046 AS ��������,'+
      'MOCTA.TA026 AS ��������, MOCTA.TA027 AS ��������, MOCTA.TA028 AS �������,' +
     ' MOCTA.TA034 AS Ʒ��, MOCTA.TA035 AS ���, CASE MOCTA.TA011 WHEN ''1'' THEN ''δ����''  WHEN ''2'' THEN ''������'' WHEN ''3'' THEN ''������'' WHEN ''Y'' THEN ''���깤'' WHEN ''y'' then ''ָ���깤'' ELSE ''����'' END AS ����״��, ' +
     ' COPTD.TD008 AS ��������, COPTD.TD009 AS �ѽ�����, COPTD.TD013 Ԥ������' +
     ' FROM MOCTA LEFT OUTER JOIN ' +
     ' COPTD ON MOCTA.TA026 = COPTD.TD001 AND MOCTA.TA027 = COPTD.TD002 AND' +
     ' MOCTA.TA028 = COPTD.TD003 '  +
     ' WHERE  MOCTA.TA006 ='''
       +QRY.FieldByName('Ʒ��').AsString + ''' and MOCTA.TA011 <>''Y'' AND  MOCTA.TA011 <>''y''';
    BOMMESearchForm := TBOMMESearchForm.Create(nil,sSQL,'��������','��������','MOCTA.TA002','MOCTA.TA027',1);
    BOMMESearchForm.Caption := 'δ�깤������ѯ';
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
      sSQL := 'SELECT COPMA.MA002 AS �ͻ����,COPTC.TC001 AS ��������, COPTC.TC002 AS ��������, '
      + 'COPTD.TD003 AS �������, CONVERT(datetime,COPTC.TC003) AS ��������,MOCTA.TA001 AS ��������, MOCTA.TA002 AS ��������,case MOCTA.TA003  when null then '''' else  CONVERT(datetime,MOCTA.TA003) end AS ��������,'
      + 'CASE MOCTA.TA011 WHEN ''1'' THEN ''δ����''  WHEN ''2'' THEN ''������'' WHEN ''3'' THEN ''������'' WHEN ''Y'' THEN ''���깤'' WHEN ''y'' then ''ָ���깤'' ELSE ''����'' END AS ����״��'
      + ' ,COPTD.TD016 ����״̬,COPTD.TD004 AS Ʒ��, INVMB.MB002 AS Ʒ��, INVMB.MB003 AS ���,COPTD.TD010 AS �Ƽ۵�λ,'
      + 'COPTD.TD008 AS ��������,COPTD.TD008-COPTD.TD009 AS δ������,COPTD.UDF51 �����۸�,COPTD.TD011 ��������, COPTD.TD032 AS ��������, MOCTA.TA015 AS ��������,MOCTA.TA017 AS ���������,  '
      + 'MOCTA.TA045 AS ������װ����, MOCTA.TA046 AS ������װ����,COPTD.TD008-MOCTA.TA015 AS Ԥ������,'
      +' COPTD.TD032-MOCTA.TA045 AS Ԥ������,COPTD.TD008-MOCTA.TA017 AS �ֲ�����,COPTD.TD032-MOCTA.TA046 AS �ֲ�����,CONVERT(datetime,COPTD.TD013) AS Ԥ������,datediff(day,getdate(),CONVERT(datetime,COPTD.TD013)) as �뽻���ջ���,COPTD.TD038 AS ˰ǰ���, '
      + 'COPTD.TD038 + COPTD.TD039 AS �ܼ�, COPTD.TD039 AS ˰��, '
      + 'COPTD.TD011 AS ����, CMSMV.MV002 AS ҵ��Ա, COPTD.TD020 ��ע '
      + ' FROM COPTC INNER JOIN  '
      + 'COPTD ON COPTC.TC001 = COPTD.TD001 AND '
      + 'COPTC.TC002 = COPTD.TD002 INNER JOIN  '
      + 'COPMA ON COPTC.TC004 = COPMA.MA001 INNER JOIN  '
      + 'INVMB ON COPTD.TD004 = INVMB.MB001 LEFT OUTER JOIN  '
      + 'CMSMV ON COPTC.TC006 = CMSMV.MV001 LEFT OUTER JOIN  '
      + 'MOCTA ON COPTD.TD001 = MOCTA.TA026 AND COPTD.TD002 = MOCTA.TA027 AND '
      + 'COPTD.TD003 = MOCTA.TA028  where (COPTD.TD016 = ''N'' and COPTD.TD021 = ''Y'') and  '
      + ' COPTD.TD004='''  +QRY.FieldByName('Ʒ��').AsString + '''';
    BOMMESearchForm := TBOMMESearchForm.Create(nil,sSQL,'�ͻ����','��������','COPMA.MA002','COPTC.TC002',1);
    BOMMESearchForm.Caption := '��ض�����ѯ';
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
      if ds.DataSet.FieldByName('�����ƻ�������').AsCurrency < 0 then
      begin
         Canvas.Font.Color := RGB(255,0,0);
      end;
    end;
   DefaultDrawColumnCell(Re,DataCol,Column,State);   //�ν���
  end;

end;

procedure TINVMCForm.btn3Click(Sender: TObject);
var
  sSQL :string;
begin
  inherited;

    sSQL := 'SELECT INVMB.MB002 �ƺ�, sum(INVMC.MC007) �������,sum(INVMC.MC014) ����װ����'

                  +' FROM INVMC INNER JOIN  '
                  + ' INVMB ON INVMC.MC001 = INVMB.MB001 '


                  + ' WHERE INVMB.MB002 Like ''%'
                  + edtName.Text + '%'' and INVMB.MB003 like ''%'
                  + edtMB003.Text +'%'' AND INVMB.MB001 like ''%' + edtMB001.Text +'%'' ';




    sSQL := sSQL + ' and MC002 ='''+ edtMC002.Text+ ''' ';


  if not chk1.Checked  then
  sSQL := sSQL + ' and (INVMC.MC007 >0 or INVMC.MC014>0) Group by MB002';

    BOMMESearchForm := TBOMMESearchForm.Create(nil,sSQL,'Ʒ��','�������','MB002','INVMC.MC007',1);
    BOMMESearchForm.Caption := '�ƺŷ������';
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
   sSQL := 'SELECT MF001 Ԥ����,MF003 Ʒ��, MF004 Ʒ��,MF005 ���,MF008 Ԥ������,MF009 ���ܶ��� ' +
     ' FROM COPMF ' +
     ' WHERE  MF003 ='''
       +QRY.FieldByName('Ʒ��').AsString + ''' and MF008 - MF009 > 0  ';
    BOMMESearchForm := TBOMMESearchForm.Create(nil,sSQL,'Ԥ����','Ԥ��Ʒ��','MF001','MF003',1);
    BOMMESearchForm.Caption := 'δ�������Ԥ���ѯ';
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
   sSQL := 'SELECT MOCTA.TA001 AS ����, MOCTA.TA002 AS ����, MOCTA.TA003 AS ��������, '
   + 'MOCTB.TB003 ����Ʒ��,MOCTB.TB004 ��������,MOCTB.TB005 ��������,MOCTB.TB006 δ������,'
   + 'MOCTB.TB012 ����Ʒ��,MOCTB.TB013 ���Ϲ��,' +
      ' MOCTA.TA006 AS Ʒ��, MOCTA.TA015 AS ��������, MOCTA.TA046 AS ��������,'+
      'MOCTA.TA026 AS ��������, MOCTA.TA027 AS ��������, MOCTA.TA028 AS �������,' +
     ' MOCTA.TA034 AS Ʒ��, MOCTA.TA035 AS ��� ' +
     ' FROM MOCTA LEFT OUTER JOIN MOCTB '
     + ' on TB001 = TA001 AND TB002 = TA002 AND TB004 - TB005 > 0'
     +' WHERE  MOCTB.TB003  ='''
       +QRY.FieldByName('Ʒ��').AsString + ''' and MOCTA.TA011 <>''Y'' AND  MOCTA.TA011 <>''y''';
    BOMMESearchForm := TBOMMESearchForm.Create(nil,sSQL,'��������','����Ʒ��','MOCTA.TA002','MOCTA.TA006',1);
    BOMMESearchForm.Caption := '����δ��ɹ�����ѯ';
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
   sSQL := 'SELECT TD001 �ɹ�����,TD002 �ɹ�����,TD003 �ɹ����,TD004 �ɹ�Ʒ��,TD005 Ʒ��,TD006 ���,'
   + 'TD008 �ɹ�����,TD015 �ѽ�����,TD008-TD015 Ƿ������ '

     + ' FROM PURTD '

     +' WHERE  TD016 = ''N'' AND TD004  ='''
       +QRY.FieldByName('Ʒ��').AsString + '''';
    BOMMESearchForm := TBOMMESearchForm.Create(nil,sSQL,'�ɹ�����','�ɹ�����','TD001','TD002',1);
    BOMMESearchForm.Caption := 'δ��ɲɹ���';
    BOMMESearchForm.dbgrdh.Font.Size := 12;
    BOMMESearchForm.qry.Open;
    BOMMESearchForm.ShowModal;
    BOMMESearchForm.Free;

end;

end.
