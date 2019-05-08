//Primer parcial Concurrente 04/05/2017

// SENTENCIAS AWAIT ( <> y <await B; S> )
// Resolver el problema de los filosofos, evitando deadlock y demora innecesaria

boolean[1..N] tenedores := ([N],0);

Procedure filosofo[f:1..(N/2)+1)];

if (f == 1) izquierdo := N
else izquierdo = f-1;
if (f == ((N/2)+1)) derecho := 1
else derecho = f+1;
while (true)
begin
	<await ((tenedores[izquierdo] == 0) AND (tenedores[derecho] == 0)); tenedores[izquierdo] := 1; tenedores[derecho] := 1>
	delay(tiempoEnComer(f));
	tenedores[izquierdo] := 0;
	tenedores[derecho] := 0;
end;


// SEMAFOROS
// En una fabrica hay 4 carpinteros, 1 vidriero y 2 armadores
// Los carpinteros fabrican marcos y los dejan en un alamacen con capacidad 30
// El vidriero hace vidrios y los deja en un deposito con capacidad 50
// Los armadores toman un marco y un vidrio y hacen una ventana
// Resolver con semaforos, Maximizar la concurrencia

sem marcosDepositados := 0;
sem vidriosDepositados := 0;
sem hayLugarEnDepositoMarcos := 30;
sem hayLugarEnDepositoVidrios := 50;
sem mutex_marcos:=1, mutex_vidrios:=1, mutex_ventanas:=1;
int marcos := 0, vidrios := 0, ventanas := 0;

Procedure carpintero[c:1..4]
while (true)
begin
	delay(tiempoEnFabricarMarco(c));
	P(hayLugarEnDepositoMarcos);
	P(mutex_marcos);
	marcos++;
	V(mutex_marcos);
	V(marcosDepositados);
end;

Procedure vidriero
while (true)
begin
	delay(tiempoEnFabricarVidrio());
	P(hayLugarEnDepositoVidrios);
	P(mutex_vidrios);
	vidrios++;
	V(mutex_vidrios);
	V(vidriosDepositados);
end;

Procedure armador[a:1..2]
while (true)
begin
	P(marcosDepositados);
	P(mutex_marcos);
	marcos--;
	V(mutex_marcos);
	V(hayLugarEnDepositoMarcos);
	P(vidriosDepositados);
	P(mutex_vidrios);
	vidrios--;
	V(mutex_vidrios);
	V(hayLugarEnDepositoVidrios);
	delay(tiempoEnFabricarVentana(a));
	P(mutex_ventanas);
	ventanas++;
	V(mutex_ventanas);
end;


// MONITORES
// Un equipo de videoconferencia puede ser usado por una persona a la vez 
// Hay P personas que utilizan este equipo (una unica vez cada uno)
// Para su trabajo, de acuerdo a su prioridad
// La prioridad de cada persona está dada por un numero entero positivo
// Ademas existe un administrador que cada 3hs incrementa en 1 la prioridad
// de todas las personas que estan esperando usar el equipo
// MAXIMIZAR LA CONCURRENCIA

 