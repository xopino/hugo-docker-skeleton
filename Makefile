# Makefile for managing a HUGO site with Docker

# Variables
IMAGE_NAME := hugo-site
CONTAINER_NAME := hugo-site
HOST_PORT := 1313
CONTAINER_PORT := 1313

# Build the Docker image
build:
	docker build -t $(IMAGE_NAME) .

# Initialize a new Jekyll site
init:
	docker run --name $(CONTAINER_NAME) --rm -v "$$PWD:/src" $(CONTAINER_NAME) new site . --force --format yaml

# Run the Docker container with a health check
run:
	docker run --name $(CONTAINER_NAME) -d -p $(HOST_PORT):$(CONTAINER_PORT) -v "$$PWD:/src" -it $(IMAGE_NAME) server
	@echo "Waiting for Jekyll server to start..."
	@until curl -s http://localhost:$(HOST_PORT) > /dev/null; do \
	    echo -n "."; \
	    sleep 1; \
	done
	@echo "\nHugo server is up and running!"


# Stop the Docker container
stop:
	docker stop $(CONTAINER_NAME)

# Remove the Docker container
clean:
	docker rm $(CONTAINER_NAME)

# Force rebuild the Docker image
rebuild:
	docker build --no-cache -t $(IMAGE_NAME) .

# Start an interactive shell inside the Docker container
shell:
	docker exec -it $(CONTAINER_NAME) /bin/bash

# Default action
.PHONY: build init run stop clean rebuild shell