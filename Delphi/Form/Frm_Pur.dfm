inherited FormPur: TFormPur
  Caption = #35831#36141#37319#36141#26085#21382#28436#31034
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 12
  inherited pnl1: TPanel
    inherited lbl6: TLabel
      Left = 8
      Top = 39
      Width = 56
      Height = 14
      Caption = #36873#25321#26376#20221
      Font.Color = clBlack
      Font.Height = -14
      ParentFont = False
    end
    inherited lbl1: TLabel
      Left = 152
      Width = 200
      Caption = #24403#26376#35831#36141#37319#36141#26085#21382
    end
    object lbl2: TLabel [2]
      Left = 392
      Top = 37
      Width = 154
      Height = 14
      Caption = #21452#20987#26085#26399#22359#21306#22495#26174#31034#26126#32454
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    inherited dtp: TDateTimePicker
      Left = 72
      Top = 35
      Width = 97
      Height = 22
      Font.Color = clBlack
      Font.Height = -14
      ParentFont = False
      OnChange = dtp1Change
    end
    object rbTB: TRadioButton
      Left = 200
      Top = 37
      Width = 73
      Height = 17
      Caption = #35831#36141
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      TabStop = True
      OnClick = rbTBClick
    end
    object rbTD: TRadioButton
      Left = 296
      Top = 37
      Width = 73
      Height = 17
      Caption = #37319#36141
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = rbTDClick
    end
  end
  inherited dbctrlgrd: TDBCtrlGrid
    OnDblClick = dbctrlgrdDblClick
    inherited dbtxtTD013: TDBText
      DataField = 'TB011'
    end
    object lbl3: TLabel
      Left = 50
      Top = 56
      Width = 70
      Height = 14
      Caption = #31508#38656#35201#20132#36135
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object dbtxtTD016: TDBText
      Left = 22
      Top = 56
      Width = 25
      Height = 17
      DataField = 'TB001'
      DataSource = ds
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object lbl4: TLabel
      Left = 4
      Top = 80
      Width = 14
      Height = 14
      Caption = #20849
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object dbtxtTD009: TDBText
      Left = 21
      Top = 80
      Width = 41
      Height = 17
      DataField = 'TB009'
      DataSource = ds
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object lbl5: TLabel
      Left = 80
      Top = 80
      Width = 14
      Height = 14
      Caption = #20214
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
  end
end
