{ Se dispone de un archivo con información de los alumnos de la Facultad de Informática. 
Por cada alumno se dispone de su código de alumno, apellido, nombre, 
cantidad de materias (cursadas) aprobadas sin final y cantidad de materias con final aprobado. 
Además, se tiene un archivo detalle con el código de alumno e información correspondiente a una materia 
(esta información indica si aprobó la cursada o aprobó el final).

Todos los archivos están ordenados por código de alumno y en el archivo detalle puede haber 0, 1 ó más registros 
por cada alumno del archivo maestro. Se pide realizar un programa con opciones para: 

    a. Actualizar el archivo maestro de la siguiente manera:
        i. Si aprobó el final se incrementa en uno la cantidad de materias con final aprobado, y se decrementa en uno la cantidad de 
            materias sin final aprobado.
        ii. Si aprobó la cursada se incrementa en uno la cantidad de materias aprobadas sin final.

    b. Listar en un archivo de texto aquellos alumnos que tengan más materias con finales aprobados que materias sin 
        finales aprobados. Teniendo en cuenta que este listado es un reporte de salida (no se usa con fines de carga), 
        debe informar todos los campos de cada alumno en una sola línea del archivo de texto.

NOTA: Para la actualización del inciso a) los archivos deben ser recorridos sólo una vez.}
program ej_02;
const
    VALOR_ALTO = 9999;
type
    str10 = string[10];
    alumno = record 
        cod: integer;
        apellido: str10;
        nombre: str10;
        matConFinal: integer;
        matSinFinal: integer;
    end;

    info = record
        cod: integer;
        materia: str10;
        cursada: boolean;
        final: boolean;
    end;

    aMaestro = file of alumno;
    aDetalle = file of info;


{ ------------------------------------------- Procedimientos ------------------------------------------- }
procedure leer (var a: aDetalle; var alu: alumno);
begin
    if (not eof(a))then 
        read (a, alu)
    else 
        alu.cod:= VALOR_ALTO;
end;
{ ------------------------------------------- Procedimientos ------------------------------------------- }
procedure actualizacionMaestro(var aMae: aMaestro; var aDet: aDetalle);
var 
    aluActual: alumno;
    i: info;
    totalFinales: integer;
    totalCursadas: integer;
begin
    Reset (aMae);
    Reset (aDet);
    read (aMae, aluActual);
    leer (aDet, i);
    while (i.cod <> VALOR_ALTO) do 
    begin
        totalFinales:= 0;
        totalCursadas:= 0;
// Busco el alumno que tengo que actualizar en el maestro
        while (i.cod <> aluActual.cod) do
        begin
            read (aMae, aluActual);          
        end;
// Una vez que lo encuentro, itero mientras sea el mismo codigo, sumo
        while (i.cod = aluActual.cod) do 
        begin
            if (i.cursada = true) then begin
                if (i.final = true) then
                    totalFinales:= totalFinales + 1
                else 
                    totalCursadas:= totalCursadas + 1;
            end;
            leer (aDet, i);
        end;
        aluActual.matConFinal:= totalFinales;
        aluActual.matSinFinal:= totalCursadas;
        Seek (aMae, FilePos(aMae)-1);
        write (aMae, aluActual);
    end;
    Close (aMae);
    Close (aDet);
end;
{ ------------------------------------------- Procedimientos ------------------------------------------- }
procedure cargaDeAlumnos (var mae: aMaestro; var carga: Text);
var 
    a: alumno;
begin 
    reset (mae);
    rewrite(carga);
    while (not eof(mae)) do begin
        read (mae, a);
        if (a.matConFinal > a.matSinFinal) then
            write (carga,' ', a.cod, ' ', a.nombre, ' ', a.apellido, ' ', a.matConFinal, ' ', a.matSinFinal);
    end;
    close (mae);
    close(carga);
end;
{ ----------------------------------------- Programa Principal ----------------------------------------- }
var
    aMae: aMaestro;
    aDet: aDetalle;
    cargaAlumnos: Text;
begin
    Assign (aMae, 'Archivo Maestro');
    Assign (aDet, 'Archivo Detalle');
    Assign (cargaAlumnos, 'Archivo.txt');
{------------- Inciso A ------------- }
    actualizacionMaestro (aMae, aDet);
{------------- Inciso B ------------- }
    cargaDeAlumnos(aMae, cargaAlumnos);
end.