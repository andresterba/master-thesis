# Evaluation 1: Routing Engine

1. Stop and remove artifacts from earlier tests with `make stop`.

1. Run `make start`

1. Wait for ~1 minute.

1. Start gosdn with `make start-gosdn`.

1. Configure Router interfaces.

    ```sh
    make configure
    ```

1. Set IPs on clients:

    Client 1-1:

    ```sh
    make shell-client-lab-1-1

    ip address add 192.168.0.100/24 dev eth1
    ip route del default
    ip route add default via 192.168.0.1 dev eth1
    exit
    ```


    Client 2-1:

    ```sh
    make shell-client-lab-2-1

    ip address add 192.168.100.100/24 dev eth1
    ip route del default
    ip route add default via 192.168.100.1 dev eth1
    exit
    ```

1. Add the nodes via `gosdnc`.
   The needed password can be found in the logs of the controller.

    ```sh
    ./scripts/add-device-0.sh <password-from-logs>
    ./scripts/add-device-1.sh <password-from-logs>
    ```

1. Start the routing engine with `make start-routing-engine`

1. Configure the link between the network elements.
   Import the provided postman collection `AS-Thesis-Evaluation.postman_collection.json` and replace the `id` of the `sourceNode` with the UUID of `router-0`
   and the `id` of the `targetNode` with the UUID of `router-1`.
   Execute the following to get the UUIDs:

   The needed password can be found in the logs of the controller.

    ```sh
    ./scripts/list-devices.sh <password-from-logs>
    ```

    ```sh
    {
        "timestamp": "1649929667405420000",
        "link": {
            "name": "test",
            "sourceNode": {
                "id": "REPLACE",
                "name": "router-0"
            },
            "targetNode": {
                "id": "REPLACE",
                "name": "router-1"
            },
            "sourcePort": {
                "id": "1fa479e7-d393-4d45-822d-485cc1f05fce",
                "name": "Ethernet1",
                "configuration": {
                    "ip": "10.13.37.1",
                    "prefixLength": "30"
                }
            },
            "targetPort": {
                "id": "1fa479e7-d393-4d45-822d-485cc1f05fc2",
                "name": "Ethernet1",
                "configuration": {
                    "ip": "10.13.37.2",
                    "prefixLength": "30"
                }
            }
        }
    }
    ```

    Then execute the `Routing-Engine-Evaluation` POST request.

1. Ensure the routing-engine did receive the expected events and adjusted the configuration by checking the logs.

1. Configure the routing tables of the devices.

    Configuration of router-0:
    ```sh
    {
        "timestamp": "1649929667405420000",
        "routingTable": {
            "id": "ffa89ed0-cef1-4219-bb19-3c751d5c5c9d",
            "nodeID": "REPLACE",
            "routes": [{
                "id": "ffa89ed0-cef1-4219-bb19-3c751d5c5c9d",
                "targetIPRange": "192.168.100.0/24",
                "nextHopIP": "10.13.37.2",
                "portID": "1fa479e7-d393-4d45-822d-485cc1f05fc2",
                "metric": "1"
            }]
        }
    }
    ```

    Configuration of router-1:
    ```sh
    {
        "timestamp": "1649929667405420000",
        "routingTable": {
            "id": "ffa89ed0-cef1-4219-bb19-3c751d5c5c92",
            "nodeID": "REPLACE",
            "routes": [{
                "id": "ffa89ed0-cef1-4219-bb19-3c751d5c5c92",
                "targetIPRange": "192.168.0.0/24",
                "nextHopIP": "10.13.37.1",
                "portID": "1fa479e7-d393-4d45-822d-485cc1f05fce",
                "metric": "1"
            }]
        }
    }
    ```

    Replace the UUIDs and execute the POST requests `Routing-Engine-Evaluation-Table-0` and `Routing-Engine-Evaluation-Table-1`.

1. Ensure the routing-engine did receive the expected events and adjusted the configuration by checking the logs.

1. Execute `make ping-test-client-lab-1-1-router-0` to ensure client-1-1 can reach router-0.

1. Execute `make ping-test-client-lab-2-1-router-1` to ensure client-2-1 can reach router-1.

1. Execute `make ping-test-client-lab-1-1-client-2-1` to ensure client-1-1 can reach client-2-1.
