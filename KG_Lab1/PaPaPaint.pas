/// Модуль для работы с окном GraphABC и рисования на нём 3D-кристаллов
unit PaPaPaint;

interface

uses  TyTyTypes,
      GraphABC;

const 
   cl = clBlack;  // Цвет кристалла

   
var
    /// Координаты текста на графическом окне
    textY: integer := textY_begin;
    textX: integer := textX_begin;
	
	
// Рисует 3D-линию между точками p1 и p2 в 2D-пространстве
procedure PrintLine(p1,p2:D3Point);
   
// Задаёт начальную позицию системы координат
procedure SetCoordSystem;
   
// Рисует систему координат (оси, их пересечение в начальной точке)
procedure DrawCoordSystem;


// Рисует кристалл и СК по матрице смежности его вершин
procedure PrintFigMsm(n:integer;
                     figure:D3Figure;
                     Msm:array [,] of shortint);

					 
// Очищает графическое окно
procedure ClearWindow;

// Закрывает графическое окно
procedure CloseWindow;

   
// Процедуры печати информации на экран

// Печать строки с текстом s на экран
procedure WriteText(s:string);

// Начальная позиция на экране, с которой печатается текст
procedure SetTextPosition;

   
implementation
   

/// Рисует 3D-линию между точками p1 и p2 в 2D-пространстве
procedure PrintLine(p1,p2:D3Point);
var
   x1,y1,x2,y2:integer;
begin
   x1 := Round(p1.x - p1.z*0.7);
   y1 := Round(p1.y - p1.z*0.3);
   x2 := Round(p2.x - p2.z*0.7);
   y2 := Round(p2.y - p2.z*0.3);
   Line(x1,-y1,x2,-y2,cl); 
end;
   
   
/// Задаёт начальную позицию системы координат  
procedure SetCoordSystem; 
begin
   SetGraphABCIO;
   // Начало СК в центре окна в полноэкранном режиме
   Window.Maximize;
   Coordinate.Origin := Window.Center;
end;

   
/// Рисует систему координат (оси, их пересечение в начальной точке)
procedure DrawCoordSystem;   
begin
   // Рисуем СК
   Line(0,0,100,0,clRed);      //x
   Line(0,0,0,-100,clGreen);   //y
   Line(0,0,-70,30,clBlue);    //z
end;


/// Рисует кристалл и СК по матрице смежности его вершин
procedure PrintFigMsm(n:integer           // Число вершин кристалла
                     ;figure:D3Figure     // Рисуемый кристалл
                     ;Msm:array [,] of shortint);  // Матрица смежности
var
   i,j:integer;   // Переменные циклов
begin
   // Система координат
   DrawCoordSystem;
   // Кристалл
   for i := 1 to n-1 do
      for j := 0 to i-1 do
         if (Msm[i,j] = 1) then
         begin
            PrintLine(figure[i],figure[j]);
         end;
end;


/// Очищает графическое окно
procedure ClearWindow; 
begin
   Window.Clear;
end;


/// Закрывает графическое окно
procedure CloseWindow; 
begin
   Window.Close;
end;


/// Печать строки с текстом s на экран
procedure WriteText(s:string); 
begin
   // Начальная позиция текста
   TextOut(textX,textY,s);
   inc(textY,textInterval);
end;


/// Начальная позиция на экране, с которой печатается текст
procedure SetTextPosition; 
begin
   textY := textY_begin;
end;

   
end.