WP_DIR=/home/toteixei/data/wordpress
DB_DIR=/home/toteixei/data/db

all: run

build_volume:
	test -d $(WP_DIR) || sudo mkdir -p $(WP_DIR)
	test -d $(DB_DIR) || sudo mkdir -p $(DB_DIR)

rm_vol: down
	docker volume rm srcs_db_vol || true
	docker volume rm srcs_wp_vol || true
	sudo rm -rf $(WP_DIR) || true
	sudo rm -rf $(DB_DIR) || true

vol: down rm_vol build_volume

run: build_volume
	docker network create inception || true; 
	docker compose -f srcs/docker-compose.yml up --build  -d

down: 
	docker compose -f srcs/docker-compose.yml down

clean: down rm_vol
	docker network rm inception || true
	docker system prune -a

restart: down vol run

re: clean run

.PHONY: all run clean re