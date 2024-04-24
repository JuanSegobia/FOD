{ Se cuenta con un archivo de productos de una cadena de venta de alimentos congelados. De cada producto se 
almacena: código del producto, nombre, descripción, stock disponible, stock mínimo y precio del producto.
Se recibe diariamente un archivo detalle de cada una de las 30 sucursales de la cadena. Se debe realizar
el procedimiento que recibe los 30 detalles y actualiza el stock del archivo maestro.
 La información que se recibe en los detalles es: código de producto y cantidad vendida. Además, 
se deberá informar en un archivo de texto: nombre de producto, descripción, stock disponible y 
precio de aquellos productos que tengan stock disponible por debajo del stock mínimo. Pensar alternativas 
sobre realizar el informe en el mismo procedimiento de actualización, o realizarlo en un procedimiento 
separado (analizar ventajas/desventajas en cada caso).
    Nota: todos los archivos se encuentran ordenados por código de productos. En cada detalle puede venir 0 o N 
registros de un determinado producto. }
program ej_05;
const
    DIMF = 30;
    VALOR_ALTO = 9999; 
type
    str15 = String[15];
    producto = record
        cod: Integer;
        nombre: str15;
        descripcion: str15;
        stockDispo: integer;
        stokMinimo: Integer;
        precio: real;
    end;

    rDetalle = record
        cod: integer;
        cantVendida: integer;
    end;

    vRegistroDetalle = array[1..DIMF] of rDetalle;
    
    aMaestro = file of producto;
    
    aDetalle = file of detalle;
    arraySucursales = array[1..DIMF] of aDetalle;

{ ------------------------------------------- Procedimientos ------------------------------------------- }
procedure leer (var aDet: arraySucursales; d: rDetalle);
begin 
    if (not eof(aDet)) then  
        read (aDet, d)
    else 
        d.cod = VALOR_ALTO;
end;
{ ------------------------------------------- - - - - - - - - ------------------------------------------- }
procedure asignarDetalles(var vRegistros: vRegistroDetalle; var vSucursalesA: arraySucursales);
var
	i : integer; 
	iString : str20; 
begin
	for i:= 1 to DIMF do
		begin
			Str(i,iString); 
			{descomentar si se comentan los modulos de cargarMaestro y cargarDetalles}
			assign(vSucursalesA[i],'detalle_'+iString); 
			reset(vSucursalesA[i]); 
			leer(vSucursalesA[i],vRegistros[i]); 
		end; 
end; 
{ ====================================================================================================== }
procedure actualizarMaestro (var aMae: aMaestro; var vRegDet: vRegistroDetalle; var vSucursales: arraySucursales);
var
    
begin
  
end;
{ ----------------------------------------- Programa Principal ----------------------------------------- }
var 
    aMae: aMaestro;
    vSucursales: arraySucursales;
    vRegDet: vRegistroDetalle;
    
begin 
    assign (aMae, 'Archivo Maestro');
    asignarDetalles(vRegDet, vSucursales);
    actualizarMaestro(aMae, vRegDet, vSucursales);
end. 
