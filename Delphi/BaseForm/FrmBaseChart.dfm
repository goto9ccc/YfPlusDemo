object FormBaseChart: TFormBaseChart
  Left = 354
  Top = 104
  Width = 757
  Height = 675
  Caption = 'FormBaseChart'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object dbcht: TDBChart
    Left = 0
    Top = 0
    Width = 741
    Height = 636
    AllowPanning = pmNone
    BackWall.Gradient.EndColor = 11118482
    BackWall.Gradient.Visible = True
    BackWall.Transparent = False
    Border.Color = 14645801
    Border.Width = 7
    Border.Visible = True
    BottomWall.Gradient.EndColor = 16580349
    BottomWall.Gradient.StartColor = 3114493
    BottomWall.Gradient.Visible = True
    Foot.Font.Name = 'Verdana'
    Gradient.Direction = gdDiagonalDown
    Gradient.EndColor = 11645361
    Gradient.Visible = True
    LeftWall.Gradient.EndColor = 2413052
    LeftWall.Gradient.StartColor = 900220
    LeftWall.Gradient.Visible = True
    SubFoot.Font.Name = 'Verdana'
    SubTitle.Font.Name = 'Verdana'
    Title.Font.Style = [fsBold]
    Title.Text.Strings = (
      'TDBChart')
    BottomAxis.MinorTicks.Color = clBlack
    BottomAxis.TicksInner.Color = 11119017
    DepthAxis.MinorTicks.Color = clBlack
    DepthAxis.TicksInner.Color = 11119017
    DepthTopAxis.MinorTicks.Color = clBlack
    DepthTopAxis.TicksInner.Color = 11119017
    LeftAxis.MinorTicks.Color = clBlack
    LeftAxis.TicksInner.Color = 11119017
    Legend.Gradient.Direction = gdTopBottom
    Legend.Gradient.EndColor = clYellow
    Legend.Gradient.StartColor = clWhite
    Legend.Gradient.Visible = True
    Legend.Shadow.Color = clGray
    Legend.Shadow.Transparency = 50
    RightAxis.MinorTicks.Color = clBlack
    RightAxis.TicksInner.Color = 11119017
    Shadow.Color = clBlack
    Shadow.HorizSize = 10
    Shadow.VertSize = 10
    TopAxis.MinorTicks.Color = clBlack
    TopAxis.TicksInner.Color = 11119017
    View3D = False
    Zoom.Allow = False
    Align = alClient
    BevelOuter = bvNone
    PopupMenu = pm1
    TabOrder = 0
    PrintMargins = (
      15
      11
      15
      11)
    ColorPaletteIndex = 9
  end
  object qry: TADOQuery
    Connection = CommonModule.conDb
    BeforeOpen = qryBeforeOpen
    AfterOpen = qryAfterOpen
    Parameters = <>
    Left = 88
    Top = 96
  end
  object pm1: TPopupMenu
    Left = 128
    Top = 96
    object N1: TMenuItem
      Caption = #20840#23631
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #20445#23384#20026'BMP'
      OnClick = N2Click
    end
    object N4: TMenuItem
      Caption = #26597#30475#25968#25454#28304
    end
    object N3: TMenuItem
      Caption = #20851#38381
      OnClick = N3Click
    end
  end
  object dlgSave: TSaveDialog
    DefaultExt = '*.BMP'
    Filter = '*.BMP'
    Left = 48
    Top = 96
  end
end
