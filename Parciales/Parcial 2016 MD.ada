-- Resolver este ejercicio con PMS o ADA. 
-- En un banco se tiene un sistema que administra el uso de una sala de reuniones
-- por parte de N clientes. Los clientes se clasifican en habituales o temporales.
-- La sala puede ser usada por un unico cliente a la vez
-- Y cuando esta libre se debe determinar a quien permitirle su uso siempre priorizando a los clientes habituales
-- Dentro de cada clase de cliente se debe respetar el orden de llegada
-- Nota: suponga que existe una funcion tipo() que le indica al cliente de que tipo esta

----------------------
-- Solucion con PMS --
----------------------

procedure cliente (c: 1..N)
begin
	tipo := tipo();
	cola ! encolar(c,tipo);
	sala ? permitir();
	usando_sala();
end;

procedure cola
	cola_prioridad, cola_normal : Queue of int;
	c:int; tipo:string;
begin
	while (true) do
		if (); cliente(*) ? encolar(c,tipo)=>
			if ( tipo = 'normal' ) then cola_normal.push(c);
			else cola_prioridad.push(c);
		[] ((empty(cola_prioridad) and !(empty(cola_normal))); sala ? libre () =>
			cola_normal.pop(c);
			sala ! turno (c);
		[] (!(empty(cola_prioridad)))=>
			cola_prioridad.pop(c);
			sala ! turno (c);
		end if;
	end while;
end cola;

procedure sala
	c:int;
begin
	while (true) do
		cola ? turno (c);
		cliente(c) ! permitir();
		delay();
	end while;
end;


----------------------
-- Solucion con ADA --
----------------------

task type cliente;
task sala;
task buffer;

task cliente is
	entry identificar(in i:int);
	entry usar_sala();
end

task buffer is
	entry encolar(in i:int);
	entry tomarid(out i:int);
end sala;

-- Body

task body cliente is
	accept identificar(in i:int) do id := i;
	t := tipo();
	buffer.encolar(id,t);
	accept usar_sala() do usar();
end cliente;

task body buffer is
	loop
		select
			accept encolar(id,t) do
				if t = 'normal' then normal.push(id)
				else prioridad.push(id);
			end encolar;
		or
			when (empty(prioridad) and !(empty(normal))); accept tomarid(out id) is
				normal.pop(unaID);
				id := unaID;
			end tomarid;
		or
			when !(empty(prioridad)); accept tomarid(out i) is
				prioridad.pop(unaID);
				i := unaID;
			end tomarid;
		end select;
	end loop;
end buffer;

task body sala is
	loop
		buffer.tomarid(id);
		cliente(id).usar_sala();
	end loop;
end sala;

-- Programa principal
	cliente : array(n) of cliente;
	buffer : buffer;
	sala : sala;
	i : int;
begin
	for i:=1 to n loop
		cliente(i).identificar(i);
	end loop;
end;