
--b) Modificar para que los camiones tengan mayor prioridad

-- Se agrega a los when una condicion extra, esto se explica en el enunciado:
-- Dentro de la condición booleana de una alternativa (en el WHEN) se puede 
-- preguntar por la cantidad de entry call pendientes de cualquier entry de la tarea. 
-- Entonces voy a checkear que no hayan calls de camiones con (CamionIn’count = 0)


TASK TYPE Auto;
TASK TYPE Camioneta;
Task Type Camiones;

Task Puente IS
	entry AutoIn();
	entry AutoOut();
	entry CamionetaIn();
	entry CamionetaOut();
	entry CamionIn();
	entry CamionOut();
end Puente;

Task body Auto IS
  puente.AutoIn();
  -- Cruza el puente
  puente.AutoOut();
end Auto;

Task body Camioneta IS
	puente.CamionetaIn();
	-- Cruza el puente
	puente.CamionetaOut();
end Camioneta;

Task body Camiones IS
	puente.CamionIn();
	-- Cruza el puente
	puente.CamionOut();
end Camiones;

Task body Puente IS
	peso : Integer;
begin
	peso:=0;
	loop 
		select
			when ((CamionIn’count = 0)AND( peso <= 4 )) => accept AutoIn() IS
				peso := peso +1;
			end AutoIn;
			
			OR
			when ((CamionIn’count = 0)AND( peso <= 3 )) => accept CamionetaIn() IS
				peso := peso +2; 
			end CamionetaIn;
			
			OR
			when ( peso <= 2 ) => accept CamionIn() IS
				peso := peso +3; 
			end CamionIn;
			
			OR
			accept CamionOut() IS
				peso := peso - 3;
			end CamionOut;
			
			OR
			accept CamionetaOut() IS
				peso := peso - 2;
			end CamionetaOut;
			
			OR
			accept AutoOut() IS
				peso := peso - 1;
			end AutoOut;		
				
		end select;
	end loop;
		
end Puente;
