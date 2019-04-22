3.  Resolver el problema de P productores y C consumidores con un buffer de tamaño N. 
´´´java
procedure productor[p:1..P]
generarProducto(producto)
buffer.producir(producto)

//Que pasa cuando yo quiero pushear, puede que no haya lugar en el buffer entonces encolo el proceso y marco que hay un proceso en espera para que el consumidor lo despierte, evidentemente tambien voy a tener que usar una variable auxiliar para controlar si la cola esta llena o no.. ya que si se hace un lugar no debo permitir que lo tome cualquiera, solo el proceso que yo despierto
//En el caso contrario, si hay lugar en el buffer lo guardo ahi

procedure consumidor[c:1..C]
buffer.consumir(producto)
usarProducto(producto)

monitor buffer
cond productores, consumidores
queue productos
int productoresEnCola= 0
int consumidoresEnCola= 0
int cantidadEnBuffer=0

procedure producir(producto)

if (cantidadEnBuffer > N) 	//Si no puedo producir espero	
	productoresEnCola++
	wait(productores)

//Cuando si puedo coloco un elemento y le doy el monitor al primero de la cola,
si no hay nadie en la cola lo libero para que entre cualquiera
productos.push(producto)
if (consumidoresEnCola>0)
	consumidoresEnCola--
	signal (consumidores)
else
	cantidadEnBuffer++

procedure consumir(producto)

//Voy a intentar consumir, si el buffer esta vacio tengo que esperar hasta que un productor lo despierte

//Si no puedo consumir espero
if (cantidadEnBuffer == 0) 
	consumidoresEnCola++
	wait(consumidores)

//Cuando si puedo saco un elemento y le doy el monitor al primero de la cola,
si no hay nadie en la cola lo libero para que entre cualquiera
productos.pop(producto)
if (productoresEnCola>0)
	productoresEnCola--
	signal(productores)
else
	cantidadEnBuffer--

´´´