program comidaRapida;

begin

procedure persona[p:1..N]

begin
	buffer!encolar(p);
	timer[p]!iniciar();
	proxy[p]?getAccion(accion);
	if accion == 'atencion' then
		//recibo atencion
		emplado!fin_atencion();
	end if;
	//El cliente se retira
	
end;

procedure timer[t:1..N]

begin
	persona[t]?iniciar();
	delay();
	proxy[t]!evento();
end;

procedure buffer
var
	cola : queue;
begin
	while (true)
		if ();persona[*]?encolar(c) -> cola.push(c);
		[] (!empty(cola)); empleado?estoy_libre() -> empleado!get_cliente(cola.pop(c));
end;

procedure proxy[p:1..N]
// En if, Si no hay ninguna guarda elegible, 
//pero algunas están en estado bloqueado, 
//se queda esperando en el if hasta que alguna se vuelva elegible. 

//Bloqueada: la condición booleana es verdadera y la sentencia de 
//comunicación no se puede resolver inmediatamente.

begin
	if (); timer[p]?evento() ->
		persona[p]!accion('andate');
		//Luego me quedo esperando el llamado del empleado
		emplado?evento();
		empleado!estado_persona('ya se fue');
	[] (); empleado?evento() ->
		empleado!estado_persona('presente');
		persona[p]!accion('atencion');
		//Dejo el proxy esperando al timer, en este caso no hago nada
		timer[p]?evento();
end;

procedure empleado

begin
	while (true) do
	begin
		buffer!estoy_libre();
		buffer?get_cliente(c);
		proxy[c]!evento();
		proxy[c]?estado_persona(estado);
		if (estado == 'presente') then
		begin
			//Atiendo a la persona hasta que ella quiera
			persona[c]?fin_atencion();
		end if;		
	end while;
end;

end.