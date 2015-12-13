object FormMain: TFormMain
  Left = 298
  Top = 192
  Width = 1088
  Height = 750
  Caption = 'FormMain'
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object statInfo: TStatusBar
    Left = 0
    Top = 692
    Width = 1072
    Height = 19
    Panels = <>
  end
  object clbr1: TCoolBar
    Left = 0
    Top = 0
    Width = 1072
    Height = 75
    Bands = <
      item
        Control = tlb1
        ImageIndex = -1
        MinHeight = 65
        Width = 1068
      end>
    object tlb1: TToolBar
      Left = 9
      Top = 0
      Width = 1055
      Height = 65
      Caption = 'tlb1'
      TabOrder = 0
    end
  end
end
