FROM ubuntu:20.04

SHELL ["/bin/bash", "-c"]

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && apt-get install -y vim git wget flex bison gperf python3 python3-pip python3-setuptools cmake ninja-build ccache libffi-dev libssl-dev dfu-util && rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 10
ENV PYTHON2=python
RUN pip3 install -I pyparsing==2.3.1
RUN pip3 install pyserial rshell

RUN cd /root && git clone -b v4.4.1 --recursive https://github.com/espressif/esp-idf.git
WORKDIR /root/esp-idf
RUN ./install.sh && echo 'source /root/esp-idf/export.sh' >> /root/.bashrc

# adf init
RUN cd /root && git clone -b v2.4.1 --recursive https://github.com/espressif/esp-adf.git
ENV ADF_PATH=/root/esp-adf
RUN cd /root/esp-idf && git apply /root/esp-adf/idf_patches/idf_v4.4_freertos.patch
# adf end

# mp init
RUN cd /root/esp-adf/micropython_adf && git clone -b feat-adf --recursive https://github.com/unseel/micropython.git
# mp end

# mp adf patch init
RUN cd /root && git clone https://github.com/unseel/micropython-adf-patch.git
RUN cp -r /root/micropython-adf-patch/audio /root/esp-adf/micropython_adf/micropython/examples/usercmodule/audio

# mp adf patch end

ENV IDF_PATH=/root/esp-idf
ENV CROSS_COMPILE=/root/.espressif/tools/xtensa-esp32-elf/esp-2021r1-8.4.0/xtensa-esp32-elf/bin/xtensa-esp32-elf-
ENV PORT=/dev/ttyESP

COPY build-esp32.sh /root
WORKDIR /root

