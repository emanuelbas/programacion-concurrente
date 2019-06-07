program TresImpresoras
var
	//algunos chan
begin

procedure usuario[u:1..N]
begin
	while true
		//Trabajando
		send cola_normal(documento);
end;

procedure director
begin
	while true
		//Trabajando
		send cola_prioridad(documento);
end;

procedure coordinador

begin
	while ( true )
		receive impresoras(i);
		while ( true )
			if ( !empty( cola_prioridad ) =>
				receive cola_prioridad(documento)
				send imprimir[i](documento);
				break;
			[] ( !empty( cola_normal ) and ( cola_prioridad'count = 0 ) ) =>
				receive cola_normal(documento);
				send imprimir[i](documento);
				break;
			end;
		end;
	end;
end;

procedure impresora [i:1..3]

begin
	while true
		send impresoras(i);
		receive imprimir[i](documento);
		imprimir(documento);
end;

end.


//Este coordinador es el primero que hice, tiene error
//Ya que en ese instante donde se pasa del if al else podria llegar un pedido del director
//La herramienta if no deterministico sirve para respetar la atomicidad por lo tanto es mejor usarla
procedure coordinador
var
	boolean encontre_un_documento;
begin
	while (true)
		receive impresoras(i);
		encontre_un_documento := false;
		while (!encontre_un_documento)
			if (!empty (cola_prioridad)) then
				receive cola_prioridad(documento);
				send imprimir[i](documento);
				encontre_un_documento := true;
			else
				if (!empty (cola_normal)) then
					receive cola_prioridad(documento);
					send imprimir[i](documento);
					encontre_un_documento := true;
end;