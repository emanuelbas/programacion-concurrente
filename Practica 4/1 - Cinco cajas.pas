
Program CincoCajas

chan pedidos_caja(int);
chan caja_asignada[N](int);
chan cola_atencion[5](int);
chan atencion[N]();
chan descontar_de_cola(int);
chan despedirse_del_cajero[5]();

procedure persona [p:1..N]
begin
	int c;
	send pedidos_caja(p);
	receive caja_asignada[p](c);
	send cola_atencion[c](p);
	receive atencion[p]();
	//Recibe atencion
	send despedirse_del_cajero[c]();

end;

procedure coordinador
var
	int[5] personas_en_cola := ([5]0);
	int p,c;
begin
	while (true)
	begin
		if (!pedidos_caja.isEmpty())
			receive pedidos_caja(p);
			c := min(personas_en_cola);
			personas_en_cola[c]++
			send caja_asignada[p](c);
		[] (!descontar_de_cola.isEmpty())
			receive descontar_de_cola(c);
			personas_en_cola[c]--;
	end;
end;

procedure caja [c:1..5]
begin
	int p;
	while (true)
	begin
		receive cola_atencion[c](p);
		send atencion[p]();
		receive despedirse_del_cajero[c]();
		send descontar_de_cola(c);
	end;
end;