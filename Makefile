# Makefile for Homelab Docker Services
#
# Manages all Docker Compose services in the 'services/' directory.
# If SERVICE is omitted or set to 'all', the command applies to all services.

STACK_NAME_PREFIX := $(shell grep '^STACK_NAME_PREFIX=' .env | cut -d= -f2)
SERVICES := $(shell find services -mindepth 1 -maxdepth 1 -type d -exec test -f '{}/docker-compose.yml' \; -print | xargs -n1 basename)
COMPOSE_ENV_FILES = --env-file .env

# Macro: Run a docker compose command for a given service and arguments, with COMPOSE_PROJECT_NAME
DOCKER_COMPOSE_CMD = COMPOSE_PROJECT_NAME=$(STACK_NAME_PREFIX)-$(1) docker compose $(COMPOSE_ENV_FILES) -f services/$(1)/docker-compose.yml $(2)
ALL_SERVICES = [ "$(SERVICE)" = "all" ] || [ -z "$(SERVICE)" ]

# Macro: Run a docker compose command for all services or a specific one
run-all-or-one = \
	if $(ALL_SERVICES); then \
	  for s in $(SERVICES); do \
	    $(call DOCKER_COMPOSE_CMD,$$s,$(1)); \
	  done; \
	else \
	  $(call DOCKER_COMPOSE_CMD,$(SERVICE),$(1)); \
	fi

down:
	@$(call run-all-or-one,down)

logs:
	@$(call run-all-or-one,logs -f)

ps:
	@$(call run-all-or-one,ps)

prune:
	@docker container prune -f
	@docker image prune -f

clean:
	@docker container rm -f $$(docker ps -aq --filter "name=$(STACK_NAME_PREFIX)") 2>/dev/null || true
	@docker volume rm $$(docker volume ls -q --filter "name=$(STACK_NAME_PREFIX)") 2>/dev/null || true
	@docker network rm $$(docker network ls -q --filter "name=$(STACK_NAME_PREFIX)") 2>/dev/null || true

restart:
	@$(MAKE) check-env
	@$(call run-all-or-one,restart)
	
up:
	@$(MAKE) create-missing-env
	@$(MAKE) check-env
	@$(MAKE) prune
	@$(call run-all-or-one,up -d)

status:
	@docker ps --filter "name=$(STACK_NAME_PREFIX)" --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'

check-env:
	@python3 scripts/check_env.py .env.example .env
	@for s in $(SERVICES); do \
	  example="services/$$s/.env.$$s.example"; \
	  target=".env.$$s"; \
	  if [ -f $$example ] && [ -f $$target ]; then \
	    python3 scripts/check_env.py $$example $$target; \
	  fi; \
	done

create-missing-env:
	@for s in $(SERVICES); do \
	  example="services/$$s/.env.$$s.example"; \
	  target=".env.$$s"; \
	  if [ -f $$example ] && [ ! -f $$target ]; then \
	    cp $$example $$target; \
	    echo "Created $$target from $$example"; \
	  fi; \
	done

init:
	@if [ -f .env.example ]; then \
	  if [ -f .env ]; then \
	    read -p ".env already exists. Overwrite? [y/N] " ans; \
	    if [ "$$ans" = "y" ] || [ "$$ans" = "Y" ]; then \
	      cp .env.example .env; \
	      echo "Copied .env.example to .env"; \
	    else \
	      echo "Skipped .env"; \
	    fi; \
	  else \
	    cp .env.example .env; \
	    echo "Copied .env.example to .env"; \
	  fi; \
	fi; \
	for s in $(SERVICES); do \
	  example="services/$$s/.env.$$s.example"; \
	  target=".env.$$s"; \
	  if [ -f $$example ]; then \
	    if [ -f $$target ]; then \
	      read -p "$$target already exists. Overwrite? [y/N] " ans; \
	      if [ "$$ans" = "y" ] || [ "$$ans" = "Y" ]; then \
	        cp $$example $$target; \
	        echo "Copied $$example to $$target"; \
	      else \
	        echo "Skipped $$target"; \
	      fi; \
	    else \
	      cp $$example $$target; \
	      echo "Copied $$example to $$target"; \
	    fi; \
	  fi; \
	done

help:
	@echo "Available commands:"
	@echo "  make check-env                     Validate .env against .env.example"
	@echo "  make clean                         Remove stopped containers, volumes, and networks for this stack"
	@echo "  make create-missing-env            Create missing .env files from .env.example files (without overwriting)"
	@echo "  make down [SERVICE=name|all]       Stop all or a specific service (only for this stack)"
	@echo "  make help                          Show this help message"
	@echo "  make init                          Copy all .env.example and .env.(service).example files to root, with prompts"
	@echo "  make logs [SERVICE=name|all]       View logs for all or a specific service"
	@echo "  make ps [SERVICE=name|all]         Show status for all or a specific service"
	@echo "  make prune                         Remove unused containers and images (only for this stack)"
	@echo "  make restart [SERVICE=name|all]    Restart all or a specific service"
	@echo "  make status                        Show running containers for this stack"
	@echo "  make up [SERVICE=name|all]         Start all or a specific service (auto-creates missing .env files)"

