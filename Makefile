
DATA = /home/$(USER)/data
WP_DATA = /home/$(USER)/data/wordpress # To change in case I change laptop
DB_DATA = /home/$(USER)/data/mariadb # To change in case I change laptop
REDIS_DATA = /home/$(USER)/data/redis # To change in case I change laptop

all: up

# creates the wordpress and mariadb directories.
# and runs docker compose in detach mode
up: build
	mkdir -p $(DATA)
	mkdir -p $(WP_DATA)
	mkdir -p $(DB_DATA)
	mkdir -p $(REDIS_DATA)
	docker compose -f ./srcs/docker-compose.yml up -d

# stop the containers
down:
	docker compose -f ./srcs/docker-compose.yml down

# stop the containers
stop:
	docker compose -f ./srcs/docker-compose.yml stop

build:
	docker compose -f ./srcs/docker-compose.yml  build

clean:
	@docker stop $$(docker ps -qa) || true
	@docker rm $$(docker ps -qa) || true
	@docker rmi -f $$(docker images -qa) || true
	@docker volume rm $$(docker volume ls -q) || true
	@docker network rm inception
	@sudo rm -rf $(DATA)

re: clean up

prune: clean
	@docker system prune -a --volumes -f