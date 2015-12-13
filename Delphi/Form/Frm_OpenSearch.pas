unit Frm_OpenSearch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBaseSearch, ImgList, DB, ADODB, ComCtrls, ToolWin, GridsEh,
  DBGridEh, StdCtrls, ExtCtrls,Clipbrd, Buttons;

type
  TFormOpenSearch = class(TBaseSearchForm)
    lbl1: TLabel;
    edt1: TEdit;
    procedure btnsearchClick(Sender: TObject);
    procedure dbgrdhDblClick(Sender: TObject);
    procedure edtNameKeyPress(Sender: TObject; var Key: Char);
    procedure dbgrdhDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
  private
    { Private declarations }
    sTB,KeyF1,KeyF2:string;//����,��ѯ�ֶ�һ,��ѯ�ֶζ�
  public
    { Public declarations }

    resultOne,resultTwo :string; //��������ֵһ,��������ֵ��
    constructor Create(AOwner: TComponent;sTABLE :string;S1,S2,sKEYF1:string;SKEYF2:string = ''); reintroduce; overload;
    //���ع��캯��,����,������,����,��ǩһ��ʾ����,��ǩ����ʾ����,��ѯ�ֶ�һ��ʾ����,��ѯ�ֶζ���ʾ����,Ĭ��ֵ��
  end;

var
  FormOpenSearch: TFormOpenSearch;

implementation



{$R *.dfm}

{ TBOMMESearchForm }

constructor TFormOpenSearch.Create(AOwner: TComponent; sTABLE, S1,S2,sKEYF1,
  SKEYF2: string);
begin
  resultOne := '';
  resultTwo := '';
  sTB := sTABLE;
  KeyF1 := sKEYF1;
  KeyF2 := SKEYF2;

  inherited Create(AOwner);
  qry.SQL.Text := sTB ;
  lblName.Caption := S1;
  lbl1.Caption := S2;
end;

procedure TFormOpenSearch.btnsearchClick(Sender: TObject);
begin
  inherited;
    Screen.Cursor := crHourGlass;
    qry.Close;
    qry.SQL.Text := sTB + ' and ' + KeyF1 + ' Like ''%' + edtName.Text + '%''';
    qry.SQL.Text := qry.SQL.Text +  ' and ' + KeyF2 + ' Like ''%' + edt1.Text + '%''';
    qry.Open;
    Screen.Cursor := crDefault;
end;

procedure TFormOpenSearch.dbgrdhDblClick(Sender: TObject);
begin
  inherited;
  resultOne := qry.Fields[0].AsString;
  resultTwo := qry.Fields[1].AsString;
  Close;
end;

procedure TFormOpenSearch.edtNameKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then btnsearch.Click;
end;



procedure TFormOpenSearch.dbgrdhDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  Re : TRect;
  ProgressRect, ATextRect: TRect;
  DBGridEh: TDBGridEh;
  Percent: Integer;
  PercentText: string;
begin
  inherited;
  DBGridEh := Sender as TDBGridEh;
  with DBGridEh.Canvas do
  begin
      if Column.FieldName = '�ٷֱ�' then
      begin
        if Column.Field.AsInteger = 0 then

          Percent := Round(Column.Field.AsInteger)
        else
          Percent := Round(Column.Field.AsCurrency * 100);
        ProgressRect :=  Rect;
        ProgressRect.Right := ProgressRect.left
        + Round((Rect.Right-Rect.Left) * (Percent/100));
        Brush.Color := clWindow;
        Font.Color := clWindow;
        DBGridEh.DefaultDrawColumnCell(Rect, DataCol, Column, State);
        Brush.Color := $00FFCC00;//���ý�������ɫ
        Font.Color := $00FFCC00;
        DBGridEh.DefaultDrawColumnCell(ProgressRect, DataCol, Column, State);
        PercentText := IntToStr(Percent) + '%';
        Brush.Style := bsClear;
        Font.Color := clBlack;
        with Rect do
        TextOut(Left + (Right-Left) div 2 -TextWidth(PercentText) div 2,
          Top+1, PercentText);//������������
      end;

  end;
end;

end.
