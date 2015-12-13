object CommonModule: TCommonModule
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 388
  Top = 223
  Height = 150
  Width = 215
  object conComm: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=tomato;Persist Security Info=True;U' +
      'ser ID=sa;Initial Catalog=DSCSYS;Data Source=127.0.0.1'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 56
    Top = 32
  end
  object conDb: TADOConnection
    Left = 104
    Top = 32
  end
end
