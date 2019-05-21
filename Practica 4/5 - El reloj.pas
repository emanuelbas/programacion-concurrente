Program reloj
//Voy a usar un proceso auxiliar para las personas, asi estas pueden retirarse y el proceso se queda
//Lo voy a llamar proxy porque se me canta nomas!
//En este caso los empleados no requieren checkear si la cola esta vacia por lo tanto no necesito usar un coordinador
procedure persona[p:1..N]
begin
	send cola(p);
	send iniciar_reloj[p]();
	receive paso_algo[p](id_empleado); //Acabo el tiempo o me atendieron
	if (id_empleado <> -1) then
		realizar_operaciones();
		send finalizar_atención[id_empleado]()
	//Me voy
end;

procedure empleado[e:1..2]
begin
	while (true) do
	begin
		receive cola(p);
		send aviso[p](e);
		receive presente[p](esta_presente);
		if esta_presente
			//Lo atiende hasta que el cliente termina
			receive finalizar_atención[e];
	end;
end;

procedure proxy[p:1..N]
begin
	receive aviso[p](id_empleado);
	if id_empleado > 0 then //Lo atiende un empleado
		send paso_algo[p](id_empleado);
		send presente[id_empleado](true);
		//Ahora espera el llamado del timer para descartarlo
		receive aviso[p](id_empleado);
	else //El timer llego primero
		send paso_algo[p](0); //Envio marca de timeout
		//ahora espero al empleado para decirle que la persona ya se fue
		receive aviso[p](id_empleado);
		send presente[id_empleado](false);
end;