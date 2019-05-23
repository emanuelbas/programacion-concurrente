program genetica

begin 
	procedure A

	begin
		while (true)
			preparar(muestra);
			buffer_muestras!guardar(muestra);
	end;

	procedure buffer_muestras
	var
		almacen : queue;
	begin
		while (true)
			if ();A?guardar(muestra) -> almacen.push(muestra);
			[] (!empty(almacen)); B?pedir_muestra() 
				-> almacen.pop(muestra);
				   B!muestra(muestra);
	end;

	procedure B
	begin
		while (true)
			buffer_muestras!pedir_muestra();
			buffer_muestras?muestra(muestra);
			set_analisis := armar_set_de_analisis(muestra);
			C!analizar(set_analisis);
			C?resultados(resultados);
			archivar(resultados);
			
	end;

	procedure C

	begin
		while (true)
			B?analizar(set_analisis);
			resultados := realizar_analisis(set_analisis);
			B!resultados(resultados);
	end;

end.