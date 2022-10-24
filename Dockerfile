FROM ubuntu:20.04

SHELL ["/bin/bash", "-c"]

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && apt-get install -y git wget flex bison gperf python3 python3-pip python3-setuptools cmake ninja-build ccache libffi-dev libssl-dev dfu-util && rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 10
ENV PYTHON2=python
RUN pip3 install -I pyparsing==2.3.1
RUN pip3 install pyserial rshell

RUN cd /root && git clone -b v3.3 --recursive https://github.com/espressif/esp-idf.git
RUN cd /root && wget https://dl.espressif.com/dl/xtensa-esp32-elf-linux64-1.22.0-97-gc752ad5-5.2.0.tar.gz \
&& tar -xzf xtensa-esp32-elf-linux64-1.22.0-97-gc752ad5-5.2.0.tar.gz && rm xtensa-esp32-elf-linux64-1.22.0-97-gc752ad5-5.2.0.tar.gz

# WORKDIR /root/esp-idf

# RUN ./install.sh
RUN echo 'export PATH="/root/xtensa-esp32-elf/bin:$PATH"' >> /root/.bashrc

# adf init
RUN cd /root && git clone -b v2.1 --recursive https://github.com/espressif/esp-adf.git
ENV ADF_PATH=/root/esp-adf
RUN cd /root/esp-idf && git apply /root/esp-adf/idf_patches/idf_v3.3_freertos.patch
# adf end

# mp init
RUN cd /root/esp-adf/micropython_adf && git clone https://github.com/micropython/micropython.git \
&& cd /root/esp-adf/micropython_adf/micropython && git reset --hard 1f371947309c5ea6023b6d9065415697cbc75578 \
&& git -c submodule."lib/tinyusb".update=none submodule update --init --recursive \
&& git apply /root/esp-adf/micropython_adf/mpmake.patch
# mp end

ENV IDF_PATH=/root/esp-idf
# ENV CROSS_COMPILE=/root/.espressif/tools/xtensa-esp32-elf/esp-2021r1-8.4.0/xtensa-esp32-elf/bin/xtensa-esp32-elf-
ENV PORT=/dev/ttyESP

COPY build-esp32.sh /root
WORKDIR /root

