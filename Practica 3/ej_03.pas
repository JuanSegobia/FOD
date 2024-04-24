{ Realizar un programa que genere un archivo de novelas filmadas durante el presente año. De cada novela se registra:
 código, género, nombre, duración, director y precio.
El programa debe presentar un menú con las siguientes opciones:

a. Crear el archivo y cargarlo a partir de datos ingresados por teclado. Se utiliza la técnica de lista invertida para recuperar 
    espacio libre en el archivo. Para ello, durante la creación del archivo, en el primer registro del mismo se debe almacenar la cabecera 
    de la lista. Es decir un registro ficticio, inicializando con el valor cero (0) el campo correspondiente al
    código de novela, el cual indica que no hay espacio libre dentro del archivo.

b. Abrir el archivo existente y permitir su mantenimiento teniendo en cuenta el inciso a., se utiliza lista invertida para 
    ecuperación de espacio. En particular, para el campo de ´enlace´ de la lista, se debe especificar los números de registro referenciados
    con signo negativo, (utilice el código de novela como enlace).Una vez abierto el archivo, brindar operaciones para:
    
    i. Dar de alta una novela leyendo la información desde teclado. Para esta operación, en caso de ser posible, deberá recuperarse el
    espacio libre. Es decir, si en el campo correspondiente al código de novela del registro cabecera hay un valor negativo, por ejemplo -5,
    se debe leer el registro en la posición 5, copiarlo en la posición 0 (actualizar la lista de espacio libre) y grabar el nuevo registro en la
    posición 5. Con el valor 0 (cero) en el registro cabecera se indica que no hay espacio libre.
    
    ii. Modificar los datos de una novela leyendo la información desde teclado. El código de novela no puede ser modificado.
    
    iii. Eliminar una novela cuyo código es ingresado por teclado. Por ejemplo, si se da de baja un registro en la posición 8, en el campo
código de novela del registro cabecera deberá figurar -8, y en el registro en la posición 8 debe copiarse el antiguo registro cabecera.
c. Listar en un archivo de texto todas las novelas, incluyendo las borradas, que representan la lista de espacio libre.
    El archivo debe llamarse “novelas.txt”.
}
program ej_03;
type 
    str10 = String[10];
    novela = record
        codigo: Integer;
        genero: str10;
        nombre: str10;
        duracion: Integer;
        director: str10;
        precio: Real;
    end;

    maestro = file of novela;
{ ------------------------------------------------------ }
procedure leerRegistro (var n: novela);
begin
    ReadLn (n.codigo);
    ReadLn (n.genero);
    ReadLn (n.nombre);
    ReadLn (n.duracion);
    ReadLn (n.director);
    ReadLn (n.precio);
end;
{ ------------------------------------------------------ }
procedure cargarMaestro(var mae: maestro);
var 
    n: novela;
begin 
    rewrite(mae);
    n.codigo:=  0;
    Write (mae, n);
    leerRegistro(n);
    while (n.codigo <> -1 ) do begin
      write (mae, n);
      leerRegistro(n);
    end;
end;
{ ------------------------------------------------------ }
{ pregunta: las posiciones en negativo las voy a guardar en el campo de codigo? Esta bien eso? }
procedure alta (var mae: maestro; nNueva: novela);
var
    nDeArchivo: novela;
    posABorrar: integer;
begin 
    read (mae, nDeArchivo);
    if (nDeArchivo.codigo = 0) then 
        writeln ('No hay espacio para agregar la novela')
    else begin
        posABorrar:= nDeArchivo.codigo * -1 ;
        read (mae, nDeArchivo);
        seek(mae, filePos (mae) posABorrar;
    end;
end;

var 
    aMae: maestro;
    menu: integer;
    n: novela;
begin 
    assign (maestro, 'Archivo Maestro');
    cargarMaestro (maestro);
    writeln ('1 para dar de alta una novela: ');
    
    writeln ('Ingrese una opcion: ');
    readln (menu);
    case menu of 
        1: begin
            leerRegistro(n);
            alta(mae,n);
        end;
end.