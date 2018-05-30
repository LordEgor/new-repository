/// ������ ��� ������ � ����� GraphABC � ��������� �� �� 3D-����������
unit PaPaPaint;

interface

uses  TyTyTypes,
      GraphABC;

const 
   cl = clBlack;  // ���� ���������

   
var
    /// ���������� ������ �� ����������� ����
    textY: integer := textY_begin;
    textX: integer := textX_begin;
	
	
// ������ 3D-����� ����� ������� p1 � p2 � 2D-������������
procedure PrintLine(p1,p2:D3Point);
   
// ����� ��������� ������� ������� ���������
procedure SetCoordSystem;
   
// ������ ������� ��������� (���, �� ����������� � ��������� �����)
procedure DrawCoordSystem;


// ������ �������� � �� �� ������� ��������� ��� ������
procedure PrintFigMsm(n:integer;
                     figure:D3Figure;
                     Msm:array [,] of shortint);

					 
// ������� ����������� ����
procedure ClearWindow;

// ��������� ����������� ����
procedure CloseWindow;

   
// ��������� ������ ���������� �� �����

// ������ ������ � ������� s �� �����
procedure WriteText(s:string);

// ��������� ������� �� ������, � ������� ���������� �����
procedure SetTextPosition;

   
implementation
   

/// ������ 3D-����� ����� ������� p1 � p2 � 2D-������������
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
   
   
/// ����� ��������� ������� ������� ���������  
procedure SetCoordSystem; 
begin
   SetGraphABCIO;
   // ������ �� � ������ ���� � ������������� ������
   Window.Maximize;
   Coordinate.Origin := Window.Center;
end;

   
/// ������ ������� ��������� (���, �� ����������� � ��������� �����)
procedure DrawCoordSystem;   
begin
   // ������ ��
   Line(0,0,100,0,clRed);      //x
   Line(0,0,0,-100,clGreen);   //y
   Line(0,0,-70,30,clBlue);    //z
end;


/// ������ �������� � �� �� ������� ��������� ��� ������
procedure PrintFigMsm(n:integer           // ����� ������ ���������
                     ;figure:D3Figure     // �������� ��������
                     ;Msm:array [,] of shortint);  // ������� ���������
var
   i,j:integer;   // ���������� ������
begin
   // ������� ���������
   DrawCoordSystem;
   // ��������
   for i := 1 to n-1 do
      for j := 0 to i-1 do
         if (Msm[i,j] = 1) then
         begin
            PrintLine(figure[i],figure[j]);
         end;
end;


/// ������� ����������� ����
procedure ClearWindow; 
begin
   Window.Clear;
end;


/// ��������� ����������� ����
procedure CloseWindow; 
begin
   Window.Close;
end;


/// ������ ������ � ������� s �� �����
procedure WriteText(s:string); 
begin
   // ��������� ������� ������
   TextOut(textX,textY,s);
   inc(textY,textInterval);
end;


/// ��������� ������� �� ������, � ������� ���������� �����
procedure SetTextPosition; 
begin
   textY := textY_begin;
end;

   
end.