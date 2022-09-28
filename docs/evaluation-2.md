# Evaluation 2: Hostname Checker

1. Stop and remove artifacts from earlier tests with `make stop`.

1. Run `make start`

1. Wait for ~1 minute.

1. Start gosdn with `make start-gosdn-with-device-watch`.

1. Add the router 0 via `gosdnc`.
   The needed password can be found in the logs of the controller.

    ```sh
        ./scripts/add-device-0.sh <password-from-logs>
    ```

1. Check the hostname of the router after it is started with `make check-hostname-router-0`
   The result should look like this:

   ```sh
    gnmic -a 172.100.0.2:6030 -u admin -p admin --insecure get --path system/config/hostname
    [
    {
        "source": "172.100.0.2:6030",
        "timestamp": 1664393520944976550,
        "time": "2022-09-28T21:32:00.94497655+02:00",
        "updates": [
        {
            "Path": "system/config/hostname",
            "values": {
            "system/config/hostname": "ceos0"
            }
        }
        ]
    }
    ]
   ```

1. Start the `hostname-checker` application with `make start-hostname-checker`.

1. Adjust the hostname of router 1 with `make adjust-hostname-router-0`

1. The `hostname-checker` will output if it has to adjust the hostname or not:

    ```sh
    Executing Callback:
    [APP] Device-ID: 008cbad6-2f99-4769-8c08-459d999a6a15, Device-Name: router-0
    [APP] Device.Name (router-0) doesn't match Device.Hostname (wrong-name) in model! Updating...
    [APP] Update response: timestamp:1664394182856242682  status:STATUS_OK

    Executing Callback:
    [APP] Device-ID: 008cbad6-2f99-4769-8c08-459d999a6a15, Device-Name: router-0
    [APP] Device.Name (router-0) does match Device.Hostname (router-0) in model! Nothing to do for me...
    ```

1. Execute `make check-hostname-router-0` and validate that the hostname is `router-0`.

    ```sh
    gnmic -a 172.100.0.2:6030 -u admin -p admin --insecure get --path system/config/hostname
    [
    {
        "source": "172.100.0.2:6030",
        "timestamp": 1664394305134814405,
        "time": "2022-09-28T21:45:05.134814405+02:00",
        "updates": [
        {
            "Path": "system/config/hostname",
            "values": {
            "system/config/hostname": "router-0"
            }
        }
        ]
    }
    ]
    ```
