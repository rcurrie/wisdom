up:
	# Start up postgres with access to this directory under /data
	mkdir -p postgres
	docker run -it --rm --name postgres \
		-v `pwd`/postgres:/var/lib/postgresql/data \
		-v `pwd`:/wisdom \
		postgres:9.6

down:
	docker stop postgres && docker rm postgres

jupyter:
	docker run --rm -it --name jupyter \
			-p 52820:8888 \
			--link postgres:postgres \
			-v `pwd`:/home/jovyan \
			jupyter start-notebook.sh \
			--NotebookApp.password='sha1:53987e611ec3:1a90d791daf75274c73f62f672ecfa935799bdee'

reset:
	docker exec -it postgres psql -h localhost -U postgres -c "drop database if exists wisdom"
	docker exec -it postgres psql -h localhost -U postgres -c "create database wisdom"
	# docker exec -it postgres psql -h localhost -U postgres -d wisdom -f /wisdom/create.sql
	# docker exec -it postgres psql -h localhost -U postgres -d wisdom -f /wisdom/import.sql
	# docker exec -it postgres psql -h localhost -U postgres -d wisdom -c "create table reports(id serial primary key, report jsonb)"
	# docker exec -it postgres psql -h localhost -U postgres -c "\copy reports(report) from '/wisdom/samples/report.json'"
	# docker exec -it postgres psql -h localhost -U postgres -c "copy reports(report) from '/wisdom/samples/test.json'"
	# docker exec -it postgres psql -h localhost -U postgres -c "vacumn analyze reports"

psql:
	docker exec -it postgres psql -h localhost -U postgres -d wisdom
	
dump:
	docker exec -it postgres pg_dump -h localhost -U postgres -d wisdom
