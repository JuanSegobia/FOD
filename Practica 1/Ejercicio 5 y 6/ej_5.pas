{ 5. Realizar un programa para una tienda de celulares, que presente un menú con opciones para:
a. Crear un archivo de registros no ordenados de celulares y cargarlo con datos ingresados desde un archivo de texto denominado “celulares.txt”. 
    Los registros correspondientes a los celulares deben contener: código de celular, nombre,
    descripción, marca, precio, stock mínimo y stock disponible.

b. Listar en pantalla los datos de aquellos celulares que tengan un stock menor al stock mínimo.

c. Listar en pantalla los celulares del archivo cuya descripción contenga una
    cadena de caracteres proporcionada por el usuario.

d. Exportar el archivo creado en el inciso a) a un archivo de texto denominado
    “celulares.txt” con todos los celulares del mismo. El archivo de texto generado
    podría ser utilizado en un futuro como archivo de carga (ver inciso a), por lo que
    debería respetar el formato dado para este tipo de archivos en la NOTA 2.}    

program ej_5;
type
    str10 = string[10];

    celular = record    
        cod: integer;
        nombre: str10;
        desc: str10;
        marca: str10;
        precio: real;
        stockMinimo: integer;
        stockDisponible: integer;
    end;

    archivoCelulares = file of celular;

{ ----------------------------   Procedimientos   ---------------------------- }
procedure importarDatos(var carga: Text; var arch: archivoCelulares);
var
    c: celular;
    nombreArchivo: str10;
begin
    writeln ('Ingrese el nombre del archivo');
    readln (nombreArchivo);
    Assign (arch, nombreArchivo);
    Reset (carga);
    Rewrite (arch);
    while (not eof (carga)) do
    begin
        readln (carga, c.cod,c.precio,c.marca);
        readln (carga, c.stockDisponible, c.stockMinimo, c.desc);
        readln (carga, c.nombre);
        write (arch,c);
    end;
    writeln ('Archivo cargado correctamente.');
    Close (arch);
    Close (carga);
end;

procedure listadoCelularesSinStock (var arch: archivoCelulares);
var
    c: celular;
begin
    reset (arch);
    while (not eof (arch)) do 
    begin
        read (arch, c);
        if (c.stockDisponible < c.stockMinimo) then
            writeln ('El celular de codigo ', c.cod, ' posee un stock menor al minimo deseado');
    end;
    close (arch);
end;

procedure listadoCelularesConDescripcion (var arch: archivoCelulares);
var
    c: celular;
begin
    reset (arch);
    while (not eof (arch)) do 
    begin 
        read (arch, c);
        if (c.desc <> '') then
          writeln ('La descripcion del celular con codigo: ', c.cod, '. Tiene la siguiente descripcion: ' ,c.desc);
    end;
    close (arch);
end;

procedure exportarDatos (var arch: archivoCelulares; var exp: Text);
var
    c: celular;
begin
    reset (arch);
    Rewrite (exp);
    while (not eof (arch)) do 
    begin
        read (arch, c);
        readln (carga, c.cod,' ',c.precio,' ',c.marca);
        readln (carga, c.stockDisponible,' ',c.stockMinimo,' ',c.desc);
        readln (carga, c.nombre);
    end;
    Close (arch);
    Close (exp);
end;

{ ---------------------------- Programa Principal ---------------------------- }
var
    carga: Text;
    arch: archivoCelulares;
    export: Text;
begin
    Assign (carga, 'celulares.txt');
    { Inciso A }
    importarDatosDatos (carga, arch);
    { Inciso B }
    listadoCelularesSinStock (arch);
    { Inciso C }
    listadoCelularesConDescripcion(arch);
    { Inciso D }
    Assign (export, 'celulares.txt');
    exportarDatos (arch, export);
    { Inciso 6.A }
    
end.