program ej_1_2;
type
  archivo = file of integer;

procedure cargarArchivo (var a: archivo);
var
  num: integer;
begin
  Rewrite (a);
  WriteLn('Ingrese un numero');
  readln (num);
  while num <> 30000 do
    begin
      write (a, num);
      writeln ('Ingrese otro numero');
      ReadLn (num);
    end;
  Close(a);
end;

procedure recorrerArchivo (var a: archivo);
var 
  numMenores, num, sumaTotal, cantNumeros:integer;
begin
  numMenores:= 0; sumaTotal:= 0; cantNumeros:= 0;
  Reset (a);
  while not Eof(a) do
    begin
      cantNumeros:= cantNumeros +1;
      read (a, num);
      if num < 1500 then
        numMenores:= numMenores + 1;
      sumaTotal:= sumaTotal + num;
      write (num, ', ');
    end;
    Close(a);
    writeln ('La cantidad de numeros menores a 1500 es: ', numMenores);
    writeln ('El promedio es: ', sumaTotal/cantNumeros:2:2);
end;

var
  nombreDeArchivo: String[10];
  archivoLogico: archivo;
begin
  WriteLn('Ingrese el nombre del archivo');
  readln (nombreDeArchivo);
  assign (archivoLogico, nombreDeArchivo);
  cargarArchivo (archivoLogico);
  recorrerArchivo (archivoLogico);
end.