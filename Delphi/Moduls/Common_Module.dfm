object CommonModule: TCommonModule
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 388
  Top = 223
  Height = 150
  Width = 215
  object conComm: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 56
    Top = 32
  end
  object conDb: TADOConnection
    LoginPrompt = False
    Left = 104
    Top = 32
  end
end
