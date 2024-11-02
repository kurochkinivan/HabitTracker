rm: 
	docker compose stop \
	&& docker compose down -v \
	&& docker compose rm \
	&& docker image rm ht-backend:local \
	&& sudo rm -rf pgdata/

up: 
	docker build -t ht-backend:local . \
	&& docker compose up --detach --force-recreate

up-db:
	docker compose up -d postgresql

rm-db:
	docker compose stop \
	&& docker compose rm \
	&& sudo rm -rf pgdata/