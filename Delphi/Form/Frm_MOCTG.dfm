inherited FormMoctg: TFormMoctg
  Left = 501
  Top = 262
  Caption = #24037#21333#26085#21382#30475#26495
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 12
  inherited pnl1: TPanel
    Height = 81
    inherited lbl6: TLabel
      Left = 8
      Top = 56
      Width = 56
      Height = 14
      Caption = #36873#25321#26376#20221
      Font.Height = -14
    end
    inherited lblTitle: TLabel
      Left = 288
      Width = 150
      Caption = #24037#21333#20837#24211#26085#21382
    end
    object lbl3: TLabel [2]
      Left = 184
      Top = 56
      Width = 91
      Height = 14
      Caption = #36873#25321#24037#20316#20013#24515':'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object btnTA033: TSpeedButton [3]
      Left = 363
      Top = 52
      Width = 23
      Height = 22
      Hint = #26597#25214#25209#27425#20449#24687
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000141D13F013CCB7F0138C77F0143D53F000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000229B7FF0C56E4FF0258F7FF0039C9FF000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000031BDBF0C4FE2FF025AFBFF0058FFFF026DE0FF000000000000
        000000000000425FAF3F2646AF7F2547B17F2347B17F00000000000000000000
        00000431B9BF0250E2FF005EFFFF0060FFFF0068ECFF003AC1BF000000004B67
        AD3F1A3CB0BF003DD6FF0050ECFF0054EEFF004CE2FF0033BDFF2F5DBC3F0B35
        B5BF005CE4FF0077FFFF007FFFFF0058D8FF002CBBBF00000000000000000029
        B7FF0C64F0FF6290C9FFA6A698FFA2A49AFF5A89C7FF046DFBFF0254CFFF0658
        E0FF0090FFFF007BEAFF0039BFFF003AC57F00000000000000001B3BB2BF0A66
        EEFFB7B296FFEABD64FFE2BF6FFFE2C16FFFE6C36FFF98A6A2FF027DFFFF0679
        E2FF003DC1FF0D44C27F00000000000000000000000000000000003BC5FF5E9E
        D1FFE2C673FFDECA81FFDECE87FFDED087FFD8D287FFDCD083FF3587DEFF0285
        EAFF184CC07F00000000000000000000000000000000000000000056D8FF90B7
        B5FFE0DAA2FFE2E2B1FFE0E2B1FFDEE2B5FFDEE2B5FFD8E4A7FF549ECBFF04A0
        FBFF1A55C27F0000000000000000000000000000000000000000005CD6FF7BB7
        C5FFEBF3D0FFE9F3D2FFE7F3D2FFE7F3D6FFE7F3D6FFE4F3CDFF419CDAFF04A6
        F9FF1E58C17F0000000000000000000000000000000000000000003FC1FF2BAB
        EAFFEEF5DCFFF3FBEFFFF3FBEFFFF3FBEFFFF5FDEFFFCDE6DAFF0C90F6FF028B
        E6FF2254BE7F0000000000000000000000000000000000000000355FBB7F0087
        E6FF50BDE2FFD0EEDCFFF0FDEAFFEEFDEAFFB9DEE0FF239CEEFF00AEFBFF0033
        B5FF000000000000000000000000000000000000000000000000000000001B49
        BDBF008FEAFF04AEFBFF20AFEEFF18A6F0FF00AAFDFF00AAF6FF0043BFFF407F
        CE3F000000000000000000000000000000000000000000000000000000000000
        00003464C57F003DBFFF0066D4FF006DD8FF0054C9FF1646BDBF4183D23F0000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = btnTA033Click
    end
    object lbl2: TLabel [4]
      Left = 416
      Top = 56
      Width = 154
      Height = 14
      Caption = #21452#20987#26085#26399#22359#21306#22495#26174#31034#26126#32454
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    inherited dtp: TDateTimePicker
      Left = 72
      Top = 52
      Width = 105
      Height = 22
      Font.Height = -14
      ParentFont = False
      OnChange = dtp1Change
    end
    object edtCMSMD: TEdit
      Left = 278
      Top = 52
      Width = 83
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
  end
  inherited dbctrlgrd: TDBCtrlGrid
    Top = 81
    Height = 509
    PanelHeight = 101
    OnDblClick = dbctrlgrdDblClick
    inherited dbtxtTD013: TDBText
      DataField = 'TA009'
      OnDblClick = dbctrlgrdDblClick
    end
    object lbl7: TLabel
      Left = 64
      Top = 40
      Width = 28
      Height = 14
      Caption = #23436#24037
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Transparent = True
      OnDblClick = dbctrlgrdDblClick
    end
    object dbtxtTD016: TDBText
      Left = 24
      Top = 40
      Width = 25
      Height = 17
      DataField = 'TA009B'
      DataSource = ds
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Transparent = True
      OnDblClick = dbctrlgrdDblClick
    end
    object lbl4: TLabel
      Left = 8
      Top = 64
      Width = 14
      Height = 14
      Caption = #20849
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Transparent = True
      OnDblClick = dbctrlgrdDblClick
    end
    object dbtxtTD009: TDBText
      Left = 24
      Top = 64
      Width = 41
      Height = 17
      DataField = 'TA015'
      DataSource = ds
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Transparent = True
      OnDblClick = dbctrlgrdDblClick
    end
    object lbl5: TLabel
      Left = 72
      Top = 64
      Width = 14
      Height = 14
      Caption = #20214
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Transparent = True
      OnDblClick = dbctrlgrdDblClick
    end
  end
end
