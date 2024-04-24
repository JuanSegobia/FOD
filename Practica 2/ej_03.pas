{ El encargado de ventas de un negocio de productos de limpieza desea administrar el stock de los productos que vende. 
Para ello, genera un archivo maestro donde figuran todos los productos que comercializa. De cada producto se maneja la 
siguiente información: código de producto, nombre comercial, precio de venta, stock actual y stock mínimo. Diariamente se genera un 
archivo detalle donde se registran todas las ventas de productos realizadas. De cada venta se registran: código de producto y cantidad 
de unidades vendidas. Se pide realizar un programa con opciones para:
    a. Actualizar el archivo maestro con el archivo detalle, sabiendo que:
        ● Ambos archivos están ordenados por código de producto.
        ● Cada registro del maestro puede ser actualizado por 0, 1 ó más registros del archivo detalle.
        ● El archivo detalle sólo contiene registros que están en el archivo maestro.
    b. Listar en un archivo de texto llamado “stock_minimo.txt” aquellos productos cuyo stock actual esté por debajo del stock mínimo permitido. }

program ej_03;
const
    VALOR_ALTO = 9999;
type
    str10 = string[10];
    
    producto = record   
        cod: integer;
        nombre: str10;
        precio: real;
        stock: integer;
        stockMinimo: integer;
    end;

    venta = record
        cod: integer;
        cant: integer;
    end;

    maestro = file of proucto;
    detalle = file of venta;
{ ------------------------------------------- Procedimientos ------------------------------------------- }
procedure leer (var a: detalle; var p: producto);
begin
    if (not(eof(a)))then 
        read (a, p)
    else 
        p.cod:= VALOR_ALTO;
end;
{ ------------------------------------------- -- -- -- -- -- ------------------------------------------- }
procedure actualizacionMaestro(var mae: maestro; var det: detalle);
var
    p: producto;
    v: venta;
    cantidadTotal: integer;
begin
    reset (mae);
    reset (det);
    read (mae, p);
    leer (det, v);
    while (v.cod <> VALOR_ALTO) do begin 
        cantidadTotal:= 0;
        while (v.cod <> p.cod) do  
            read (mae, p);
        while (v.cod = p.cod) do begin 
            cantidadTotal:= cantidadTotal + v.cant;
            leer(det, v);
        end;    
        p.stock:= p.stock - cantidadTotal;
        Seek (mae, FilePos(mae)-1);
        write(mae, p);
    end;
    close(mae);
    close(det);
end;
{ ------------------------------------------- -- -- -- -- -- ------------------------------------------- }
procedure stockPermitido(var mae: maestro; var carga: Text);
var 
    p: producto;
begin
    Reset (mae);
    Rewrite (carga);
    while (not eof(mae)) do begin 
        read (mae, p);
        if (p.stock > p.stockMinimo) then 
            write (carga,' ', p.cod ,' ', p.nombre ,' ', p.precio ,' ', p.stock ,' ',p.stockMinimo);
    end;
end;
{ ----------------------------------------- Programa Principal ----------------------------------------- }
var
    aMae: maestro;
    aDet: detalle;
    carga: Text;
begin
    Assign (aMae, 'Archivo Maestro');
    Assign (aDet, 'Archivo Detalle');
    Assign (carga,'stock_minimo.txt');
    { --------- Inciso A ---------- }
    actualizarMaestro (aMae,aDet);
    { --------- Inciso B ---------- }
    stockPermitido(aMae, carga);
end.