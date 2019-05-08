process cliente[c:1..C]
begin
	oficina.encolar(c);
	oficina.tomarPlanilla(planilla);
	completarPlanilla(planilla);
	oficina.esperarAtencion(c);
	oficina.entregarPlanilla(planilla);
	oficina.recibirComprobante(comprobante);	
end;

process empleado
begin
while (true)
	oficina.atender(c);
	oficina.obtenerPlanilla(planilla);
	cargarDatos(planilla,comprobante);
	oficina.entregarComprobante(comprobante);
end;