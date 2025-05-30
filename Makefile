VERSION=0.0.1
OS_ARCH=linux_amd64

default: 
	docker compose -f docker-compose.local_deploy.yml build

build:
	docker compose -f docker-compose.local_deploy.yml build

up:	
	docker compose -f docker-compose.local_deploy.yml up

control_rebuild:
	docker compose -f docker-compose.local_deploy.yml up -d --force-recreate --no-deps --build control

control_build:
	 docker compose -f docker-compose.local_deploy.yml build --no-cache control

csc_rebuild:
	docker compose -f docker-compose.local_deploy.yml up -d --force-recreate --no-deps --build csc

flan_rebuild:
	docker compose -f docker-compose.local_deploy.yml up -d --force-recreate --no-deps --build flan

dog_agent_ex_rebuild:
	docker compose -f docker-compose.local_deploy.yml up -d --force-recreate --no-deps --build dog_agent_ex

dog_agent_ex_restart:
	docker compose -f docker-compose.local_deploy.yml restart dog_agent_ex

dog_agent_ex_build_tar:
	cd dog_agent_ex; docker build --output=. --target=tar -f Dockerfile.local_deploy .

dog_agent_rebuild:
	BUILDKIT_PROGRESS=plain docker compose -f docker-compose.local_deploy.yml up -d --force-recreate --no-deps --build dog_agent

dog_agent_build_tar:
	cd dog_agent; docker build --output=. --target=tar -f Dockerfile.local_deploy .

dog_agent_restart:
	docker compose -f docker-compose.local_deploy.yml restart dog_agent

dog_agent_shell:
	docker exec -it dog-agent /bin/bash

dog_park_rebuild:
	docker compose -f docker-compose.local_deploy.yml up -d --force-recreate --no-deps --build dog_park

dog_park_build_tar-local:
	cd dog_park; docker build --no-cache --output=. --target=tar -f Dockerfile --build-arg REACT_APP_DOG_API_ENV="local" --build-arg REACT_APP_DOG_API_HOST="http://dog" .

dog_park_build_tar-pro:
	cd dog_park; docker build --no-cache --output=. --target=tar -f Dockerfile --build-arg REACT_APP_DOG_API_ENV="pro" --build-arg REACT_APP_DOG_API_HOST="https://dog-pro.relaydev.sh" .

dog_trainer_build:
	 docker compose -f docker-compose.local_deploy.yml build dog_trainer --no-cache

dog_trainer_build_tar:
	cd dog_trainer; docker build --output=. --target=tar --no-cache -f Dockerfile.local_deploy .

dog_trainer_console:
	docker exec -it dog-trainer /opt/dog_trainer/bin/dog_trainer remote_console

dog_trainer_rebuild:
	docker compose -f docker-compose.local_deploy.yml up -d --force-recreate --no-deps --build dog_trainer

dog_trainer_restart:
	docker compose -f docker-compose.local_deploy.yml restart dog_trainer #restart to recreate dog db

dog_trainer_shell:
	docker exec -it dog-trainer /bin/bash

kong_rebuild:
	docker compose -f docker-compose.local_deploy.yml up -d --force-recreate --no-deps --build kong

rabbitmq_build:
	 docker compose -f docker-compose.local_deploy.yml build rabbitmq --no-cache

rabbitmq_rebuild:
	docker compose -f docker-compose.local_deploy.yml up -d --force-recreate --no-deps --build rabbitmq

rethinkdb_rebuild:
	docker compose -f docker-compose.local_deploy.yml up -d --force-recreate --no-deps --build rethinkdb

rethinkdb_rm:
	docker container stop rethinkdb
	docker container rm rethinkdb
	docker volume prune -f

rethinkdb_delete_data: rethinkdb_rm rethinkdb_rebuild dog_trainer_restart control_rebuild dog_agent_restart dog_agent_ex_restart
