cd ${ADF_PATH}/micropython_adf/micropython
git apply ${ADF_PATH}/micropython_adf/mpmake.patch

cd ${ADF_PATH}/micropython_adf/micropython/mpy-cross
CROSS_COMPILE='' make

cd ${ADF_PATH}/micropython_adf/micropython/ports/esp32
make submodules
make -j 8 BOARD=GENERIC_S2
