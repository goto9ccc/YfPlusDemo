object BaseCtrlGrid: TBaseCtrlGrid
  Left = 134
  Top = 106
  Width = 890
  Height = 629
  Caption = 'BaseCtrlGrid'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 12
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 874
    Height = 65
    Align = alTop
    Color = 16769486
    TabOrder = 0
    object lbl6: TLabel
      Left = 16
      Top = 40
      Width = 72
      Height = 12
      Caption = #36873#25321#20854#23427#26376#20221
    end
    object lblTitle: TLabel
      Left = 392
      Top = 8
      Width = 100
      Height = 24
      Caption = #26085#21382#21517#31216
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -24
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
    object dtp: TDateTimePicker
      Left = 96
      Top = 36
      Width = 89
      Height = 20
      Date = 40731.934964826390000000
      Time = 40731.934964826390000000
      TabOrder = 0
    end
  end
  object dbctrlgrd: TDBCtrlGrid
    Left = 0
    Top = 65
    Width = 874
    Height = 525
    Cursor = crHandPoint
    Align = alClient
    AllowDelete = False
    AllowInsert = False
    ColCount = 7
    Color = 16769486
    DataSource = ds
    PanelBorder = gbNone
    PanelHeight = 105
    PanelWidth = 122
    ParentColor = False
    TabOrder = 1
    RowCount = 5
    OnPaintPanel = dbctrlgrdPaintPanel
    object dbtxtTD013: TDBText
      Left = 16
      Top = 8
      Width = 49
      Height = 33
      DataField = 'TD013'
      DataSource = ds
      Font.Charset = ANSI_CHARSET
      Font.Color = clGreen
      Font.Height = -24
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object ds: TDataSource
    DataSet = qry
    Left = 240
    Top = 200
  end
  object qry: TADOQuery
    Connection = CommonModule.conDb
    BeforeOpen = qryBeforeOpen
    AfterOpen = qryAfterOpen
    Parameters = <>
    Left = 384
    Top = 200
  end
end
