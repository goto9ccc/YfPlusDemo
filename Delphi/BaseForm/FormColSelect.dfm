object FrmColSelect: TFrmColSelect
  Left = 291
  Top = 61
  BorderStyle = bsDialog
  Caption = #34920#26684#35774#32622
  ClientHeight = 437
  ClientWidth = 295
  Color = clWindow
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  ShowHint = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 295
    Height = 89
    Align = alTop
    BevelOuter = bvNone
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 0
      Top = 0
      Width = 295
      Height = 89
      Align = alClient
      Caption = #34920#26684#21442#25968
      TabOrder = 0
      object Label1: TLabel
        Left = 51
        Top = 64
        Width = 36
        Height = 12
        Caption = #22266#23450#21015
      end
      object ChkSumList: TCheckBox
        Left = 16
        Top = 14
        Width = 81
        Height = 17
        Caption = #26174#31034#21512#35745#26639
        TabOrder = 0
      end
      object chkAutoColWidth: TCheckBox
        Left = 112
        Top = 14
        Width = 49
        Height = 17
        Caption = #25972#26639
        TabOrder = 1
      end
      object ChkMultiTitle: TCheckBox
        Left = 206
        Top = 14
        Width = 76
        Height = 17
        Caption = #22810#26639#26631#39064
        TabOrder = 2
      end
      object chkGridSort: TCheckBox
        Left = 16
        Top = 38
        Width = 49
        Height = 17
        Caption = #25490#24207
        TabOrder = 3
        OnClick = chkGridSortClick
      end
      object ChkGridMultiSort: TCheckBox
        Left = 112
        Top = 38
        Width = 73
        Height = 17
        Caption = #22810#26639#25490#24207
        TabOrder = 4
      end
      object chkSortLocal: TCheckBox
        Left = 206
        Top = 38
        Width = 75
        Height = 17
        Caption = #26412#22320#25490#24207
        TabOrder = 5
      end
      object EdtFix: TEdit
        Left = 16
        Top = 62
        Width = 17
        Height = 18
        ReadOnly = True
        TabOrder = 6
        Text = '0'
      end
      object UpDownFix: TUpDown
        Left = 33
        Top = 62
        Width = 15
        Height = 18
        Associate = EdtFix
        TabOrder = 7
      end
      object ColorBox1: TColorBox
        Left = 91
        Top = 59
        Width = 89
        Height = 22
        Hint = #22855#25968#34892#39068#33394
        Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbIncludeDefault, cbCustomColor]
        BevelKind = bkFlat
        ItemHeight = 16
        TabOrder = 8
      end
      object ColorBox2: TColorBox
        Left = 184
        Top = 59
        Width = 89
        Height = 22
        Hint = #20598#25968#34892#39068#33394
        Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbIncludeDefault, cbCustomColor]
        BevelKind = bkFlat
        ItemHeight = 16
        TabOrder = 9
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 89
    Width = 295
    Height = 348
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel2'
    TabOrder = 1
    object CLB: TCheckListBox
      Left = 0
      Top = 0
      Width = 159
      Height = 348
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      Ctl3D = False
      ItemHeight = 12
      ParentCtl3D = False
      Style = lbOwnerDrawFixed
      TabOrder = 0
      OnClick = CLBClick
      OnDragOver = CLBDragOver
    end
    object Panel3: TPanel
      Left = 159
      Top = 0
      Width = 136
      Height = 348
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      DesignSize = (
        136
        348)
      object BitBtn1: TBitBtn
        Left = 23
        Top = 307
        Width = 90
        Height = 30
        Anchors = [akBottom]
        Caption = #21462#28040'&C'
        TabOrder = 3
        Kind = bkCancel
      end
      object BitBtn2: TBitBtn
        Left = 23
        Top = 272
        Width = 90
        Height = 30
        Anchors = [akBottom]
        Caption = #30830#23450'&O'
        Default = True
        TabOrder = 2
        OnClick = Button2Click
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
      end
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 136
        Height = 233
        Align = alTop
        Anchors = [akLeft, akTop, akRight, akBottom]
        BevelOuter = bvNone
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 0
        object GroupBox2: TGroupBox
          Left = 0
          Top = 8
          Width = 136
          Height = 225
          Align = alBottom
          Caption = #23383#27573#21442#25968
          TabOrder = 0
          object SpeedButton6: TSpeedButton
            Left = 10
            Top = 16
            Width = 23
            Height = 22
            Hint = #36873#25321#39033#32622#39030
            Caption = #39030
            Flat = True
            OnClick = SpeedButton6Click
          end
          object SpeedButton1: TSpeedButton
            Left = 42
            Top = 16
            Width = 23
            Height = 22
            Hint = #36873#25321#39033#19978#31227
            Caption = #19978
            Flat = True
            OnClick = SpeedButton1Click
          end
          object SpeedButton2: TSpeedButton
            Left = 74
            Top = 16
            Width = 23
            Height = 22
            Hint = #36873#25321#39033#19979#31227
            Caption = #19979
            Flat = True
            OnClick = SpeedButton2Click
          end
          object SpeedButton7: TSpeedButton
            Left = 106
            Top = 16
            Width = 23
            Height = 22
            Hint = #36873#25321#39033#32622#24213
            Caption = #24213
            Flat = True
            OnClick = SpeedButton7Click
          end
          object Label3: TLabel
            Left = 8
            Top = 141
            Width = 48
            Height = 12
            Caption = #32479#35745#23383#27573
            FocusControl = EditSumValue
          end
          object Label2: TLabel
            Left = 8
            Top = 101
            Width = 48
            Height = 12
            Caption = #32479#35745#31867#22411
          end
          object Label4: TLabel
            Left = 8
            Top = 181
            Width = 36
            Height = 12
            Caption = #32479#35745#20540
            FocusControl = EditSumValue
          end
          object EditSumValue: TLabeledEdit
            Left = 8
            Top = 197
            Width = 121
            Height = 22
            EditLabel.Width = 6
            EditLabel.Height = 12
            Enabled = False
            TabOrder = 5
            OnExit = OnSaveFieldValue
          end
          object EditSumField: TComboBox
            Left = 8
            Top = 157
            Width = 121
            Height = 22
            BevelKind = bkFlat
            Style = csOwnerDrawFixed
            Enabled = False
            ItemHeight = 16
            TabOrder = 4
            OnExit = OnSaveFieldValue
          end
          object CbxSumType: TComboBox
            Left = 8
            Top = 117
            Width = 121
            Height = 22
            BevelKind = bkSoft
            Style = csOwnerDrawFixed
            ItemHeight = 16
            TabOrder = 3
            OnChange = CbxSumTypeChange
            OnExit = OnSaveFieldValue
            Items.Strings = (
              #19981#32479#35745
              #26174#31034#25991#23383
              #23383#27573#20540
              #24179#22343#20540
              #35745#25968#20540
              #21512#35745#20540)
          end
          object ChkSort: TCheckBox
            Left = 8
            Top = 82
            Width = 73
            Height = 17
            Caption = #25490#24207
            TabOrder = 1
            OnExit = OnSaveFieldValue
          end
          object ChkReadOnly: TCheckBox
            Left = 64
            Top = 82
            Width = 57
            Height = 17
            Caption = #21482#35835
            TabOrder = 2
            OnExit = OnSaveFieldValue
          end
          object EdtFieldTitle: TLabeledEdit
            Left = 8
            Top = 58
            Width = 121
            Height = 22
            EditLabel.Width = 48
            EditLabel.Height = 12
            EditLabel.Caption = #26174#31034#26631#39064
            TabOrder = 0
            OnExit = OnSaveFieldValue
          end
        end
      end
      object BitBtn3: TBitBtn
        Left = 23
        Top = 237
        Width = 90
        Height = 30
        Anchors = [akLeft, akBottom]
        Caption = #37325#32622'&R'
        TabOrder = 1
        OnClick = BitBtn3Click
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333444444
          33333333333F8888883F33330000324334222222443333388F3833333388F333
          000032244222222222433338F8833FFFFF338F3300003222222AAAAA22243338
          F333F88888F338F30000322222A33333A2224338F33F8333338F338F00003222
          223333333A224338F33833333338F38F00003222222333333A444338FFFF8F33
          3338888300003AAAAAAA33333333333888888833333333330000333333333333
          333333333333333333FFFFFF000033333333333344444433FFFF333333888888
          00003A444333333A22222438888F333338F3333800003A2243333333A2222438
          F38F333333833338000033A224333334422224338338FFFFF8833338000033A2
          22444442222224338F3388888333FF380000333A2222222222AA243338FF3333
          33FF88F800003333AA222222AA33A3333388FFFFFF8833830000333333AAAAAA
          3333333333338888883333330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
      end
    end
    object EdtFieldName: TLabeledEdit
      Left = 16
      Top = 312
      Width = 121
      Height = 18
      Color = cl3DLight
      EditLabel.Width = 48
      EditLabel.Height = 12
      EditLabel.Caption = #23383#27573#21517#31216
      TabOrder = 2
      Visible = False
    end
  end
end
