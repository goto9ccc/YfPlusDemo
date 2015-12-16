//����ά�뵥Ԫ���õĺ���

unit ReedSolomon;

interface

type

  TPloy = array of byte;

function Add(x, y : byte) : byte;
function Mul(x, y : byte) : byte;

function PloyMod(x, y : TPloy) : TPloy;

implementation

uses SysUtils;

function Add(x, y : byte) : byte;
begin
  Result := x xor y;
end;

function Mul(x, y : byte) : byte;
var
   i : integer;
   b : byte;
   wx, wy, r : longword;
begin
  wx := x;
  wy := y;
  r := 0;
  for i := 0 to 7 do
  begin
    b := wy mod 2;
    wy := wy shr 1;
    if b <> 0 then
    begin
      r := r xor wx;
    end;
    wx := wx shl 1;
  end;
  if r >= 32768 then r := r xor (301 * 128);
  if r >= 16384 then r := r xor (301 * 64);
  if r >= 8192  then r := r xor (301 * 32);
  if r >= 4096  then r := r xor (301 * 16);
  if r >= 2048  then r := r xor (301 * 8);
  if r >= 1024  then r := r xor (301 * 4);
  if r >= 512   then r := r xor (301 * 2);
  if r >= 256   then r := r xor (301);
  Result := r;
end;

function PloyMod(x, y : TPloy) : TPloy;
var
  i, j, k : integer;
  xx : byte;
begin
  if y[Length(y) - 1] <> 1 then
  begin
    raise Exception.Create('��ʽ��������һ����ʽ��');
  end;
  for i := High(x) downto High(y) do
  begin
    xx := x[i];
    if xx > 0 then
    begin
      for j := High(y) downto 0 do
      begin
        k := i - Length(y)+ 1 + j;
        x[k] := Add(x[k], Mul(y[j], xx));
      end;
    end;
  end;
  SetLength(Result, High(y));
  for i := 0 to High(y) - 1 do Result[i] := x[i];
end;

end.
 