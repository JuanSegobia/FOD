{ Una empresa posee un archivo con información de los ingresos percibidos por diferentes empleados en concepto 
de comisión, de cada uno de ellos se conoce: código de empleado, nombre y monto de la comisión. 
La información del archivo se encuentra ordenada por código de empleado y cada empleado puede aparecer más 
de una vez en el archivo de comisiones.
Realice un procedimiento que reciba el archivo anteriormente descrito y lo compacte. En consecuencia, deberá 
generar un nuevo archivo en el cual, cada empleado aparezca una única vez con el valor total de sus comisiones.

NOTA: No se conoce a priori la cantidad de empleados. Además, el archivo debe ser recorrido una única vez. }
program ej_01;
const
    VALOR_ALTO = 99999;
type
    comision = record   
        cod: integer;
        nombre: string[10];
        monto: real;
    end;

    archivoComisiones = file of comision;

    archivoCompacto = file of comision;

{ ------------------------------------------- Procedimientos ------------------------------------------- }

procedure leer (var archDuplicados: archivoComisiones; var c: comision);
begin
    if (not (eof(archDuplicados))) then
        read (archDuplicados, c)
    else
        c.cod:= VALOR_ALTO;
end;

{ ------------------------------------------- -------------- ------------------------------------------- }

procedure compactarArchivos(var archDuplicados: archivoComisiones; var archNuevo: archivoCompacto);
var
    c, cActual: comision;
begin
    reset (archDuplicados);
    Reset (archNuevo);
    leer(archDuplicados,c);
    while (c.cod <> VALOR_ALTO) do 
    begin
        cActual:= c;
        cActual.monto:= 0;
        while (cActual.cod = c.cod) do 
        begin 
            cActual.monto:= cActual.monto + c.monto;
            leer (archDuplicados,c);
        end;
        write (archNuevo, cActual);
    end;
    Close(archDuplicados);
    Close(archNuevo);
end;

{ ----------------------------------------- Programa Principal ----------------------------------------- }
var
    archivoConDuplicados: archivoComisiones;
    archivoActualizado: archivoCompacto;
begin
    assign (archivoConDuplicados, 'archivo con empleados duplicados');
    Assign (archivoActualizado, 'Archivo actualizado y compacto');

{ Debemos suponer que el archivo con duplicados ya esta cargado y ordenado por codigo de empleado }
    compactarArchivos (archivoConDuplicados, archivoActualizado);

end.