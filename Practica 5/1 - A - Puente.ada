-- Esto es un comentario!
----- ada no tiene bloques de comentarios -_- ----

--PesoPuente = 5
--Autos = 1
--Camioneta = 2
--Camion = 3
--Hay A,B,C autos, camionetas y camiones

--a) Todos los vehiculos tienen la misma prioridad
--b) Modificar para que los camiones tengan mayor prioridad



TASK TYPE Auto;
TASK TYPE Camioneta;
Task Type Camiones;
--Es  case-insensitive

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
  puente.AutoOut();
end Auto;

Task body Camioneta IS
	puente.CamionetaIn();
	puente.CamionetaOut();
end Camioneta;

Task body Camiones IS
	puente.CamionIn();
	puente.CamionOut();
end Camiones;

Task body Puente IS
	peso : Integer;
begin
	peso:=0;
	--Si no hay condicion puedo tirar un loop asi nomas.
	loop 
		--El select es no deterministico explicado en el punto 5
		select
			when ( peso <= 4 ) => accept AutoIn() IS
				peso := peso +1;
			end AutoIn;
			
			OR
			when ( peso <= 3 ) => accept CamionetaIn() IS
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
