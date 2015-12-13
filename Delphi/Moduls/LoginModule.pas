unit LoginModule;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TModule_Login = class(TDataModule)
    qryDSCSYS: TADOQuery;
  private
    { Private declarations }
    
    function EnUser(s:String):string;
    function Decode7(EnStr,s:string):string ;
    function Encode7(EnStr,s:string):string ;
  public
    { Public declarations }
     function checkLogin(UserName:String;PassWord:String):Boolean;

  end;

var
  Module_Login: TModule_Login;

  const
  FNIL  = '''(&.&!''%&$"''&)" ",&)$(%#$-$#$$" ' ;
  PS1 = '&''$%"# !./,-*+()' ; 
  FF1 = ' !"#$%&''()*+,-./';

implementation

uses Common_Module;

{$R *.dfm}

{ TModule_Login }

function TModule_Login.checkLogin(UserName, PassWord: String): Boolean;
var
  decode_passWord:String;
begin
  Result := False;
  qryDSCSYS.Close;
  qryDSCSYS.SQL.Text := 'Select * from DSCMA Where MA001 ='''
                              + UserName + '''';
  qryDSCSYS.Open;
  if qryDSCSYS.RecordCount <> 1 then
    Exit;


  decode_passWord := Decode7(EnUser(UserName),
                    qryDSCSYS.FieldByName('MA003').AsString);
  if PassWord <> decode_passWord then
    Exit;

  Result := True;

end;

function TModule_Login.Decode7(EnStr, s: string): string;
var KeyLen,i,n1,n2:integer;
    FStr1,FStr3,FStr4:Char ;
begin
  Result := '' ;
  IF EnStr='' then Exit ;
  if Length(s)<32 then
  begin
    Result := 'ERROR!' ;
  END ;
  IF s=EnStr then
    EXIT ;
  KeyLen:=0 ;
  for i:=28 downto 1 do 
    if s[i]<>EnStr[i] then
    begin
      KeyLen:=i ;
      Break ;
    end;
  if KeyLen=0 then Exit ;
  for i:=KeyLen Downto 1 do
  begin
    case i of
    1..4: begin
            FStr1 := EnStr[i] ;

            FStr3 := s[i] ;
            FStr4 := s[32-4+i] ;
            n1 := Ord(FStr1) xor Ord(FStr3) ;
            n2 := ((Ord(FStr4)-32) div 16) ;
            Result := Chr((16*n2)+32+n1) + Result;
            FStr4 := Chr((Ord(FStr4) Mod 16)+32) ;
            s := COPY(s,1,32-4+i-1)+FStr4+COPY(s,32-4+i+1,4-i) ;
          end;
    else begin
            FStr1 := EnStr[i] ;
            FStr3 := s[i] ;
            FStr4 := s[i-4] ;
            n1 := Ord(FStr1) xor Ord(FStr3) ;
            n2 := ((Ord(FStr4)-32) div 16) ;
            Result := Chr((16*n2)+32+n1) + Result ;
            FStr4 := Chr((Ord(FStr4) Mod 16)+32) ;
            s := COPY(s,1,i-4-1) + FStr4 + COPY(s, i-4+1, 32-i+4) ;
         end
    end;
  end;

end;

function TModule_Login.Encode7(EnStr, s: string): string;
var i,n2:integer;
    FStr1,FStr2,FStr3:Char ;
    Fchar1:Char;
begin
  Result := EnStr ;
  IF Length(s)=0 then Exit ;
  For i:=1 to Length(s) do
  begin
    case i of
    1..4: begin
            FStr1 := s[i] ;
            FStr2 := Result[i] ;
            FStr3 := Result[32-4+i] ;

            n2 := ((Ord(s[i])-32) div 16) ;
            Fchar1 := Chr(n2*16+32) ;
            n2 := Ord(FStr2) xor Ord(FStr1) ;
            n2 := (n2 AND $0F) + $20 ;
            FStr2 := Chr(n2) ;

            FStr3 := Chr(Ord(Fchar1) + ((Ord(FStr3)+Ord(Fchar1)) Mod 16)) ;

            Result := COPY(Result,1,i-1)+FStr2+COPY(Result,i+1,32-i) ;
            Result := COPY(Result,1,32-4+i-1)+FStr3+COPY(Result,32-4+i+1,4-i) ;
          end;
    else begin
            FStr1 := s[i] ;
            FStr2 := Result[i] ;
            FStr3 := Result[i-4] ;

            n2 := ((Ord(s[i])-32) div 16) ;
            Fchar1 := Chr(n2*16+32) ; 
            n2 := Ord(FStr2) xor Ord(FStr1) ;
            n2 := (n2 AND $0F) + $20 ;
            FStr2 := Chr(n2) ;
            FStr3 := Chr(Ord(Fchar1) + ((Ord(FStr3)+Ord(Fchar1)) Mod 16)) ;
            Result := COPY(Result,1,i-1)+FStr2+COPY(Result,i+1,32-i) ;
            Result := COPY(Result,1,i-4-1)+FStr3+COPY(Result, i-4+1, 32-i+4) ;
         end;
    end;
  end;

end;

function TModule_Login.EnUser(s: String): string;
var
  n,i,d:integer;
begin
  Result := '' ;
  i := length(s) ;
  if i<=0 then exit ;
  Result := Copy(FNIL,(i-1)*2+1, 30-((i-1)*2)) ;
  for n:=i Downto 1 do
  begin
    i := ((Ord(s[n])-32) Mod 16) ;
    d := ((Ord(s[n])-32) div 16)+1 ;
    Result := Result + CHR(32+d+1) + FF1[i+1] ;
  end;

end;



end.
