# Build your own MicroPython firmware using docker


## Steps

1. Run the docker container

```sh
docker run -it --rm -v {your micropython repo dir}:/root/esp-adf/micropython_adf/micropython robbietree/esp32-adf-build-docker:0.0.1
```

2. build MicroPython

```sh
cd /root
sh build-esp32.sh
```

3. find the combined firmware bin

```sh
ls /root/esp-adf/micropyton_adf/ports/esp32/build-GENERIC_S2/firmware.bin
```

![build-success](https://raw.githubusercontent.com/unseel/docker-micropython-tools-esp32-adf/master/build-success.png)

4. upload to board

```sh
esptool.py \
    --chip esp32 \
    --port /dev/cu.usbserial-0001 \
    --baud 460800 \
    write_flash --flash_size=detect -fm dio 0 firmware.bin
```

5. test board

## Others

You can refer readme from original [repo](https://github.com/tionebrr/docker-micropython-tools-esp32)
