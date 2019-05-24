program antivirus;

begin
	procedure robot[r:1..N]
	begin
		while (true)
			buscar_sitio_infectado(direccion);
			buffer!sitios(direccion);
	end;

	procedure buffer
	begin
		while (true)
			if ();robot[*]?sitios(direccion) -> sitios.push(direccion);
			[] (!empty(sitios)); analizador?libre() -> sitios.pop(direccion); analizador!sitio(direccion);
	end;

	procedure analizador
	begin
		while (true)
		begin
			buffer!libre();
			buffer?sitio(direccion);
			analizar(direccion,resultados);
			guardar_resultados(resultados);		
		end;
	end;
end.