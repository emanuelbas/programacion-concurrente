task type cliente;
task empleado;

task empleado is
	entry pedir_atencion();
	entry finalizar();
end empleado;

task body cliente is
	select 
		empleado.pedir_atencion();
		-- Recibe atencion
		empleado.finalizar();
	OR
		DELAY (600);
		-- El cliente se retira --
	end select;
end cliente;

task body empleado is
	loop
		accept pedir_atencion();
		-- Esperar que el cliente desee finalizar
		accept finalizar();
	end loop;
end empleado;

clientes array(1..N) of cliente;