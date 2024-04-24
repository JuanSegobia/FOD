program ej_7;
type

    novela = record
        cod: integer;
        nombre: string[10];
        genero: string[10];
        precio: real;
    end;

    archivoNovelas = file of novela;
{ ----------------------------- Procedimientos ----------------------------- }
procedure cargaNovelas (var carga: Text; var arch: archivoNovelas);
var 
    n: novela;
    nombreArchivo: string[10];
begin
    writeln ('Ingrese el nombre del archivo');
    readln (nombreArchivo);
    Assign (arch, nombreArchivo);
    Reset (carga);
    Rewrite (arch);
    while (not eof (carga)) do
    begin
        readln (carga, n.cod, n.precio, n.genero);
        readln (carga, n.nombre);
        write (arch,n);
    end;
    writeln ('Archivo cargado correctamente.');
    Close (arch);
    Close (carga);
end;
{ -------------------------------------------------------------------------- } 
procedure leerNovela (var n: novela);
begin
    writeln ('Ingrese el nombre de la novela: ');
    readln (n.nombre);
    writeln ('Ingrese el codigo de la novela: ');
    readln (n.cod);
    writeln ('Ingrese el precio de la novela: ');
    readln (n.precio);
    writeln ('Ingrese el genero de la novela: ');
    readln (n.genero);
end;    

{ -------------------------------------------------------------------------- } 
procedure agregarNovela (var arch: archivoNovelas);
var
    n: novela;
begin
    reset (arch);
    leerNovela (n);
    Seek (arch, FileSize(arch));
    Write (arch, n);
    close (arch);
end;
{ -------------------------------------------------------------------------- } 



{ --------------------------- Programa Principal --------------------------- } 
var
    carga: Text;
    arch: archivoNovelas;
begin
    Assign (carga, 'novelas.txt');
    { Inciso A }
    cargaNovelas (carga, arch);
    { Inciso B.1 }
    agregarNovela (arch);

end.