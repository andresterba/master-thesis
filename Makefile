start:
	docker build -t thesis-evaluation-clients .
	mkdir ./volumes/mongo-db
	sudo containerlab deploy --topo evaluation.yaml

stop:
	sudo containerlab destroy --topo evaluation.yaml --cleanup --all
	sudo rm -rf ./volumes/mongo-db

graph:
	sudo containerlab graph --topo evaluation.yaml

start-gosdn:
	./binaries/gosdn --config ./configs/gosdn.toml -s insecure

start-gosdn-with-device-watch:
	./binaries/gosdn-with-device-watch --config ./configs/gosdn.toml -s insecure

start-routing-engine:
	./binaries/arista-routing-engine

start-hostname-checker:
	./binaries/hostname-checker

configure:
	gnmic -a 172.100.0.2:6030 -u admin -p admin --insecure set --update-path 'interfaces/interface[name=Ethernet2]' --update-file configs/router-0-interfaces.json
	gnmic -a 172.100.0.3:6030 -u admin -p admin --insecure set --update-path 'interfaces/interface[name=Ethernet2]' --update-file configs/router-1-interfaces.json

add-router-0:
	docker exec -it clab-thesis_evaluation-gosdnc help

add-router-1:
	docker exec -it clab-thesis_evaluation-gosdnc help

adjust-hostname-router-0:
	gnmic -a 172.100.0.2:6030 -u admin -p admin --insecure set --update-path /system/config/hostname --update-value "wrong-name"

check-hostname-router-0:
	gnmic -a 172.100.0.2:6030 -u admin -p admin --insecure get --path system/config/hostname

reset-router-0:
	sudo containerlab deploy --topo evaluation.yaml --reconfigure

shell-ceos0:
	docker exec -it clab-thesis_evaluation-ceos0 bash

shell-ceos1:
	docker exec -it clab-thesis_evaluation-ceos1 bash

cli-ceos0:
	docker exec -it lab-thesis_evaluation-ceos0 Cli

cli-ceos1:
	docker exec -it lab-thesis_evaluation-ceos1 Cli

shell-client-lab-1-1:
	docker exec -it clab-thesis_evaluation-client-lab-1-1 bash

shell-client-lab-1-2:
	docker exec -it clab-thesis_evaluation-client-lab-1-2 bash

shell-client-lab-2-1:
	docker exec -it clab-thesis_evaluation-client-lab-2-1 bash

shell-client-lab-2-2:
	docker exec -it clab-thesis_evaluation-client-lab-2-2 bash

ping-test-client-lab-1-1-router-0:
	docker exec -it clab-thesis_evaluation-client-lab-1-1 ping 10.13.37.1

ping-test-client-lab-2-1-router-1:
	docker exec -it clab-thesis_evaluation-client-lab-2-1 ping 10.13.37.2

ping-test-client-lab-1-1-client-2-1:
	docker exec -it clab-thesis_evaluation-client-lab-1-1 ping 192.168.100.100
