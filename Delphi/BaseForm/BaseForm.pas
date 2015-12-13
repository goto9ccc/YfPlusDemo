unit BaseForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TFormBase = class(TForm)
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormBase: TFormBase;

implementation

{$R *.dfm}

procedure TFormBase.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if   Key=VK_ESCAPE   then
    Close;
end;

end.
