/// Модуль для осуществления аффинных преобразований над точками в трёхмерном пространстве
unit TTTransforms;

interface

uses
      TyTyTypes;


   
/// Ф-ии аффинных преобразований над кристаллом
function Rotation(p:D3Figure;phi:angle;xyz:axis;n:integer): D3Figure;	// Вращение
function Dilatation(p:D3Figure;a,b,y:real;n:integer): D3Figure;			// Растяжение
function Reflection(p:D3Figure;xyz:axis;n:integer): D3Figure;			// Отражение
function Translation(p:D3Figure;l,m,v:real;n:integer): D3Figure;		// Перенос


/// Преобразование
function transform(p:D3Figure;Rr:matrix4;n:integer): D3Figure;

// Каждая из этих функций возвращает преобразованный кристалл

implementation // Реализация всего


/// Вращение
function Rotation(p:D3Figure   // Вращаемый кристалл
                  ;phi:angle  // Угол вращения
                  ;xyz:axis   // Ось вращения
                  ;n:integer       // Число вершин кристалла
                  ): D3Figure;
var
   Rx,Ry,Rz:matrix4; // Матрицы вращения вокруг осей x,y,z
begin
   // Инициализация матриц вращения
   {
   Rx := ((1,          0,          0,   0),
          (0,   cos(phi),   sin(phi),   0),
          (0,  -sin(phi),   cos(phi),   0),
          (0,          0,          0,   1));
   }
   phi := phi*pi/180;
   
   Rx[1,1] := 1;  Rx[1,2] := 0;           Rx[1,3] := 0;        Rx[1,4] := 0;
   Rx[2,1] := 0;  Rx[2,2] := cos(phi);    Rx[2,3] := sin(phi); Rx[2,4] := 0;
   Rx[3,1] := 0;  Rx[3,2] := -sin(phi);   Rx[3,3] := cos(phi); Rx[3,4] := 0;
   Rx[4,1] := 0;  Rx[4,2] := 0;           Rx[4,3] := 0;        Rx[4,4] := 1;
   
   Ry[1,1] := cos(phi); Ry[1,2] := 0;  Ry[1,3] := -sin(phi);   Ry[1,4] := 0;
   Ry[2,1] := 0;        Ry[2,2] := 1;  Ry[2,3] := 0;           Ry[2,4] := 0;
   Ry[3,1] := sin(phi); Ry[3,2] := 0;  Ry[3,3] := cos(phi);    Ry[3,4] := 0;
   Ry[4,1] := 0;        Ry[4,2] := 0;  Ry[4,3] := 0;           Ry[4,4] := 1;
   
   Rz[1,1] := cos(phi);    Rz[1,2] := sin(phi);   Rz[1,3] := 0;   Rz[1,4] := 0;
   Rz[2,1] := -sin(phi);   Rz[2,2] := cos(phi);   Rz[2,3] := 0;   Rz[2,4] := 0;
   Rz[3,1] := 0;           Rz[3,2] := 0;          Rz[3,3] := 1;   Rz[3,4] := 0;
   Rz[4,1] := 0;           Rz[4,2] := 0;          Rz[4,3] := 0;   Rz[4,4] := 1;
   
   //Вращение вокруг выбранной оси
   if (xyz = 'x') then Result :=transform(p,Rx,n);
   if (xyz = 'y') then Result :=transform(p,Ry,n);
   if (xyz = 'z') then Result :=transform(p,Rz,n);
end;


/// Растяжение
function Dilatation(p:D3Figure		// Кристалл
                    ;a,b,y:real  // Коэффициенты рвстяжения вдоль осей x,y,z
                    ;n:integer       // Число вершин кристалла
                    ): D3Figure;
var
   D:matrix4;  // Матрица растяжения
begin
   // Инициализация матрицы растяжения
   {
   D := ((a,   0,   0,   0),
         (0,   b,   0,   0),
         (0,   0,   y,   0),
         (0,   0,   0,   1));
   }
   
   D[1,1] := a;   D[1,2] := 0;  D[1,3] := 0;  D[1,4] := 0;
   D[2,1] := 0;   D[2,2] := b;  D[2,3] := 0;  D[2,4] := 0;
   D[3,1] := 0;   D[3,2] := 0;  D[3,3] := y;  D[3,4] := 0;
   D[4,1] := 0;   D[4,2] := 0;  D[4,3] := 0;  D[4,4] := 1;

   
   // Растяжение
   Result :=transform(p,D,n);
end;


/// Отражение
function Reflection(p:D3Figure    // Кристалл, который отражают
                   ;xyz:axis    // Ось, которой нет в пл-ти, относительно которой отражают // Да, это сложно
                   ;n:integer       // Число вершин кристалла
                   ): D3Figure;
var
   Mx,My,Mz:matrix4; // Матрицы отражения относ. пл-тей
begin
   // Инициализация матриц отражения
   {
   Mx := ((-1,  0,   0,   0),
          (0,   1,   0,   0),
          (0,   0,   1,   0),
          (0,   0,   0,   1)); 
   }
   // Относ. пл-ти yOz
   Mx[1,1] := -1;   Mx[1,2] := 0;  Mx[1,3] := 0;  Mx[1,4] := 0;
   Mx[2,1] := 0;    Mx[2,2] := 1;  Mx[2,3] := 0;  Mx[2,4] := 0;
   Mx[3,1] := 0;    Mx[3,2] := 0;  Mx[3,3] := 1;  Mx[3,4] := 0;
   Mx[4,1] := 0;    Mx[4,2] := 0;  Mx[4,3] := 0;  Mx[4,4] := 1;
   
   // Относ. пл-ти zOx
   My[1,1] := 1;   My[1,2] := 0;   My[1,3] := 0;  My[1,4] := 0;
   My[2,1] := 0;   My[2,2] := -1;  My[2,3] := 0;  My[2,4] := 0;
   My[3,1] := 0;   My[3,2] := 0;   My[3,3] := 1;  My[3,4] := 0;
   My[4,1] := 0;   My[4,2] := 0;   My[4,3] := 0;  My[4,4] := 1;
   
   // Относ. пл-ти xOy
   Mz[1,1] := 1;   Mz[1,2] := 0;  Mz[1,3] := 0;   Mz[1,4] := 0;
   Mz[2,1] := 0;   Mz[2,2] := 1;  Mz[2,3] := 0;   Mz[2,4] := 0;
   Mz[3,1] := 0;   Mz[3,2] := 0;  Mz[3,3] := -1;  Mz[3,4] := 0;
   Mz[4,1] := 0;   Mz[4,2] := 0;  Mz[4,3] := 0;   Mz[4,4] := 1;
             
   //Вращение вокруг выбранной оси
   if (xyz = 'x') then Result :=transform(p,Mx,n);
   if (xyz = 'y') then Result :=transform(p,My,n);
   if (xyz = 'z') then Result :=transform(p,Mz,n);
end;


/// Перенос
function Translation(p:D3Figure      // Переносимый кристалл
                    ;l,m,v:real    // Вектора переноса
                    ;n:integer       // Число вершин кристалла
                    ): D3Figure;
var
   T:matrix4;
begin
   // Инициализация матрицы переноса
   {
   T := ((1,   0,   0,   0),
         (0,   1,   0,   0),
         (0,   0,   1,   0),
         (l,   m,   v,   1));
   }
   
   T[1,1] := 1;   T[1,2] := 0;  T[1,3] := 0;  T[1,4] := 0;
   T[2,1] := 0;   T[2,2] := 1;  T[2,3] := 0;  T[2,4] := 0;
   T[3,1] := 0;   T[3,2] := 0;  T[3,3] := 1;  T[3,4] := 0;
   T[4,1] := l;   T[4,2] := m;  T[4,3] := v;  T[4,4] := 1;
   
   // Перенос точки
   Result :=transform(p,T,n);
end;


/// Преобразование
function transform(p:D3Figure    // Кристалл, который преобразовывают
                  ;Rr:matrix4    // Матрица преобразования
                  ;n:integer     // Число вершин кристалла
                  ): D3Figure;
var
   p_r:D3Figure_real;    // Кристалл-результат real
   k:integer;      // Переменные циклов
begin
   p_r := new D3Point_real[n];
   for k:=0 to n-1 do
   begin
      //p_r[k].x := p[k].x;  p_r[k].y := p[k].y;  p_r[k].z := p[k].z;
      p_r[k].x := 0;  p_r[k].y := 0;  p_r[k].z := 0;
      // Перемножение матриц при детальном рассмотрении сего процесса
      p_r[k].x := p_r[k].x + p[k].x*Rr[1,1] + p[k].y*Rr[2,1] + p[k].z*Rr[3,1] + Rr[4,1];
      p_r[k].y := p_r[k].y + p[k].x*Rr[1,2] + p[k].y*Rr[2,2] + p[k].z*Rr[3,2] + Rr[4,2];
      p_r[k].z := p_r[k].z + p[k].x*Rr[1,3] + p[k].y*Rr[2,3] + p[k].z*Rr[3,3] + Rr[4,3];
      
      // Округление полученного результата
      p[k].x := Round(p_r[k].x);
      p[k].y := Round(p_r[k].y);
      p[k].z := Round(p_r[k].z);
   end;
   Result := p;
end;


//initialization
end.