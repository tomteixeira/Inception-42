WP_DIR=/home/sylvain/data/wordpress
DB_DIR=/home/sylvain/data/db

all: run

build_volume:
	test -d $(WP_DIR) || sudo mkdir -p $(WP_DIR)
	test -d $(DB_DIR) || sudo mkdir -p $(DB_DIR)

rm_vol: down
	docker volume rm srcs_mariadb_volume || true
	docker volume rm srcs_wordpress_volume || true
	sudo rm -rf $(WP_DIR) || true
	sudo rm -rf $(DB_DIR) || true

vol: down rm_vol build_volume

run: build_volume
	#docker network create inception || true; 
	docker compose -f srcs/docker-compose.yml up --build  -d

down: 
	docker compose -f srcs/docker-compose.yml down

clean: down rm_vol
	docker network rm inception || true
	docker system prune -a

restart: down vol run

re: clean run

.PHONY: all run clean re
