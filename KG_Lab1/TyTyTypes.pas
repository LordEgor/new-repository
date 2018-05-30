﻿/// Модуль типов и процедур, которые используются в данной программе во всех модулях
unit TyTyTypes;


interface


const 
   /// Начальные координаты текста и интервал между строками в пикселях
   textX_begin = -600;
   textY_begin = -450;
   textInterval = 20;
   
   // Координаты жёстко привязаны к размеру графического окна
   

type
   
   /// 3D-точка с целыми координатами
   D3Point = record
      x,y,z:integer;
   end;
   /// 3D-точка с вещественными координатами
   D3Point_real = record   
      x,y,z:real;
   end;
   /// Ось (Оx,Oy,Oz)
   axis = 'x'..'z';
   /// Угол
   angle = real;
   /// Матрица преобразований 4х4
   matrix4 = array [1..4,1..4] of real;
   
   /// 3D-фигура - массив точек
   D3Figure = array of D3Point;
   /// Массив точек с вещественными координатами для преобразований
   D3Figure_real = array of D3Point_real;
   
   
   // Вещественные координаты точек нужны для более точного подсчёта координат
   // Но в конечном итоге координаты округляются до целых
   // Потому что рисование происходит на графическом окне модуля GraphABC
   // Рисование - закрашивание пикселей, у которых целые координаты
   
   
implementation
   
end.