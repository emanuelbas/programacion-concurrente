program consultorioYfarmacia;
begin

procedure cliente[c:1..N]

begin
	buffer_consultorio!encolar(c);
	medico?atender(receta);
	delay();
	buffer_farmacia!encolar(c);
	farmaceuta?atender();
	farmaceuta!mostrar_receta(receta);
	farmaceuta?recibir_medicamentos(medicamentos);	
end;

procedure buffer_consultorio
var
	Q:queue;
begin
	while (true)
		if ();cliente[*]?encolar(c) -> Q.push(c);
		[] (!empty(Q)); medico?libre() -> Q.pop(c);medico!getCliente(c);
end;

procedure buffer_farmacia
var
	Q:queue;
begin
	while (true)
		if ();cliente[*]?encolar(c) -> Q.push(c);
		[] (!empty(Q)); farmaceuta?libre() -> Q.pop(c);farmaceuta!getCliente(c);
end;

procedure medico
begin
	while (true)
	begin
		buffer_consultorio!libre();
		buffer_consultorio?getCliente(c);
		hacer_receta(receta);
		cliente[c]!atender(receta);
	end;
end;

procedure farmaceuta
begin
	while (true)
	begin
		buffer_farmacia!libre();
		buffer_farmacia?getCliente(c);
		cliente[c]!atender();
		cliente[c]?mostrar_receta(receta);
		preparar_medicamentos(receta,medicamentos);
		cliente[c]!recibir_medicamentos(medicamentos);
	end;
end.
