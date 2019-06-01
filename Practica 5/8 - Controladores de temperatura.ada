task type controlador;
task central;

task central is
	entry informar_temperatura(in temp:integer,out respuesta: string);
end central;

task body central is
	loop
		accept informar_temperatura(temp,rsp) is
			if temp >= 40 then rsp := 'Detener'
			else rsp:='Seguir';
		end informar_temperatura;
	end loop;
end central;

task body controlador is
	loop
		temp:integer;
		rsp:string;
		captar(temp);
		central.informar_temperatura(temp,rsp);
		if rsp = 'Detener' then delay();
	end loop;
end controlador;