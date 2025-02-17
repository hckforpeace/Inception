
WP_DATA = /home/pierre/wordpress # To change in case I change laptop
DB_DATA = /home/pierre/mariadb # To change in case I change laptop

all: up

# creates the wordpress and mariadb directories.
# and runs docker compose in detach mode
up: build
	mkdir -p $(WP_DATA)
	mkdir -p $(DB_DATA)
	docker compose -f ./srcs/docker_compose.yml up -d

# stop the containers
down:
	docker compose -f ./srcs/docker_compose.yml down

# stop the containers
stop:
	docker compose -f ./srcs/docker_compose.yml stop

build:
	docker compose -f ./srcs/docker_compose.yml build

clean:
	@docker stop $$(docker ps -qa) || true
	@docker rm $$(docker ps -qa) || true
	@docker rmi -f $$(docker images -qa) || true
	@docker volume rm $$(docker volume ls -q) || true
	@docker network rm $$(docker network ls -q) || true
	@rm -rf $(WP_DATA) || true
	@rm -rf $(DB_DATA) || true