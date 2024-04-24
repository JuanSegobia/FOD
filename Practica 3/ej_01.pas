{ Modificar el ejercicio 4 de la práctica 1 (programa de gestión de empleados), agregándole una opción para realizar bajas 
copiando el último registro del archivo en la posición del registro a borrar y luego truncando el archivo en la posición del último
registro de forma tal de evitar duplicados. }
program ej_01;
Type
    rangoEdad = 1..99;
    rangoDni = 10000000..99999999;
    empleado = record 
        apellido: string [15];
        nombre: string [15];
        numEmpleado: integer;
        edad: rangoEdad;
        dni: rangoDni;
  end;

    archivoEmpleados = file of empleado;

    procedure bajaFisica(var archivo: archivoEmpleados; num: integer);
    var 
        r: empleado;
        pos: integer;   
    begin
        pos:= 0;
        reset (archivo);
        seek (archivo, filesize(archivo)-1);
        read (archivo, r);
        seek (archivo, pos);
        while (not eof(archivo)) and (r.numEmpleado <> num) do
        begin
            pos:= pos + 1;
            read (archivo, r);
        end;
        if r.numEmpleado = num then
        begin
            seek(archivo, pos - 1);
            write(archivo, r);
            seek(archivo, filesize(archivo)-1);
            Truncate(archivo);
        end
        else 
            writeln('No se encontro el empleado');
    end;
