program tresEmpleados

procedure cliente[c:1..N]

begin
	buffer!cola(c);
	empleado?atencion(e);
	//Recibiendo atencion
	empleado!fin_atencion();
end;

procedure buffer

begin
	cola : queue;
	while (true)
		if ();cliente[*]?cola(c)
			-> cola.push(c);
		[] (!empty(cola));empleado[*]?estoy_libre(e)
			-> cola.pop(c);
			   empleado[e]!envio_cliente(c);
			   
			   
end;

procedure empleado [e:1..3]

begin
	while (true)
		buffer!estoy_libre(e);
		buffer?envio_cliente(c);
		cliente[c]!atencion(e);
		//Dando atencion hasta que el cliente lo solicite
		cliente[c]?fin_atencion();
end;