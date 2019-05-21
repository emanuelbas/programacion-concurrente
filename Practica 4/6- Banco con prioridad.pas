program bancoPrioridad
var
	chan cola_normal(int),cola_prioridad(int),atencion[N](),fin_atencion();
begin
procedure cliente[c:1..N]

begin
	int tipo_cliente := DarCategoria();
	if tipo_cliente == 'Esporadico' then
		send cola_normal(c);
	else
		send cola_prioridad(c);
	receive atencion[c]();
	delay();
	send fin_atencion();
end;

procedure empleado

while (true)
begin
	if (!empty(cola_prioridad))
		receive cola_prioridad(c);
		send atencion[c]();
		receive fin_atencion();
	else(!empty(cola_normal))
		receive cola_normal
		send atencion[c]();
		receive fin_atencion();
end;
end.