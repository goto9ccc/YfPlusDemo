inherited FormOpenSearch: TFormOpenSearch
  Left = 312
  Top = 95
  Width = 772
  Height = 558
  Caption = #36890#29992#26597#35810
  PixelsPerInch = 96
  TextHeight = 12
  inherited pnltop: TPanel
    Width = 756
    object lbl1: TLabel [1]
      Left = 228
      Top = 12
      Width = 59
      Height = 13
      Caption = #26597#35810#26465#20214':'
    end
    inherited edtName: TEdit
      Left = 104
      TabOrder = 1
    end
    inherited btnsearch: TButton
      Left = 480
      Top = 7
      TabOrder = 0
      OnClick = btnsearchClick
    end
    object edt1: TEdit
      Left = 312
      Top = 9
      Width = 109
      Height = 19
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 2
      OnKeyPress = edtNameKeyPress
    end
  end
  inherited dbgrdh: TDBGridEh
    Width = 756
    Height = 394
    ReadOnly = True
    STFilter.Local = True
    TabOrder = 2
    OnDblClick = dbgrdhDblClick
  end
  inherited clbr1: TCoolBar
    Width = 756
    Bands = <
      item
        Control = tlb1
        ImageIndex = -1
        MinHeight = 53
        Width = 752
      end>
    inherited tlb1: TToolBar
      Width = 739
    end
  end
  inherited stat1: TStatusBar
    Top = 500
    Width = 756
  end
  inherited ds: TDataSource
    Left = 208
  end
end
