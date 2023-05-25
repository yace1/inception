.PHONY: build up start down destroy stop restart logs ps

DOCKER_COMPOSE := $(shell command -v docker-compose 2> /dev/null)
DOCKER_COMPOSE_ALT := $(shell command -v docker 2> /dev/null && docker compose --help 2> /dev/null)

ifeq ($(strip $(DOCKER_COMPOSE)),)
	ifneq ($(strip $(DOCKER_COMPOSE_ALT)),)
		DOCKER_COMPOSE := docker compose
	endif
endif

build:
	$(DOCKER_COMPOSE) -f srcs/docker-compose.yml build

up:
	$(DOCKER_COMPOSE) --file srcs/docker-compose.yml up -d

start:
	$(DOCKER_COMPOSE) --file srcs/docker-compose.yml start

down:
	$(DOCKER_COMPOSE) --file srcs/docker-compose.yml down

destroy:
	$(DOCKER_COMPOSE) --file srcs/docker-compose.yml down

stop:
	$(DOCKER_COMPOSE) --file srcs/docker-compose.yml stop

restart:
	$(DOCKER_COMPOSE) --file srcs/docker-compose.yml stop
	$(DOCKER_COMPOSE) --file srcs/docker-compose.yml up -d

logs:
	$(DOCKER_COMPOSE) --file srcs/docker-compose.yml logs --tail=100 -f
