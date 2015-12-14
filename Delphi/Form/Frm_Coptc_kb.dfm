inherited FormCoptd_KB: TFormCoptd_KB
  Left = 223
  Top = 144
  Caption = #24403#26376#35746#21333#24212#20132#26410#20132#26085#21382
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 12
  inherited pnl1: TPanel
    inherited lbl6: TLabel
      Left = 32
      Width = 56
      Height = 14
      Caption = #36873#25321#26376#20221
      Font.Height = -14
      ParentFont = False
    end
    inherited lblTitle: TLabel
      Left = 224
    end
    object lbl2: TLabel [2]
      Left = 248
      Top = 41
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
      Width = 129
      Height = 22
      Font.Height = -14
      ParentFont = False
      OnChange = dtpChange
    end
  end
  inherited dbctrlgrd: TDBCtrlGrid
    OnDblClick = dbctrlgrd1DblClick
    object dbtxtTD016: TDBText [0]
      Left = 32
      Top = 56
      Width = 25
      Height = 17
      DataField = 'TD016'
      DataSource = ds
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object dbtxtTD009: TDBText [1]
      Left = 32
      Top = 80
      Width = 41
      Height = 17
      DataField = 'TD009'
      DataSource = ds
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl3: TLabel
      Left = 64
      Top = 56
      Width = 56
      Height = 14
      Caption = #38656#35201#20132#36135
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl4: TLabel
      Left = 8
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
    end
  end
  inherited qry: TADOQuery
    SQL.Strings = (
      
        'Select SUM(TD008-TD009) AS TD008,TD013,Count(TD016) as TD016 fro' +
        'm COPTD Where TD016 = '#39#39'N'#39#39)
  end
end
