{5. Suponga que N personas llegan a la cola de un banco. Una vez que la persona 
se agrega en la cola no espera más de 15 minutos para su atención, si pasado 
ese tiempo no fue atendida se retira. Para atender a las personas existen 2 
empleados que van atendiendo de a una y por orden de llegada a las personas. 

}

monitor cola
begin
procedure encolar(int cliente)
procedure atender(int cliente)

procedure encolar(int cliente)
begin
	cola.push(cliente)
	//El cliente sera responsable de iniciar su timer
	//Ademas se dormira en su propio monitor
end;

procedure atender(int cliente)
begin
	exito = 0;
	while (exito <> 1)
		while (cola.isEmpty()) then wait(empleados)
		cola.pop(cliente);
		estado[cliente].atender(exito);
end;
end;

monitor estado[p:1..N]
begin
	int estado
	int slave_listo = false;
	cond slave;
	procedure slave_listo()
	//Duerme al slave hasta que se requiera iniciar la cuenta de tiempo
	procedure iniciar_timer()
	//Despierta al slave para comenzar a contar
	procedure getEstado(string estadoOUT)
	//Duerme al proceso hasta que sea atendido o pase el tiempo y devuelve cual paso
	procedure atender(int exito)
	//Si la persona aun esta en espera la despierta con estado de 'atendido' ademas devuelve true
	procedure timeout()
	//Si aun no fue atendido despierta a la persona con estado de 'gone'
	
	
	
	procedure slave_listo()
	begin
	//Si la persona aun no esta en la cola dejo al slave esperar a que llegue
	//Caso contrario si la persona ya llego empiezo a contar inmediatamente
		if (!persona_lista)	
			slave_listo = true;
			wait(slave);
	end;
	
	procedure iniciar_timer()
	//Si el slave aun no esta listo seteo una variable para que arranque
	//inmediatamente cuando llegue, si ya estaba listo tengo que despertarlo
	begin
		if (!slave_listo)
			persona_lista = true
		else
			signal(slave);
	end;
	
	procedure atender(int exito)
	//Se intenta atender al cliente, si aun no se fue se setea atendido, y se devuelve exito
	begin
		if (estado == 'waiting') then
			estado = 'atendido';
			exito = 1;
			signal(persona);
		else
			exito = 0;
	end;
	
	procedure timeout()
	//Si aun esta en espera se va
	begin
		if (estado == 'waiting') 
		then 
			estado = 'gone';
			signal(persona);
	end;
	
	procedure getEstado(string estadoOUT)
	begin
		if (estado == 'waiting') wait(persona)
		estadoOUT = estado;
	end;
	
end;

process persona[p:1..N]
begin
	string estado;
	cola.encolar(p);
	estado[p].iniciar_timer();
	estado[p].getEstado(estado)
	if (estado == 'atendido')
		"Recibiendo atención"
	"se va"
end;

process empleado[e:1..2]
var
	int cliente;
begin
	while (true)
		cola.atender(cliente)
		"Brindado atencion a cliente"
end;


process timer[t:1..N]
begin
	estado[t].slave_listo() 
	delay(10*60)
	estado[t].timeout()
end;
