uses  
      TyTyTypes,
      FFFiles,    // Для выбора файла с кристаллом
      AAAthens;   // Для работы с кристаллом
      
   
var
   used_f: text;     // Переменная для файла исходных данных
   figure: D3Figure; // Кристалл
   n: integer;       // Число вершин кристалла
   i,j:integer;      // Переменные цикла
   Msm:array [,] of shortint; // Матрица смежности вершин кристалла
   arbeiten: boolean := true; // Флаг работы программы
   
      
begin
   while (arbeiten) do
   begin
      // Работа с файлом данных о фигуре
      AssignFile(used_f, CrystalChoose());
      Reset(used_f);
      readln(used_f,n);      // Чтение числа вершин
      
      // Инициализация кристалла
      figure := new D3Point[n];

      // Чтение координат вешин
      for i:= 0 to n-1 do
      begin
         readln(used_f, figure[i].x, figure[i].y, figure[i].z);
      end;

      // Чтение матрицы смежности вершин кристалла
      Msm := new shortint[n,n];
      for i := 1 to n-1 do
         for j := 0 to i-1 do
         begin
            read(used_f,Msm[i,j]);
         end;

      used_f.Close;
      
      // Работа с кристаллом
      arbeiten := Athens(n, figure, Msm);
      // если arbeiten = true, то работа программы
      // повторится с выбора файла с кристаллом
      
   end;  //while
end.