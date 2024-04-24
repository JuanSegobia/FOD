program ej_4;
type
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

procedure cargarEmpleados(var empleado: archivoEmpleados);
var
  e: empleado;
begin
  writeln ('Ingrese el apellido del empleado');
  readln (e.apellido);
  while e.apellido <> 'fin' do begin
      writeln ('Ingrese el nombre del empleado');
      readln (e.Nombre);
      writeln ('Ingrese el numero del empleado');
      readln (e.numEmpleado);
      writeln ('Ingrese la edad empleado');
      readln (e.edad);
      writeln ('Ingrese el DNI del emmpleado');
      readln (e.dni);
      write(empleado, e); {cargo el empleado recien leido en el archivo}
      writeln ('Ingrese el apellido del empleado');
      readln (e.apellido);
    end;
end;

procedure buscarNombre(var a:archivoEmpleados);
var
  nombre, apellido: string [12];
  e: empleado;
begin
  writeln('Ingrese el nombre del empleado a buscar');
  readln(nombre);
  writeln('Ingrese el apellido del empleado a buscar');
  readln(apellido);
  reset (a);
  while not Eof (a) do begin
    Read (a, e); 
    if ((e.apellido) = apellido) or ((e.nombre) = nombre) then
    begin
      writeln (e.apellido, ' ', e.nombre, ' ',e.numEmpleado, ' ',e.edad, ' ',e.dni);
    end;
  end;
  Close(a);
end;

procedure listarEmpleados (var a:archivoEmpleados);
var
  e: empleado;
begin
  reset (a);
  while not Eof (a) do begin
    Read (a, e);
    writeln ('Apellido: ',e.apellido, '. Nombre: ', e.nombre, '. Numero de empleado: ',e.numEmpleado);{, '. Edad: ',e.edad, '. DNI: ',e.dni}
  end;
  Close (a);
end;

procedure empleadosMayores (var a:archivoEmpleados);
var
  e: empleado;
begin
  reset (a);
  while not eof (a) do begin
    read (a, e);
    if (e.edad > 70) then
      writeln ('El empleado: ',e.apellido, ' ', e.nombre, ' ',e.numEmpleado, ' ',e.edad, ' ',e.dni, ' Es mayor y esta pronto a jubilarse.');
  end;
end;

procedure recorrerArchivo(var a:archivoEmpleados);
begin
  buscarNombre(a);
  listarEmpleados(a);
  empleadosMayores(a);
end;

procedure crearNuevoEmpleado (var e:empleado);
begin
  writeln ('Ingrese el apellido del empleado: ');
  readln (e.apellido);
  writeln ('Ingrese el nombre del empleado: ');
  readln (e.Nombre);
  writeln ('Ingrese el numero del empleado: ');
  readln (e.numEmpleado);
  writeln ('Ingrese la edad empleado');
  readln (e.edad);
  writeln ('Ingrese el DNI del emmpleado');
  readln (e.dni);
end;

procedure agregarEmpleado (var a: archivoEmpleados);
var 
  eNuevo: empleado;
  eActual: empleado;
  esta: boolean;
begin
  esta:= false;
  crearNuevoEmpleado(eNuevo);
  reset (a);
  while (not eof (a)) and (not esta) do begin 
    read (a, eActual);
    if eActual.numEmpleado = eNuevo.numEmpleado then
      esta:= true;
  end;
  if not esta then
    write (a, eNuevo)
  else 
    writeln ('Numero de empleado repetido');
  Close(a);
end;

procedure exportarEmpleados (var a:archivoEmpleados; var carga: Text);
var 
  e: empleado;
begin
  reset (a);
  Rewrite (carga);
  while (not eof(arch)) do begin
    read (a, e);
    writeln (carga,' ',e.apellido,' ',e.nombre,' ',e.numEmpleado);
  end;
  Close (a); Close (carga);
end;

procedure exportarEmpSinDni (var a:archivoEmpleados; var carga: Text);
var 
  e: empleado;
begin
  reset (a);
  Rewrite (carga);
  while (not eof(arch)) do begin
    read (a, e);
    if (e.dni = 00) then
      writeln (carga,' ',e.apellido,' ',e.nombre,' ',e.numEmpleado);
  end;
  Close (a); Close (carga);
end;

var
  nombreArchivo: string[15];
  empleados: archivoEmpleados;
  carga: Text;
  cargaDni: Text;
begin
  writeln ('Ingrese el nombre del archivo');
  readln (nombreArchivo);
  Assign (empleados, nombreArchivo);
  Assign (carga, 'cargaDeArchivos.txt');
  Assign (cargaDni, 'faltaDNIEmpleado.txt');
  Rewrite (empleados);
  cargarEmpleados (empleados);
  Close (empleados);
  recorrerArchivo(empleados);
  agregarEmpleado(empleados);
  listarEmpleados(empleados);
  exportarEmpleados (empleados, carga);
  exportarEmpSinDni(empleado, cargaDni);
end.