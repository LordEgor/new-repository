/// Модуль для работы со всеми существующими файлами с данными о кристаллах
unit FFFiles;

interface


uses
      TyTyTypes;

      
const
   /// Число доступных кристаллов
   N_CR = 5;
      
      
var
   /// Массив всех файлов с кристаллами
   cr_files: array [1..N_CR] of string;
   
   
/// Выбор файла с кристаллом
function CrystalChoose():string;


implementation


/// Выбор файла с кристаллом
function CrystalChoose():string; // Возвращает имя файла с кристаллом
var
   i:shortint;    // Переменная цикла
   n:shortint;    // Номер выбранного файла
begin
   // Файлы с данными о кристаллах
   cr_files[1] := 'cube.txt';
   cr_files[2] := 'crystal.txt';
   cr_files[3] := 'gypse.txt';
   cr_files[4] := 'house.txt';
   cr_files[5] := 'crystal_Liz.txt';
   
   // Выбор файла с кристаллом
   //SetTextPosition;
   writeln('С каким кристаллом вы хотите поиграться?');
   for i:=1 to N_CR do
      writeln(i + ' - ' + cr_files[i]);
   writeln('>> ');
   readln(n);
   Result := cr_files[n];
end;
   
end.