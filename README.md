# Build your own MicroPython firmware using docker


## Steps

1. Run the docker container

```sh
docker run -it --rm -v {your micropython repo dir}:/root/esp-adf/micropyton_adf robbietree/esp32-build-docker:0.0.5
```

2. build MicroPython

```sh
cd /root
sh build-esp32.sh
```

3. find the combined firmware bin

```sh
ls /root/esp-adf/micropyton_adf/ports/esp32/build-GENERIC_C3/firmware.bin
```

![build-success](https://raw.githubusercontent.com/unseel/docker-micropython-tools-esp32/master/build-success.png)

4. upload to board

```sh
esptool.py \
    --chip esp32c3 \
    --port /dev/cu.usbserial-1420 \
    --baud 460800 \
    write_flash --flash_size=detect -fm dio 0 firmware.bin
```

5. test board

## Others

You can refer readme from original [repo](https://github.com/tionebrr/docker-micropython-tools-esp32)
