program acopiadora
var

begin

procedure camion[c:1..N]
begin
	send cola(c);
	send timer[c]();
	receive accion[c](accion);
	if accion == 'descargar' then
		descargar();
		send listo();
end;

procedure timer[t:1..N]
begin
	receive timer[t]();
	delay();
	send accion_proxy[t]('timeout');
end;

procedure empleado
var
	boolean esta_presente;
begin
	while (true)
		receive cola(c);
		send accion_proxy[c]('atencion');
		receive presente[c](esta_presente);
		if esta_presente then
			send accion[c]('atencion');
			receive listo();		
end;

procedure proxy[p:1..N]
begin
	receive accion_proxy[p](accion);
	if accion == 'atencion' then
		send presente[p](true);
		receive accion_proxy[p](accion); //Lo dejo esperando al timer
	else //Es el timer
		send accion[p]('timeout');
		receive accion_proxy[p](accion); //Lo dejo esperando al empleado
		send presente[p](false);
end;

end.