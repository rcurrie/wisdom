up:
	docker-compose up

down:
	docker-compose down

psql:
	docker-compose exec postgres psql -h localhost -U postgres
	
dump:
	docker-compose  exec -it postgres pg_dump -h localhost -U postgres -d wisdom
