#!/bin/bash
echo "pip_audit:"
pip-audit
echo ""
echo -n "TensorFlow import: "
python3 -c "import tensorflow; tf=open('tfv.txt','w'); tf.write(tensorflow.__version__); tf.close()"
echo ""
grep PRETTY_NAME /etc/os-release | cut -c13-40 | tr -d '"'
echo -n "PATH "
echo $PATH
echo -n "LD_LIBRARY_PATH "
echo $LD_LIBRARY_PATH
echo -n "gcc "
gcc --version | head -n 1 | awk '{print $3}' | tr -d ')'
echo -n "Python "
python3 --version | awk '{print $2}'
echo -n "numpy "
python3 -c "import numpy; print(numpy.__version__);"
echo -n "HDF5 "
python3 -c "import h5py; print(h5py.version.hdf5_version)"
echo -n "h5py "
python3 -c "import h5py; print(h5py.__version__);"
echo -n "Torch "
python3 -c "import torch; print(torch.__version__); "
echo -n "TensorFlow "
cat tfv.txt
