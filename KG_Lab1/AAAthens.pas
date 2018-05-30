/// ������ � ���������� ��� ������ ������������� �������� ��������������
unit AAAthens;


interface


uses TyTyTypes,
     PaPaPaint,      // ��� ��������� ���������
     TTTransforms;   // ��� ������������� ��������������
     
      
// ��������� ������ �������� ��������������
function Athens(n:integer;
                 figure:D3Figure;
                 Msm:array [,] of shortint):boolean;


implementation


/// ��������� ������ �������� ��������������
function Athens(
                 n:integer				// ����� ������ ���������
                ;figure:D3Figure		// ��������
                ;Msm:array [,] of shortint // ������� ���������
                ):boolean;				// ���������� ���� ������ ����� ����������
var
   arbeiten: boolean := true; // ���� ������ ���������
   action: Char;  // �����, ������������ ��������������
   phi: angle;    // ���� ��������
   xyz: axis;     // ��� ��������
   a,b,y: real;   // ������������ ����������/������
   l,m,v: real;   // ������� ��������
begin
   // ����� ������� ���������
   SetCoordSystem;
   // ���������� ��������� ����� ������������� ���������� ��������������
   while (arbeiten) do
   begin
      ClearWindow;   // ����� ���������� �� �������
      PrintFigMsm(n,figure,Msm);  // ������ ��������� �� ��������������
      SetTextPosition;  // ��������� ������� ������ �� ������
      WriteText('����� �������� ������ ���������?');
      WriteText('R - �������� (Rotation)');
      WriteText('D - ���������� (Dilatation)');
      WriteText('M - ��������� (Reflection)');
      WriteText('T - ������� (Translation)');
      WriteText('C - ������� ������ �������� (Choose)');
      WriteText('E - ����� (Exit)');
      WriteText('>> ');
      readln(action);
      // ��������� ������ ��������
      case action of
         'R': begin  // ��������
               WriteText('������� ��� ��������(x,y,z)');
               WriteText('>> ');
               readln(xyz);
               WriteText('������� ���� �������� � ��������� [-180..180]');
               WriteText('>> ');
               readln(phi);
               figure := Rotation(figure,phi,xyz,n);
            end;
         'D': begin  // ����������
               WriteText('������� 3 ������������ ����������/������');
               WriteText('����� ���� x,y,z');
               WriteText('>> ');
               readln(a,b,y);
               figure := Dilatation(figure,a,b,y,n);
            end;
         'M': begin  // ���������
               WriteText('������� ��� ��� ��-�� ���������(x,y,z)');
               WriteText('>> ');
               readln(xyz);
               figure := Reflection(figure,xyz,n);
            end;
         'T': begin  // �������
               WriteText('������� ����� 3-� �������� ��������');
               WriteText('�� ���� x,y,z');
               WriteText('>> ');
               readln(l,m,v);
               figure := Translation(figure,l,m,v,n);
            end;
         'C': begin
               break;   // arbeiten = true
            end;
         'E': begin  // �����
               arbeiten := false;   // ������ ��������� �����������
               CloseWindow;         // ���� �����������
            end;
         else begin
            end;
      end; //case
   end; //while
   Result := arbeiten;
end;


end.