unit Frm_Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin,BaseForm;

type
  TFormMain = class(TFormBase)
    statInfo: TStatusBar;
    clbr1: TCoolBar;
    tlb1: TToolBar;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

end.
