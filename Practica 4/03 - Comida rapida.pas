Program ComidaRapida

//Esto esta sin corregir y probablemente tenga algun problema
// inicializar canales!


procedure persona [p:1..N]
var
	Plato plato; 
	string pedido;
begin
	pedido := generar_pedido();
	send pedidos(p,pedido);
	receive recepcion[p](plato);
end;

procedure vendedor [v:1..3]
var
	int p;
	string pedido;
begin
	while true
		send quiero_atender(v);
		receive pedidos_privado_vendedor[v](p,pedido);
		if (p<>-1) //Hay pedidos
			send pedidos_a_cocineros(p,pedido);
		else
			delay();
end;

procedure cocinero [c:1..2]
begin
while (true)
	send cocinero_listo(c);
	receive pedido_privado_cocinero[c](p,pedido);
	plato := cocinar(pedido);
	send recepcion[p](plato);
end;


procedure coordinador_vendedores
begin
	while (true)
	begin
		receive quiero_atender(v);
		if (!empty(pedidos))
			receive pedidos(p,pedido);
			send pedido_privado_vendedor[v](p,pedido);
		else
			send pedido_privado_vendedor[v](-1,null);
	end;
end;


procedure coordinador_cocineros
begin
	while (true)
	begin
		receive cocinero_listo(c);
		receive pedidos_a_cocineros(p,pedido);
		send pedido_privado_cocinero[c](p,pedido);
	end;
end;


