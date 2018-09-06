.PHONY: run build

build:
	docker build --rm -t puckel/docker-airflow .

run:
	#docker run -d -p 8080:8080 --net=host puckel/docker-airflow
	docker-compose -f docker-compose-LocalExecutor.yml up -d
	@echo airflow running on http://localhost:8080

kill:
	@echo "Killing docker-airflow containers"
	docker kill $(shell docker ps -q --filter ancestor=puckel/docker-airflow)
    @echo "Killing postgres containers"
	docker kill $(shell docker ps -q --filter ancestor=postgres:9.6)

tty:
	docker exec -it $(shell docker ps -q --filter ancestor=puckel/docker-airflow) /bin/bash
