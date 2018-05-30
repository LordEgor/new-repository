/// ������ ��� ������ �� ����� ������������� ������� � ������� � ����������
unit FFFiles;

interface


uses
      TyTyTypes;

      
const
   /// ����� ��������� ����������
   N_CR = 5;
      
      
var
   /// ������ ���� ������ � �����������
   cr_files: array [1..N_CR] of string;
   
   
/// ����� ����� � ����������
function CrystalChoose():string;


implementation


/// ����� ����� � ����������
function CrystalChoose():string; // ���������� ��� ����� � ����������
var
   i:shortint;    // ���������� �����
   n:shortint;    // ����� ���������� �����
begin
   // ����� � ������� � ����������
   cr_files[1] := 'cube.txt';
   cr_files[2] := 'crystal.txt';
   cr_files[3] := 'gypse.txt';
   cr_files[4] := 'house.txt';
   cr_files[5] := 'crystal_Liz.txt';
   
   // ����� ����� � ����������
   //SetTextPosition;
   writeln('� ����� ���������� �� ������ ����������?');
   for i:=1 to N_CR do
      writeln(i + ' - ' + cr_files[i]);
   writeln('>> ');
   readln(n);
   Result := cr_files[n];
end;
   
end.