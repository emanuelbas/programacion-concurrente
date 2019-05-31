task type persona;
task type enfermera;
task medico;
task consultorio;

task medico is
	entry atender_persona();
	entry atender_enfermera();
end medico;

task consultorio is
	entry dejar_nota(in nota:string);
	entry tomar_nota(out nota:string);
end consultorio;

task body persona is
	intentos := 0;
	loop ( intentos < 3 )
		select
			medico.atender_persona();
		or delay ( 5' );
			intentos++;
		end select;
	end loop;
end persona;

task body enfermera is
	loop
		delay();
		select
			medico.atender_enfermera();
		else
			escribir_nota(nota);
			consultorio.dejar_nota(nota);
		end select;
	end loop;
end enfermera;

task body consultorio is
	notas : queue;
	new(notas);
	loop
		select
			when ( !empty(notas) ) => accept tomar_nota(nota) is
				notas.pop(nota);
			end tomar_nota;
		or	accept dejar_nota(nota) is
			notas.push(nota);
			end dejar_nota;
		end select;
	end loop;
end consultorio;

task body medico is
	loop
		select
			accept atender_persona() is
				delay();
			end atender_persona;
		or when ( atender_persona'count = 0) =>
			accept atender_enfermera() is
				delay();
			end atender_enfermera;
		else
			select
				consultorio.tomar_nota(nota);
				delay();
			else
				null;
			end select;
		end select;
	end loop;
end medico;