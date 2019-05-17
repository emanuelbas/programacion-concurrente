
Program OficinaDePorteros

chan reclamos_en_oficina(Reclamo);
chan porteros_disponibles(int);
chan tarea[5](Reclamo)

procedure persona [p:1..N]
var
	Reclamo reclamo;
begin
	while (true)
	begin
		//La persona hace sus cosas
		reclamo := generarReclamo();
		send reclamos_en_oficina(reclamo);
	end;

end;

procedure coordinador
var
	
begin
	while (true)
	begin
		receive porteros_disponibles(p);
		if (!empty(reclamos_en_oficina))
			receive reclamos_en_oficina(reclamo);
			send tarea[p](reclamo);
		else
			send tarea[p](null);
	end;
end;

procedure portero [p:1..3]
begin
	reclamo r;
	while (true)
	begin
		send porteros_disponibles(p);
		recive tarea[p](r);
		if (r == null)
			delay();
		else
			resolver_reclamo(r);
	end;
end;