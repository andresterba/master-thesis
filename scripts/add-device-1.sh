if [ $# -eq 0 ]
  then
    echo 'you need to provide the password for the admin user'
    exit 1
fi

./binaries/gosdnc login --controller 127.0.0.1:55055 --u admin --p $1
./binaries/gosdnc pnd use 5f20f34b-cbd0-4511-9ddc-c50cf6a3b49d
./binaries/gosdnc device create -a 172.100.0.3:6030 -u admin -p admin --name="router-1"
./binaries/gosdnc device list
