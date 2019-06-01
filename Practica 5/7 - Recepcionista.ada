task recepcionista;
task type cliente;
task type empleado;

task recepcionista is
	entry hacer_reclamo(in reclamo:string, out nreclamo:integer);
	entry pedir_trabajo(out reclamo);
end recepcionista;

task body cliente is
	loop
		delay(); --Hace sus cosas
		recepcionista.hacer_reclamo(unReclamo,nreclamo);
	end loop;
end cliente;

task body empleado is
	loop
		recepcionista.pedir_trabajo(unReclamo);
		resolver(unReclamo);
	end loop;
end empleado;

task body recepcionista is
	contReclamos : integer;
	reclamos : queue of string;
	contReclamos:=0;
	loop
		select
			when (pedir_trabajo'count = 0) => accept hacer_reclamo(in reclamo:string, out nreclamo:integer) is
				contReclamos++;
				nreclamo:= contReclamos;
				reclamos.push(reclamo);
			end hacer_reclamo;
		or
			when (!empty(reclamos)) => accept pedir_trabajo(out reclamo) is
				resolver(reclamo);
			end pedir_trabajo;
		end select;
	end loop;
end recepcionista;