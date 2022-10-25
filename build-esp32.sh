cd ${ADF_PATH}/micropython_adf/micropython

cd ${ADF_PATH}/micropython_adf/micropython/mpy-cross
CROSS_COMPILE='' make

cd ${ADF_PATH}/micropython_adf/micropython/ports/esp32
make submodules
make USER_C_MODULES=/root/esp-adf/micropython_adf/micropython/examples/usercmodule/micropython.cmake -j 8 BOARD=GENERIC_SPIRAM
