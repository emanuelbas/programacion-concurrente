-- Resolver con PMA.
-- N alumnos rinden un examen de promocion, M rinden normal, los alumnos realizan 
-- el examen (suponga que ya lo tienen al empezar) y luego lo entregan. Hay 3 profesores
-- que corrigen los examenes priorizando los de promocion, luego le dan la nota al alumno y este se retira.

procedure alumno(a:1..N+M)
	tipo,examen : string;
begin
	tipo := tipo();
	resolver(examen);
	if (tipo = 'promocion') then send promocion(a,examen)
	else send normal(a,examen);
	receive resultado[a](nota);	
end;

procedure cola

begin
	while (true) do
		if ((empty(promocion)) and !(empty(normal))); receive profesor_libre(p) =>
			receive normal(a,examen);
			send corregir[p](a,examen);
		[] !(empty(promocion)); receive profesor_libre(p); =>
			receive promocion(a,examen);
			send corregir[p](a,examen);
		end if;
	end while;			
end;

procedure profesor(p:1..3)
begin
	while (true) do
	begin
		send profesor_libre(p);
		receive corregir[p](a,examen);
		corregir(examen,resultado);
		send resultado[a](resultado);
	end;
end;

-- Resolver con PMS
-- En una exposición de aeronautica N personas quieren usar un simulador, solo pueden acceder de a uno
-- Hay un unico empleado. 

-- Resolver con ADA
-- N usuarios y M directores quieren usar una impresora de uno a la vez, deben pasar en orden
-- dando prioridad siempre a los directores. Los usuarios esperan hasta imprimir luego se retiran.
-- Los directores esperan hasta 5' si no lo logran se retiran sin imprimir.