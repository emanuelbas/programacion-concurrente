task type cliente;
task server;

task server is
	entry solicitar_asiento(in destino: string; out asiento: integer);
end server;

task body cliente is
	server.solicitar_asiento(unDestino,respuesta);
	if respuesta <> -1 then
		imprimir(respuesta);
	end if;
end cliente;

task body server is
	asientos_disponibles : array of integer;
	loop
		accept solicitar_asiento(unDestino,asiento) is
			if hayAsientoPara(unDestino) then
				asiento := ocuparAsientoPara(unDestino);
			else
				asiento := -1;
			end if;
		end solicitar_asiento;
	end loop;
end server;