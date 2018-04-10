build:
	docker build -t opstree/ansible .

build-cserver:
	docker build -t opstree/ansible:cserver -f Dockerfile.cserver .

build-tserver:
	docker build -t opstree/ansible:tserver -f Dockerfile.tserver .

build-all:
	make build
	make build-cserver
	make build-tserver

run-zabbix-server:
	docker rm -f zabbix || true
	docker run -p 8090:80 -h zabbix  --name zabbix  -itd opstree/ansible:tserver

run-web-az-a:
	docker rm -f webaza || true
	docker run -h webaza --name webaza --link zabbix:zabbix -itd opstree/ansible:tserver

run-web-az-b:
	docker rm -f webazb || true
	docker run -h webazb --name webazb --link zabbix:zabbix -itd opstree/ansible:tserver

run-app-az-a:
	docker rm -f appaza || true
	docker run -h appaza --name appaza --link zabbix:zabbix -itd opstree/ansible:tserver

run-app-az-b:
	docker rm -f appazb || true
	docker run -h appazb --name appazb --link zabbix:zabbix -itd opstree/ansible:tserver

run-db-az-a:
	docker rm -f dbaza || true
	docker run -h dbaza --name dbaza --link zabbix:zabbix -itd opstree/ansible:tserver

run-db-az-b:
	docker rm -f dbazb || true
	docker run -h dbazb --name dbazb --link zabbix:zabbix -itd opstree/ansible:tserver

run-inventory-db:
	docker rm -f inventory-db || true
	docker run --name inventory-db -d -e MYSQL_ROOT_PASSWORD=root -d mysql:5.6
	docker cp data/inventory.sql inventory-db:/tmp/inventory.sql
	sleep 10s
	docker exec inventory-db /bin/bash -c 'mysql -u root -proot < /tmp/inventory.sql'

run-control-server:
	docker rm -f cserver || true
	docker run -h cserver -v ${PWD}/data/inventory.py:/etc/ansible/inventory.py --name cserver --link zabbix:zabbix --link inventory-db:inventory-db --link webaza:webaza --link webazb:webazb --link appaza:appaza --link appazb:appazb --link dbaza:dbaza --link dbazb:dbazb -itd opstree/ansible:cserver /bin/bash

run-all:
	make run-zabbix-server
	make run-web-az-a
	make run-web-az-b
	make run-app-az-a
	make run-app-az-b
	make run-db-az-a
	make run-db-az-b
	make run-inventory-db
	make run-control-server

start-lab:
	make build-all
	make run-all
