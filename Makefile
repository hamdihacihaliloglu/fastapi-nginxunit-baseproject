build:
	docker-compose up -d --build --remove-orphans

up:
	docker-compose up -d

down:
	docker-compose down