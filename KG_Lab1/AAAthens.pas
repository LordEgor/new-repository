/// Модуль с интерфейом для выбора пользователем аффинных преобразований
unit AAAthens;


interface


uses TyTyTypes,
     PaPaPaint,      // Для рисования кристалла
     TTTransforms;   // Для осуществления преобразований
     
      
// Интерфейс выбора аффинных преобразований
function Athens(n:integer;
                 figure:D3Figure;
                 Msm:array [,] of shortint):boolean;


implementation


/// Интерфейс выбора аффинных преобразований
function Athens(
                 n:integer				// Число вершин кристалла
                ;figure:D3Figure		// Кристалл
                ;Msm:array [,] of shortint // Матрица смежности
                ):boolean;				// Возвращает флаг работы всего приложения
var
   arbeiten: boolean := true; // Флаг работы процедуры
   action: Char;  // Буква, обозначающая преобразование
   phi: angle;    // Угол вращения
   xyz: axis;     // Ось вращения
   a,b,y: real;   // Коэффиуиенты растящения/сжатия
   l,m,v: real;   // Вектора переноса
begin
   // Задаём систему координат
   SetCoordSystem;
   // Повторение алгоритма после осуществления очередного преобразования
   while (arbeiten) do
   begin
      ClearWindow;   // Перед рисованием всё очистим
      PrintFigMsm(n,figure,Msm);  // Печать кристалла до преобразований
      SetTextPosition;  // Начальная позиция текста на экране
      WriteText('Какое действие хотите совершить?');
      WriteText('R - Вращение (Rotation)');
      WriteText('D - Растяжение (Dilatation)');
      WriteText('M - Отражение (Reflection)');
      WriteText('T - Перенос (Translation)');
      WriteText('C - Выбрать другой кристалл (Choose)');
      WriteText('E - Выход (Exit)');
      WriteText('>> ');
      readln(action);
      // Обработка выбора действия
      case action of
         'R': begin  // Вращение
               WriteText('Введите ось вращения(x,y,z)');
               WriteText('>> ');
               readln(xyz);
               WriteText('Введите угол поворота в диапазоне [-180..180]');
               WriteText('>> ');
               readln(phi);
               figure := Rotation(figure,phi,xyz,n);
            end;
         'D': begin  // Растяжение
               WriteText('Введите 3 коэффициента растяжения/сжатия');
               WriteText('вдоль осей x,y,z');
               WriteText('>> ');
               readln(a,b,y);
               figure := Dilatation(figure,a,b,y,n);
            end;
         'M': begin  // Отражение
               WriteText('Введите ось вне пл-ти отражения(x,y,z)');
               WriteText('>> ');
               readln(xyz);
               figure := Reflection(figure,xyz,n);
            end;
         'T': begin  // Перенос
               WriteText('Введите длины 3-х векторов переноса');
               WriteText('по осям x,y,z');
               WriteText('>> ');
               readln(l,m,v);
               figure := Translation(figure,l,m,v,n);
            end;
         'C': begin
               break;   // arbeiten = true
            end;
         'E': begin  // Выход
               arbeiten := false;   // Работа программы прекратится
               CloseWindow;         // Окно закрывается
            end;
         else begin
            end;
      end; //case
   end; //while
   Result := arbeiten;
end;


end.