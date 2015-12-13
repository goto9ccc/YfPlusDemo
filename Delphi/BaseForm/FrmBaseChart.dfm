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
    BackWall.Gradient.EndColor = clWhite
    BackWall.Gradient.StartColor = 15395562
    BackWall.Gradient.Visible = True
    BackWall.Transparent = False
    BottomWall.Gradient.EndColor = 16580349
    BottomWall.Gradient.StartColor = 3114493
    Foot.Font.Name = 'Verdana'
    Gradient.EndColor = clWhite
    Gradient.MidColor = 15395562
    Gradient.StartColor = 15395562
    Gradient.Visible = True
    LeftWall.Color = 14745599
    LeftWall.Gradient.EndColor = 2413052
    LeftWall.Gradient.StartColor = 900220
    RightWall.Color = 14745599
    SubFoot.Font.Name = 'Verdana'
    SubTitle.Font.Name = 'Verdana'
    Title.Font.Name = 'Verdana'
    Title.Font.Style = [fsBold]
    Title.Text.Strings = (
      'TDBChart')
    BottomAxis.Axis.Color = 4210752
    BottomAxis.Grid.Color = 11119017
    BottomAxis.LabelsFont.Name = 'Verdana'
    BottomAxis.MinorTicks.Color = clBlack
    BottomAxis.TicksInner.Color = 11119017
    BottomAxis.Title.Font.Name = 'Verdana'
    DepthAxis.Axis.Color = 4210752
    DepthAxis.Grid.Color = 11119017
    DepthAxis.LabelsFont.Name = 'Verdana'
    DepthAxis.MinorTicks.Color = clBlack
    DepthAxis.TicksInner.Color = 11119017
    DepthAxis.Title.Font.Name = 'Verdana'
    DepthTopAxis.Axis.Color = 4210752
    DepthTopAxis.Grid.Color = 11119017
    DepthTopAxis.LabelsFont.Name = 'Verdana'
    DepthTopAxis.MinorTicks.Color = clBlack
    DepthTopAxis.TicksInner.Color = 11119017
    DepthTopAxis.Title.Font.Name = 'Verdana'
    LeftAxis.Axis.Color = 4210752
    LeftAxis.Grid.Color = 11119017
    LeftAxis.LabelsFont.Name = 'Verdana'
    LeftAxis.MinorTicks.Color = clBlack
    LeftAxis.TicksInner.Color = 11119017
    LeftAxis.Title.Font.Name = 'Verdana'
    Legend.Font.Name = 'Verdana'
    Legend.Gradient.Direction = gdTopBottom
    Legend.Gradient.EndColor = clYellow
    Legend.Gradient.StartColor = clWhite
    Legend.Shadow.Color = clGray
    RightAxis.Axis.Color = 4210752
    RightAxis.Grid.Color = 11119017
    RightAxis.LabelsFont.Name = 'Verdana'
    RightAxis.MinorTicks.Color = clBlack
    RightAxis.TicksInner.Color = 11119017
    RightAxis.Title.Font.Name = 'Verdana'
    Shadow.Color = clBlack
    TopAxis.Axis.Color = 4210752
    TopAxis.Grid.Color = 11119017
    TopAxis.LabelsFont.Name = 'Verdana'
    TopAxis.MinorTicks.Color = clBlack
    TopAxis.TicksInner.Color = 11119017
    TopAxis.Title.Font.Name = 'Verdana'
    View3D = False
    Zoom.Allow = False
    Align = alClient
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
