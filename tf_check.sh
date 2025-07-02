#!/bin/bash
echo "PATH:"
echo $PATH
echo ""
echo "LD_LIBRARY_PATH:"
echo $LD_LIBRARY_PATH
echo ""
echo "gcc version:"
gcc --version
echo ""
echo "Python version:"
python3 --version
echo ""
echo ""
echo "HDF5 version:"
python3 -c "import h5py; print(h5py.__version__); print(h5py.version.hdf5_version)"
echo "Output of 'nvidia-smi':"
nvidia-smi
echo ""
echo "Checking for nvcc:"
NVCC_CMD="nvcc --version"
if $NVCC_CMD; then
    echo ""
    echo "TensorFlow:"
    python3 -c "import tensorflow as tf; print(' '); print('tensorflow version:',tf.__version__); print('TF GPU devices:',tf.config.list_physical_devices('GPU')); print('TF build info:',tf.sysconfig.get_build_info())"
else
    echo ""
    echo "TensorFlow:"
    python3 -c "import tensorflow as tf; print(' '); print('tensorflow version:',tf.__version__); print('TF build info:',tf.sysconfig.get_build_info())"
fi
