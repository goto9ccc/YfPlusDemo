unit uKingFilter;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, DB, ExtCtrls, ComCtrls;

type

  {
    '等于;不等于;大于;大于或等于;小于;小于或等于;始于;并非起始于;' +
    '止于;并非结束于;包含;不包含';
  }

  TFilterLogical = (flAnd, flOr);

  TFilterCondition = (fcEqual, fcNotEqual, fcGreat, fcGreatEqual,
    fcLess, fcLessEqual, fcBeginWith, fcNotBeginWith, fcEndWith, fcNotEndWith,
    fcContain, fcNotContain);

  { Forward declare }

  TKingFilterDialog = class;

  { TKingFilterForm }

  TKingFilter = class(TForm)
    gbFilterConditions: TGroupBox;
    lbFilter: TListBox;
    gbDefineCondition: TGroupBox;
    cbFields: TComboBox;
    Label1: TLabel;
    cbConditions: TComboBox;
    Label2: TLabel;
    Label3: TLabel;
    GroupBox1: TGroupBox;
    btNew: TSpeedButton;
    btDel: TSpeedButton;
    btOk: TSpeedButton;
    btCancel: TSpeedButton;
    btClear: TSpeedButton;
    Panel1: TPanel;
    btReplace: TSpeedButton;
    cbLink: TComboBox;
    cbValue: TComboBox;
    Label4: TLabel;
    procedure lbFilterDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure lbFilterDblClick(Sender: TObject);
    procedure edtValueChange(Sender: TObject);
    procedure cbFieldsChange(Sender: TObject);
    procedure btNewClick(Sender: TObject);
    procedure btDelClick(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure btClearClick(Sender: TObject);
    procedure btReplaceClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    FFilterDialog: TKingFilterDialog;
  public
    DataSet: TDataSet;
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

  { TKingFilterDialog }

  TKingFilterDialogOption = (dfdOnlyBuildFilter);
  TKingFilterDialogOptions = set of TKingFilterDialogOption;

  //  TFilterStrings = class(TStrings)

  TKingFilterDialog = class(TComponent)
  private
    FFilterStrings: TStrings;
    FFilterFields: string;
    //    FFieldTypes: array of TFieldType;
    FDataSet: TDataSet;
    FConditions: TStrings;
    FTitle: string;
    FSaveOnFilterRecord: TFilterRecordEvent;
    FSaveFiltered: Boolean;
    FPreFiltered: Boolean;
    FOptions: TKingFilterDialogOptions;
    //    function GetDataSet: TDataSet;
    function GetFilterFields: string;
    procedure SetTitle(const Value: string);
    procedure SetDataSet(Value: TDataSet);
    procedure SetFilterFields(const Value: string);
    function CanUseFilterCondition(Field: TField; FilterCondition:
      TFilterCondition): Boolean;
    procedure FilterStringsChange(Sender: TObject);
  protected
    //    procedure InitFieldTypes;
    procedure DataSetFilterRecord(DataSet: TDataSet; var Accept: Boolean);
      virtual;
    //    property DataSet: TDataSet read GetDataSet;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean;
    function GetFilter: string; virtual;
    procedure GetFilterDescriptions(List: TStrings);
    property FilterStrings: TStrings read FFilterStrings;
  published
    property DataSet: TDataSet read FDataSet write SetDataSet;
    property FilterFields: string read GetFilterFields write SetFilterFields;
    property Title: string read FTitle write SetTitle;
    property Options: TKingFilterDialogOptions read FOptions write FOptions;
  end;

procedure ShowFilterForm(Dataset: TDataset);

var
  SaveTempFilterStr: TStringList; //保存临时的各个DATASETFILTER的记录

implementation

uses StrUtils;

{$R *.DFM}

function ExtractSubStr(const Str: string; var Pos: Integer; Delimiter: Char =
  ';'): string;
var
  I: Integer;
begin
  I := Pos;
  while (I <= Length(Str)) and (Str[I] <> Delimiter) do
    Inc(I);
  Result := Copy(Str, Pos, I - Pos);
  if (I <= Length(Str)) and (Str[I] = Delimiter) then
    Inc(I);
  Pos := I;
end;

function IndexOfFieldName(const Fields: string; Index: Integer): string;
var
  I, J, Pos: Integer;
begin
  Pos := 1;
  I := Pos;
  J := -1;
  while I <= Length(Fields) do
  begin
    if Fields[I] = ';' then
    begin
      Inc(J);
      if (J = Index) or (Index = -1) then
        Break;
      Pos := I + 1;
    end;
    Inc(I);
  end;
  Result := Trim(Copy(Fields, Pos, I - Pos));
  //  if (I <= Length(Fields)) and (Fields[I] = ';') then Inc(I);
end;

procedure ShowFilterForm(Dataset: TDataset);
var
  kFilter: TKingFilterDialog;
begin
  kFilter := TKingFilterDialog.Create(nil);
  try
    kFilter.DataSet := Dataset;
    kFilter.Execute;
  finally
    FreeAndNil(kFilter);
  end;
end;

{ TKingFilterForm }

constructor TKingFilter.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if AOwner is TKingFilterDialog then
    FFilterDialog := AOwner as TKingFilterDialog;
end;

procedure TKingFilter.lbFilterDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
const
  Offset = 2;
var
  I: Integer;
  S, Temp: string;
begin
  with (Control as TListBox) do
  begin
    Temp := Items[Index];
    I := 1;
    if Index <> 0 then
    begin
      if ExtractSubStr(Temp, I, ';') = '0' then
        S := '并且'
      else
        S := '或者';
    end
    else
      ExtractSubStr(Temp, I);
    //取得字段的DisplayLabel
    S := S + ' ' + DataSet.FieldByName(ExtractSubStr(Temp, I)).DisplayLabel;
    //    S := S + ' ' + TField(Items.Objects[Index]).DisplayLabel;
        //[StrToInt(ExtractSubStr(Temp, I))];
    S := S + ' ' + cbConditions.Items[StrToInt(ExtractSubStr(Temp, I))];
    S := S + ' ' + ExtractSubStr(Temp, I) + ' ;';
    Canvas.FillRect(Rect);
    Canvas.TextOut(Rect.Left + Offset, Rect.Top, S);
  end;
end;

procedure TKingFilter.lbFilterDblClick(Sender: TObject);
var
  I: Integer;
  Temp: string;
begin
  Temp := lbFilter.Items[lbFilter.ItemIndex];
  I := 1;
  cbLink.ItemIndex := StrTointdef(ExtractSubStr(Temp, I), 0); //连接符,and=0 or 1

  cbFields.ItemIndex :=
    cbFields.Items.IndexOfObject(DataSet.FieldByName(ExtractSubStr(Temp, I)));
  // cbFields.ItemIndex :=
  //   cbFields.Items.IndexOfObject(lbFilter.Items.Objects[lbFilter.ItemIndex]);
   // StrToInt(ExtractSubStr(Temp, I));
  cbFields.OnChange(cbFields);
  cbConditions.ItemIndex := cbConditions.Items.IndexOfObject(
    TObject(StrToInt(ExtractSubStr(Temp, I))));
  //  case nbValue.PageIndex of
  //    0: edtValue.Text := ExtractSubStr(Temp, I);
  //    1: cbValue.ItemIndex := cbValue.Items.IndexOf(ExtractSubStr(Temp, I));
  //    2: dtpDate.Date := StrToDateTime(ExtractSubStr(Temp, I));
  //  end;
  cbValue.Text := ExtractSubStr(Temp, I);
end;

procedure TKingFilter.edtValueChange(Sender: TObject);
begin
  //  btnAddToList.Enabled := TEdit(Sender).Text <> '';
end;

procedure TKingFilter.cbFieldsChange(Sender: TObject);
const
  maxtime = 500; //如果1000毫秒内还未完成填充动作,则就不再填充
var
  I: Integer;
  d: DWORD;
  bm: string;
begin
  //设置条件项目
  cbConditions.Clear;
  for I := 0 to FFilterDialog.FConditions.Count - 1 do
    if
      FFilterDialog.CanUseFilterCondition(TField(cbFields.Items.Objects[cbFields.ItemIndex]),
      TFilterCondition(FFilterDialog.FConditions.Objects[I])) then
      cbConditions.Items.AddObject(FFilterDialog.FConditions[I],
        FFilterDialog.FConditions.Objects[I]);
  cbConditions.Enabled := cbConditions.Items.Count > 0;
  if cbConditions.Enabled then
    cbConditions.ItemIndex := 0;
  //设置可供选择的项目
//  if not showing then
//    exit;
  d := GetTickCount;
  cbValue.Clear;
  bm := DataSet.Bookmark;
  DataSet.Filtered := False;
  DataSet.DisableControls;
  try
    try
      with DataSet do
      begin
        First;
        if TField(cbFields.Items.Objects[cbFields.ItemIndex]).DataType = ftBoolean
          then
        begin
          cbValue.Items.Add('True');
          cbValue.Items.Add('False');
        end;
        while not Eof do
        begin
          //填充值到cbValue中了
          if (TField(cbFields.Items.Objects[cbFields.ItemIndex]).AsString <> '')
            and
            (cbValue.Items.IndexOf(TField(cbFields.Items.Objects[cbFields.ItemIndex]).AsString) = -1) then
            cbValue.Items.Add(TField(cbFields.Items.Objects[cbFields.ItemIndex]).AsString);
          if (GetTickCount - d) >= maxtime then
            Break; //如果时间到了,则退出不执行了
          Next;
        end;
      end;
      //      Caption:=IntToStr(cbValue.Items.Count);
      DataSet.Bookmark := bm;
    except
    end;
  finally
    DataSet.EnableControls;
  end;

  //  case TField(cbFields.Items.Objects[cbFields.ItemIndex]).DataType of
  //    ftBoolean: nbValue.PageIndex := 1;
  //    ftDate, ftDateTime: nbValue.PageIndex := 2;
  //    ftString, ftWideString, ftFixedChar, ftMemo, ftFmtMemo:
  //      cbConditions.ItemIndex :=
  //        cbConditions.Items.IndexOfObject(TObject(fcContain));
  //  else
  //    nbValue.PageIndex := 0;
  //  end;
end;

{ TKingFilterDialog }

constructor TKingFilterDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FConditions := TStringList.Create;
  with FConditions do
  begin
    AddObject('等于', TObject(fcEqual));
    AddObject('不等于', TObject(fcNotEqual));
    AddObject('大于', TObject(fcGreat));
    AddObject('大于或等于', TObject(fcGreatEqual));
    AddObject('小于', TObject(fcLess));
    AddObject('小于或等于', TObject(fcLessEqual));
    AddObject('始于', TObject(fcBeginWith));
    AddObject('并非起始于', TObject(fcNotBeginWith));
    AddObject('止于', TObject(fcEndWith));
    AddObject('并非结束于', TObject(fcNotEndWith));
    AddObject('包含', TObject(fcContain));
    AddObject('不包含', TObject(fcNotContain));
  end;
  FTitle := '智能筛选';
  FFilterStrings := TStringList.Create;
  TStringList(FFilterStrings).OnChange := FilterStringsChange;
end;

destructor TKingFilterDialog.Destroy;
begin
  FConditions.Free;
  FFilterStrings.Free;
  FDataSet := nil;
  inherited;
end;

function TKingFilterDialog.CanUseFilterCondition(Field: TField;
  FilterCondition: TFilterCondition): Boolean;
begin
  case Field.DataType of
    ftUnknown, ftString, ftFixedChar, ftWideString, ftMemo, ftVariant, ftBlob,
      ftFmtMemo:
      Result := True;
    ftSmallint, ftInteger, ftWord, ftFloat, ftCurrency, ftBCD, ftBytes,
      ftVarBytes, ftAutoInc, ftLargeint:
      Result := FilterCondition in [fcEqual, fcNotEqual, fcGreat, fcGreatEqual,
        fcLess, fcLessEqual];
    ftBoolean: Result := FilterCondition in [fcEqual, fcNotEqual];
    ftDate, ftTime, ftDateTime:
      Result := FilterCondition in [fcEqual, fcNotEqual, fcGreat, fcGreatEqual,
        fcLess, fcLessEqual];
    {ftGraphic, ftParadoxOle, ftDBaseOle, ftTypedBinary, ftCursor, ftADT
    ftArray, ftReference, ftDataSet, ftOraBlob, ftOraClob, ftInterface,
    ftIDispatch, ftGuid}
  else
    Result := False;
  end;
end;

procedure TKingFilterDialog.DataSetFilterRecord(DataSet: TDataSet; var Accept:
  Boolean);

  function CompareFieldValue(Field: TField; Value: string): Double;
  begin
    case Field.DataType of
      //      ftUnknown, ftString, ftFixedChar, ftWideString, ftMemo, ftVariant, ftBlob,
      //      ftFmtMemo:
      //        Result := True;
      ftSmallint, ftInteger, ftWord, ftAutoInc, ftLargeint:
        Result := Field.AsInteger - StrToInt(Value);
      ftFloat, ftCurrency, ftBCD, ftBytes, ftVarBytes:
        Result := AnsiCompareStr(Trim(Field.DisplayText), Value);
      // Result := Field.AsFloat - StrToFloat(Value);
   //        Result := FilterCondition in [fcEqual, fcNotEqual, fcGreat, fcGreatEqual,
   //          fcLess, fcLessEqual];
      ftBoolean: if Field.AsBoolean and StrToBoolDef(Value, True) or
        (not Field.AsBoolean and StrToBoolDef(Value, True)) then
          Result := 0
        else
          Result := 1; //FilterCondition in [fcEqual, fcNotEqual];
      ftDate: Result := Trunc(Field.AsDateTime) - StrToDate(Value);
      ftDateTime: Result := Field.AsDateTime - StrToDateTime(Value);
      ftTime: Result := Frac(Field.AsDateTime) - StrToTime(Value);
      //        Result := FilterCondition in [fcEqual, fcNotEqual, fcGreat, fcGreatEqual,
      //          fcLess, fcLessEqual];
            {ftGraphic, ftParadoxOle, ftDBaseOle, ftTypedBinary, ftCursor, ftADT
            ftArray, ftReference, ftDataSet, ftOraBlob, ftOraClob, ftInterface,
            ftIDispatch, ftGuid}
    else
      Result := AnsiCompareStr(Trim(Field.DisplayText), Value);
    end;
  end;

var
  I, APos: Integer;
  Condition: TFilterCondition;
  FieldName, Value, Temp: string;
  e: TFilterRecordEvent;
  s: string; //用来存放Dataset的全局命称,如Form1.Dataset1
begin
  //这个函数就厉害了,它是用数据集的onfilter事件做过滤的,而且还能保存其原有的过滤代码
  Accept := True;
  //  if Accept = False then ShowMessage('Accept');
//如果用户已经指定了数据集的过滤事件,则先调用

//if Assigned(FSaveOnFilterRecord) then
//  FSaveOnFilterRecord(DataSet, Accept);
  s := DataSet.Owner.Name + '.' + DataSet.Name;
  s := s + '=' + SaveTempFilterStr.Values[s];
  TMethod(e).Code := SaveTempFilterStr.Objects[SaveTempFilterStr.IndexOf(s)];
  if Assigned(E) then
  begin
    e(DataSet, Accept);
  end;

  if Accept then
    for I := 0 to SaveTempFilterStr.Count - 1 do
    begin
      Temp := SaveTempFilterStr.Values[DataSet.Owner.Name + '.' + DataSet.Name];
      //      ShowMessage(Temp);

      APos := 1;
      if I <> 0 then
      begin
        if ExtractSubStr(Temp, APos, ';') = '0' then // Logic AND
        begin
          if not Accept then
            Break
        end
        else if Accept then
          Break;
      end
      else
        ExtractSubStr(Temp, APos, ';');
      // FieldName := TField(FFilterStrings.Objects[I]).FieldName;
      FieldName := ExtractSubStr(Temp, APos, ';');
      //ExtractFieldName(Temp, APos);//IndexOfFieldName(FFilterFields, StrToInt(ExtractFieldName(Temp, APos)));
      Condition := TFilterCondition(StrToInt(ExtractSubStr(Temp, APos, ';')));
      Value := ExtractSubStr(Temp, APos, ';');
      //      if DataSet.FieldByName(FieldName).DataType in [ftDate, ftDateTime] then
      //        Value := DateToStr(StrToDate(Value));
      case Condition of
        fcEqual: Accept := CompareFieldValue(DataSet.FieldByName(FieldName),
            Value) = 0;
        fcNotEqual: Accept := CompareFieldValue(DataSet.FieldByName(FieldName),
            Value) <> 0;
        fcGreat: Accept := CompareFieldValue(DataSet.FieldByName(FieldName),
            Value) > 0;
        fcGreatEqual: Accept :=
          CompareFieldValue(DataSet.FieldByName(FieldName), Value) >= 0;
        fcLess: Accept := CompareFieldValue(DataSet.FieldByName(FieldName),
            Value) < 0;
        fcLessEqual: Accept := CompareFieldValue(DataSet.FieldByName(FieldName),
            Value) <= 0;
        fcBeginWith: Accept := LeftStr(DataSet.FieldByName(FieldName).AsString,
            Length(Value)) = Value;
        fcNotBeginWith: Accept :=
          LeftStr(DataSet.FieldByName(FieldName).AsString, Length(Value)) <>
            Value;
        fcEndWith: Accept := RightStr(DataSet.FieldByName(FieldName).AsString,
            Length(Value)) = Value;
        fcNotEndWith: Accept :=
          RightStr(DataSet.FieldByName(FieldName).AsString, Length(Value)) <>
            Value;
        fcContain: Accept := AnsiPos(Value,
            DataSet.FieldByName(FieldName).AsString) > 0;
        fcNotContain: Accept := AnsiPos(Value,
            DataSet.FieldByName(FieldName).AsString) = 0;
      end;
      //      ShowMessage(DataSet.FieldByName(FieldName).AsString + ' - ' + Value + ' = ' +
      //        FloatToStr(CompareFieldValue(DataSet.FieldByName(FieldName), Value)));
    end;
end;

//function TKingFilterDialog.GetDataSet: TDataSet;
//begin
//  if Assigned(FDataSource) then Result := FDataSource.DataSet
//  else Result := nil;
//end;

function TKingFilterDialog.GetFilter;

  function ValueToFilterText(const FieldName, Value: string): string;
  begin
    if Assigned(DataSet) then
      case DataSet.FieldByName(FieldName).DataType of
        ftSmallint, ftInteger, ftWord, ftAutoInc: Result := Value;
        ftFloat, ftCurrency, ftBCD, ftVarBytes, ftBytes, ftTypedBinary: Result
          := Value;
        //       ftDate, ftTime, ftDateTime:
        ftBoolean:
          if Value = '是' then
            Result := 'True'
          else
            Result := 'False';
      else
        Result := '''' + Value + '''';
      end
    else
      Result := Value;
  end;

var
  Temp, FieldName: string;
  I, Pos: Integer;
begin
  Result := '';
  for I := 0 to FFilterStrings.Count - 1 do
  begin
    Temp := FFilterStrings[I];
    Pos := 1;
    if I <> 0 then
    begin
      if ExtractSubStr(Temp, Pos, ';') = '0' then
        Result := Result + ' AND '
      else
        Result := Result + ' OR ';
    end
    else
      ExtractSubStr(Temp, Pos, ';');
    FieldName := TField(FFilterStrings.Objects[I]).FieldName;
    //ExtractFieldName(Temp, APos);//IndexOfFieldName(FFilterFields, StrToInt(ExtractFieldName(Temp, APos)));

  //    FieldName := ExtractSubStr(Temp, Pos, ';');//IndexOfFieldName(FFilterFields, StrToInt(ExtractSubStr(Temp, Pos, ';')));
  //    Result := Result + FieldName;
    case TFilterCondition(StrToInt(ExtractSubStr(Temp, Pos, ';'))) of
      fcEqual: Result := Result + FieldName + ' = ' +
        ValueToFilterText(FieldName, ExtractSubStr(Temp, Pos, ';'));
      fcNotEqual: Result := Result + FieldName + ' <> ' +
        ValueToFilterText(FieldName, ExtractSubStr(Temp, Pos, ';'));
      fcGreat: Result := Result + FieldName + ' >' +
        ValueToFilterText(FieldName, ExtractSubStr(Temp, Pos, ';'));
      fcGreatEqual: Result := Result + FieldName + ' >= ' +
        ValueToFilterText(FieldName, ExtractSubStr(Temp, Pos, ';'));
      fcLess: Result := Result + FieldName + ' < ' +
        ValueToFilterText(FieldName, ExtractSubStr(Temp, Pos, ';'));
      fcLessEqual: Result := Result + FieldName + ' <= ' +
        ValueToFilterText(FieldName, ExtractSubStr(Temp, Pos, ';'));
      fcBeginWith: Result := Result + FieldName + ' LIKE ''' +
        ExtractSubStr(Temp, Pos, ';') + '%''';
      fcNotBeginWith: Result := Result + ' NOT ' + FieldName + ' LIKE ''' +
        ExtractSubStr(Temp, Pos, ';') + '%''';
      fcEndWith: Result := Result + FieldName + ' LIKE ''%' +
        ExtractSubStr(Temp, Pos, ';') + '''';
      fcNotEndWith: Result := Result + ' NOT ' + FieldName + ' LIKE ''%' +
        ExtractSubStr(Temp, Pos, ';') + '''';
      fcContain: Result := Result + FieldName + ' LIKE ''%' +
        ExtractSubStr(Temp, Pos, ';') + '%''';
      fcNotContain: Result := Result + ' NOT ' + FieldName + 'LIKE ''%' +
        ExtractSubStr(Temp, Pos, ';') + '%''';
    end;
  end;
  Result := Trim(Result);
end;

procedure TKingFilterDialog.GetFilterDescriptions(List: TStrings);
var
  I, Pos: Integer;
  S, Temp: string;
begin
  List.Clear;
  for I := 0 to FFilterStrings.Count - 1 do
  begin
    Temp := FFilterStrings[I];
    Pos := 1;
    if I <> 0 then
    begin
      if ExtractSubStr(Temp, Pos) = '0' then
        S := '与'
      else
        S := '或';
    end
    else
      ExtractSubStr(Temp, Pos);
    S := S + ' ' + IndexOfFieldName(FilterFields, StrToInt(ExtractSubStr(Temp,
      Pos)));
    S := S + ' ' + FConditions[StrToInt(ExtractSubStr(Temp, Pos))];
    S := S + ' ' + ExtractSubStr(Temp, Pos) + ' 。';
    List.Add(S);
  end;
end;

function TKingFilterDialog.GetFilterFields: string;
begin
  Result := FFilterFields;
  //  Result := StringReplace(FFilterFields.CommaText, ',', ';', rfReplaceAll);
end;

procedure TKingFilterDialog.SetFilterFields(const Value: string);
begin
  if FFilterFields <> Value then
  begin
    FFilterFields := Value;
    //    InitFieldTypes;
  end;
end;

{procedure TKingFilterDialog.InitFieldTypes;
var
  Pos: Integer;
  FieldName: string;
begin
  if Assigned(DataSet) then
  begin
    SetLength(FFieldTypes, 0);
    Pos := 1;
    FieldName := ExtractFieldName(FFilterFields, Pos);
    while FieldName <> '' do
    begin
      SetLength(FFieldTypes, Length(FFieldTypes) + 1);
      FFieldTypes[High(FFieldTypes)] := DataSet.FieldByName(FieldName).DataType;
      FieldName := ExtractFieldName(FFilterFields, Pos);
    end;
  end;
end;
}

procedure TKingFilterDialog.SetTitle(const Value: string);
begin
  if FTitle <> Value then
  begin
    FTitle := Value;
  end;
end;

procedure TKingFilterDialog.SetDataSet(Value: TDataSet);
begin
  if FDataSet <> Value then
  begin
    if Assigned(DataSet) then
    begin
      DataSet.OnFilterRecord := FSaveOnFilterRecord;
      DataSet.Filtered := FSaveFiltered;
    end;
    FDataSet := Value;
    if Assigned(DataSet) then
    begin
      FSaveOnFilterRecord := DataSet.OnFilterRecord;
      FSaveFiltered := DataSet.Filtered;
      DataSet.OnFilterRecord := DataSetFilterRecord;
    end;
  end;
end;

function TKingFilterDialog.Execute;
var
  FilterForm: TKingFilter;

  procedure FillFieldsComboBox;
  var
    I: Integer;
    //    FieldName: string;
    AFields: TList;
  begin
    //    I := 1;
    //    FieldName := ExtractFieldName(FFilterFields, I);
    if Assigned(DataSet) then
    begin
      AFields := TList.Create;
      try
        with DataSet do
        begin
          if FFilterFields = '' then //如果没有设置过滤字段时,默认是所有字段
            for i := 0 to FieldCount - 1 do
            begin
              if Fields[i].Visible then
                AFields.Add(Fields[i]);
            end
          else
            GetFieldList(AFields, FFilterFields);
          for I := 0 to Fields.Count - 1 do
            if AFields.IndexOf(Fields[I]) >= 0 then
              FilterForm.cbFields.Items.AddObject(Fields[I].DisplayLabel,
                Fields[I]);
        end;
      finally
        AFields.Free;
      end;
    end;

    //      while FieldName <> '' do
    //      begin
    //        FilterForm.cbFields.Items.Add(FDataSource.DataSet.FieldByName(FieldName).DisplayLabel);
    //        FieldName := ExtractFieldName(FFilterFields, I);
    //      end
    //    else
    //      while FieldName <> '' do
    //      begin
    //        FilterForm.cbFields.Items.Add(FieldName);
    //        FieldName := ExtractFieldName(FFilterFields, I);
    //      end
  end;

begin
  Result := False;
  if not Assigned(FDataSet) then
    raise Exception.Create('未设置数据集!');
  FilterForm := TKingFilter.Create(Self);
  with FilterForm do
  try
    Caption := FTitle;
    DataSet := FDataSet;
    FillFieldsComboBox;
    cbConditions.Items.Assign(FConditions);
    //.Items.CommaText := StringReplace(FConditions, ';', ',', [rfReplaceAll]);
//    lbFilter.Items.Assign(FFilterStrings);
    lbFilter.Items.Text := SaveTempFilterStr.Values[DataSet.Owner.Name + '.'
      + DataSet.Name];
    cbConditions.ItemIndex := 0;
    if cbFields.Items.Count > 0 then
    begin
      cbFields.ItemIndex := 0;
      cbFields.OnChange(cbFields);
    end;
    if ShowModal = mrOK then
    begin
      SaveTempFilterStr.Values[DataSet.Owner.Name + '.' + DataSet.Name] :=
        lbFilter.Items.Text;
      if lbFilter.Items.Count > 0 then
      begin
        SaveTempFilterStr.Objects[SaveTempFilterStr.IndexOf(DataSet.Owner.Name +
          '.' + DataSet.Name + '=' + lbFilter.Items.Text)];
        FFilterStrings.Assign(lbFilter.Items);
      end;
      Result := True;
    end;
  finally
    Free;
  end;
end;

procedure TKingFilterDialog.FilterStringsChange(Sender: TObject);
var
  DataSetFiltered: Boolean;
begin
  if not (dfdOnlyBuildFilter in FOptions) and Assigned(DataSet) then
  begin
    DataSetFiltered := DataSet.Filtered;
    DataSet.Filtered := False;
    if (FFilterStrings.Count > 0) or (DataSetFiltered and not FPreFiltered) then
      DataSet.Filtered := True;
    if DataSetFiltered and not FPreFiltered and not FSaveFiltered then
      FSaveFiltered := True;
    FPreFiltered := DataSet.Filtered;
  end;
end;

procedure TKingFilter.btNewClick(Sender: TObject);
var
  S: string;
begin
  S := IntToStr(cbLink.ItemIndex) + ';';
  //  S := S + TField(cbFields.Items.Objects[cbFields.ItemIndex]).FieldName{IntToStr(cbFields.ItemIndex)} + ';' +
  //    IntToStr(Integer(cbConditions.Items.Objects[cbConditions.ItemIndex])) + ';';
  s := s + TField(cbFields.Items.Objects[cbFields.ItemIndex]).FieldName + ';';
  S := S + IntToStr(Integer(cbConditions.Items.Objects[cbConditions.ItemIndex]))
    + ';';
  //  case nbValue.PageIndex of
  //    0: S := S + edtValue.Text;
  //    1: S := S + cbValue.Text;
  //    2: S := S + DateToStr(dtpDate.Date);
  //  end;
  s := s + cbValue.Text + ';';
  //    + edtValue.Text;
  //lbFilter.Items.AddObject(S, cbFields.Items.Objects[cbFields.ItemIndex]);
  lbFilter.Items.Add(S);
  lbFilter.ItemIndex := lbFilter.Items.Count - 1;
  //  lbFilter.Items.AddObject(cbFields.Text + ' ' + cbConditions.Text + ' ' +
  //    edtValue.Text, TObject(Ord(rbAnd.Checked)));
end;

procedure TKingFilter.btDelClick(Sender: TObject);
begin
  lbFilter.Items.Delete(lbFilter.ItemIndex);
  lbFilter.ItemIndex := lbFilter.Items.Count - 1;
end;

procedure TKingFilter.btOkClick(Sender: TObject);
begin
  if (lbFilter.Count = 0) and (MessageDlg('是否将定义的条件添加至列表？',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    btNew.Click;
  ModalResult := mrOK;
end;

procedure TKingFilter.btCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TKingFilter.btClearClick(Sender: TObject);
begin
  lbFilter.Clear;
end;

procedure TKingFilter.btReplaceClick(Sender: TObject);
begin
  btDel.Click;
  btNew.Click;
end;

procedure TKingFilter.FormActivate(Sender: TObject);
begin
  //  cbFieldsChange(cbFields);
end;

initialization
  SaveTempFilterStr := TStringList.Create;
finalization
  FreeAndNil(SaveTempFilterStr);

end.

