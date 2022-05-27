cd ${ADF_PATH}/micropyton_adf/micropython
git apply ${ADF_PATH}/micropyton_adf/mpmake.patch

cd /root/${ADF_PATH}/micropyton_adf/mpy-cross
CROSS_COMPILE='' make

cd /root/${ADF_PATH}/micropyton_adf/ports/esp32
make submodules
make -j 8 BOARD=GENERIC_S2
