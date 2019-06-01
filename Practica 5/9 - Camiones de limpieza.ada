procedure limpieza is
	subtype ID is Integer range 1..P;
	
	task type persona;
	task empresa;
	task type camion;
	
	task persona is
		entry init(IN who: ID);
	end persona;
	
	task empresa is
		entry dejar_reclamo(IN persona: ID);
		entry tomar_trabajo(OUT persona: ID);
	end empresa;
	
	personas : array(ID) of persona;
	camiones : array(1..2) of camion;
	I : Integer;
	
	task body camion is
		persona : ID;
		loop
			tomar_trabajo(persona);
			resolver(persona);
		end loop;
	end camion;
	
	task body persona is
		myid:ID;
		reclamo:string;
		
		accept init(myid);
		loop
			generar_reclamo(reclamo);
			empresa.dejar_reclamo(reclamo);
		end loop;
	end persona;
	
	task body empresa is
		reclamos : array of integer;
		totalReclamos : integer;
		
		totalReclamos:=0;
		for I in ID loop
			reclamos(I) := 0;
		end loop;
		loop
			select
				accept dejar_reclamo(I:ID) is
					reclamos(I)++;
					totalReclamos++;
				end dejar_reclamo;
			or
				when (totalReclamos > 0) => accept tomar_trabajo(out persona: ID) is
					calcularIDMin(reclamos,I);
					reclamos(I) := 0;
					persona := I;
				end tomar_trabajo;
			end select;
		end loop;
	end empresa;
	
begin
	for I in ID loop
		personas(I).init(I);
	end loop;
end limpieza;
			
					
				