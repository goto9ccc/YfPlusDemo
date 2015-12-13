object KingFilter: TKingFilter
  Left = 508
  Top = 324
  BorderStyle = bsDialog
  Caption = #33258#23450#20041#31579#36873
  ClientHeight = 299
  ClientWidth = 498
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 15
  object gbFilterConditions: TGroupBox
    Left = 0
    Top = 65
    Width = 369
    Height = 193
    Align = alClient
    Caption = #31579#36873#26465#20214'(&T)'
    TabOrder = 0
    object lbFilter: TListBox
      Left = 2
      Top = 17
      Width = 365
      Height = 174
      Style = lbOwnerDrawFixed
      Align = alClient
      BevelInner = bvNone
      BevelKind = bkFlat
      BevelOuter = bvNone
      ItemHeight = 16
      TabOrder = 0
      OnDblClick = lbFilterDblClick
      OnDrawItem = lbFilterDrawItem
    end
  end
  object gbDefineCondition: TGroupBox
    Left = 0
    Top = 0
    Width = 498
    Height = 65
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 69
      Top = 14
      Width = 62
      Height = 15
      Caption = #39033#30446'(&I):'
      FocusControl = cbFields
    end
    object Label2: TLabel
      Left = 216
      Top = 14
      Width = 62
      Height = 15
      Caption = #26465#20214'(&C):'
      FocusControl = cbConditions
    end
    object Label3: TLabel
      Left = 328
      Top = 14
      Width = 47
      Height = 15
      Caption = #20540'(&V):'
    end
    object cbFields: TComboBox
      Left = 69
      Top = 30
      Width = 141
      Height = 23
      BevelInner = bvNone
      BevelKind = bkFlat
      BevelOuter = bvRaised
      Style = csDropDownList
      ItemHeight = 15
      TabOrder = 0
      OnChange = cbFieldsChange
    end
    object cbConditions: TComboBox
      Left = 216
      Top = 30
      Width = 105
      Height = 23
      BevelInner = bvNone
      BevelKind = bkFlat
      BevelOuter = bvRaised
      Style = csDropDownList
      DropDownCount = 12
      ItemHeight = 15
      TabOrder = 1
      Items.Strings = (
        #31561#20110
        #19981#31561#20110
        #22823#20110
        #22823#20110#25110#31561#20110
        #23567#20110
        #23567#20110#25110#31561#20110
        #22987#20110
        #24182#38750#36215#22987#20110
        #27490#20110
        #24182#38750#32467#26463#20110
        #21253#21547
        #19981#21253#21547)
    end
    object cbLink: TComboBox
      Left = 8
      Top = 30
      Width = 54
      Height = 23
      BevelInner = bvNone
      BevelKind = bkFlat
      BevelOuter = bvRaised
      Style = csDropDownList
      DropDownCount = 12
      ItemHeight = 15
      ItemIndex = 0
      TabOrder = 2
      Text = #24182#19988
      Items.Strings = (
        #24182#19988
        #25110#32773)
    end
    object cbValue: TComboBox
      Left = 328
      Top = 30
      Width = 145
      Height = 23
      BevelInner = bvNone
      BevelKind = bkFlat
      BevelOuter = bvRaised
      ItemHeight = 15
      Sorted = True
      TabOrder = 3
    end
  end
  object GroupBox1: TGroupBox
    Left = 369
    Top = 65
    Width = 129
    Height = 193
    Align = alRight
    Caption = #25805#20316
    TabOrder = 2
    object btNew: TSpeedButton
      Left = 8
      Top = 72
      Width = 113
      Height = 25
      Caption = #28155#21152#26465#20214
      Flat = True
      Glyph.Data = {
        4E010000424D4E01000000000000760000002800000013000000120000000100
        040000000000D8000000C40E0000C40E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333000003333333333333333333000003333333333333333333000003333
        333A44433333333000003333333A22433333333000003333333A224333333330
        00003333333A22433333333000003333333A224333333330000033A4444A2244
        44443330000033A22222222222243330000033A22222222222243330000033AA
        AAAA224AAAA4333000003333333A22433333333000003333333A224333333330
        00003333333A22433333333000003333333A22433333333000003333333AAA43
        333333300000333333333333333333300000}
      OnClick = btNewClick
    end
    object btDel: TSpeedButton
      Left = 8
      Top = 101
      Width = 113
      Height = 25
      Caption = #21024#38500#26465#20214
      Flat = True
      Glyph.Data = {
        4E010000424D4E01000000000000760000002800000013000000120000000100
        040000000000D8000000C40E0000C40E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333000003333333333333333333000003333333333333333333000003333
        3333333333333330000033333333333333333330000033333333333333333330
        0000333333333333333333300000333333333333333333300000338888888888
        8888333000003391111111111118333000003391111111111118333000003399
        9999999999993330000033333333333333333330000033333333333333333330
        0000333333333333333333300000333333333333333333300000333333333333
        333333300000333333333333333333300000}
      OnClick = btDelClick
    end
    object btOk: TSpeedButton
      Left = 8
      Top = 129
      Width = 113
      Height = 25
      Caption = #31579'    '#36873
      Flat = True
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      OnClick = btOkClick
    end
    object btCancel: TSpeedButton
      Left = 8
      Top = 157
      Width = 113
      Height = 25
      Caption = #36864'    '#20986
      Flat = True
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      OnClick = btCancelClick
    end
    object btClear: TSpeedButton
      Left = 8
      Top = 16
      Width = 113
      Height = 25
      Caption = #28165#38500#26465#20214
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        0000000000000000000000000000000000000000000000000000000000000000
        00FF00FFFF00FFFF00FFFF00FFFF00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF00FFFF00FFFF00FFFF00FFFF00FF
        000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
        00FF00FFFF00FFFF00FFFF00FFFF00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF00FFFF00FFFF00FFFF00FFFF00FF
        000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
        00FF00FFFF00FFFF00FFFF00FFFF00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF00FFFF00FFFF00FFFF00FFFF00FF
        000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
        00FF00FFFF00FFFF00FFFF00FFFF00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF00FFFF00FFFF00FFFF00FFFF00FF
        000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
        00FF00FFFF00FFFF00FFFF00FFFF00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFF000000000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FF
        000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF000000FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        000000000000000000000000000000000000000000000000FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      OnClick = btClearClick
    end
    object btReplace: TSpeedButton
      Left = 8
      Top = 44
      Width = 113
      Height = 25
      Caption = #26367#25442#26465#20214
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8484840000008484
        84FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FF848484000000000000C6C6C6000000000000848484FF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FF848484000000FFFF00FFFF00FFFFFFFFFF
        00FF0000000000848484FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00
        0000FFFF00FFFF00FFFF00848484FF0000FFFF00FF0000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FF000000FFFF00FFFF00848484C6C6C68484
        84FF0000FFFF00000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00
        0000848484848484FFFF00FFFFFFFFFF00848484848484000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FFFF00FFFFFFFFFF00FFFF
        FFFFFF00000000FF00FFFF00FFFF00FFFF00FF000000000000000000FF00FFFF
        00FFFF00FF000000000000FFFF00000000000000FF00FFFF00FFFF00FF000000
        0000000000FF0000840000FF000000000000FF00FFFF00FFFF00FF000000FF00
        FFFF00FFFF00FFFF00FFFF00FF0000000000FF0000FF0000FF0000FF0000FF00
        0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FFFFFF
        0000FFFFFFFFFFFFFFFFFFFF0000FF0000FF000000FF00FFFF00FFFF00FF8400
        00840000FF00FFFF00FF000000FFFFFF0000FF0000FF0000FF0000FF0000FF00
        0084000000FF00FFFF00FFFF00FF840000840000FF00FFFF00FF000000FFFFFF
        0000FFFFFFFFFFFFFFFFFFFF0000FF0000FF000000FF00FF8400008400008400
        00840000840000840000FF00FF000000FFFFFF0000FF0000FF0000FF0000FF00
        0000FF00FFFF00FF840000840000840000840000840000840000FF00FF000000
        000000FFFFFFFFFFFFFFFFFF000000000000FF00FFFF00FFFF00FFFF00FF8400
        00840000FF00FFFF00FFFF00FFFF00FFFF00FF000000000000000000FF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FF840000840000FF00FFFF00FF}
      OnClick = btReplaceClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 258
    Width = 498
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object Label4: TLabel
      Left = 16
      Top = 3
      Width = 465
      Height = 35
      AutoSize = False
      Caption = 
        #36825#37324#25105#20934#22791#25918#30340#26159#25226#26465#20214#20648#23384#21040#25968#25454#24211#30340#21151#33021'!'#21483#20570'< '#39044#35774#26465#20214'>'#13#10#21482#35201#25226'lbFilter.Items.Text'#20445#23384#21040#25968#25454#24211#20013','#32473#19968 +
        #20010#26631#39064#21363#21487'!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -15
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Visible = False
    end
  end
end