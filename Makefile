all:
	@docker build -t nginx ./srcs/requirements/nginx
	@docker run -d --name container_nginx -p 443:443 nginx
	@docker ps

clean:
	@docker stop container_nginx
	@docker rm container_nginx
	@docker rmi nginx

.PHONY: all clean
