program radares
begin

procedure radar[r:1..10]
begin
	while (true) do
	begin
		datos := detectar();
		buffer!datos(datos);
	end;
end;

procedure unidad_de_procesamiento
begin
	while (true) do
	begin
		buffer!solicitar_datos();
		buffer?procesar_datos(datos);
		procesar(datos); 
	end;
end;

procedure buffer
var
	queue Q;
begin
	while (true) do
	begin
		if (); radar[*]?datos(datos) --> Q.push(datos);
		[] (); unidad_de_procesamiento?solicitar_datos() -->
			Q.pop(datos);
			unidad_de_procesamiento!procesar_datos(datos);
	end;
end;

end.