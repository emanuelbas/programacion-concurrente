task type tipo_1;
task type tipo_2;
task type tipo_3;
task database;

task database is
	entry read();
	entry write();
	entry fin_read();
	entry fin_write();
end database;

task body tipo_1 is
	while true loop
		select
			database.write();
			-- Escribe la database
			database.fin_write();
		or delay ( 2 * 60 )
			delay ( 5 * 60 ) -- Espera 5 antes de volver a intentarlo
		end select;
	end loop;
end tipo_1;

task body tipo_2 is
	while true loop
		select
			database.write();
			-- Escribe la database
			database.fin_write();
		or delay ( 5 * 60 )
			select
				database.read();
				-- Lee la database
				database.fin_read();
			or delay ( 5 * 60 )
				-- No hace nada y vuelve a comenzar
			end select;
		end select;
	end loop;
end tipo_2;

task body tipo_3 is
	while true loop
		select
			database.read();
			-- Lee la database;
			database.fin_read();
		else
			database.write();
			-- Escribe la database
			database.fin_write();
		end select;
	end loop;
end tipo_3;

task body database is
	lectores, escritores : integer;
	lectores := 0;
	escritores := 0;
	
	while true loop
		select
			-- Se podra escribir cuando no haya procesos en la BD
			when ( lectores = 0 and escritores = 0 ) =>
				accept write() is
					escritores := escritores + 1;
				end write;
			or
			-- Se podra leer cuando no haya escritores ni pedidos de escritura
			when ( escritores = 0 and write’count = 0 ) =>
				accept read() is
					lectores := lectores + 1;
				end read;
			or
				accept fin_read() is
					lectores := lectores - 1;
				end fin_read;
			or
				accept fin_write() is
					escritores := escritores - 1;
				end fin_write;
		end select;
	end loop;
end database;