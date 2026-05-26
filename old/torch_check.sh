#!/bin/bash
echo "PATH:"
echo $PATH
echo ""
echo "LD_LIBRARY_PATH:"
echo $LD_LIBRARY_PATH
echo ""
echo "Python version:"
python3 --version
echo ""
echo "pip_audit:"
pip-audit
echo ""
echo "Output of 'nvidia-smi':"
nvidia-smi
echo ""
echo "Checking for nvcc:"
NVCC_CMD="nvcc --version"
if $NVCC_CMD; then
    echo ""
    echo "Torch:"
    python3 -c "import torch; print('Torch version:',torch.__version__);"
    python3 -c "import torch; print('CUDA avail:',torch.cuda.is_available()); print('CUDA version:',torch.version.cuda); print('CUDA built:',torch.backends.cuda.is_built()); print('CUDNN version:',torch.backends.cudnn.version()); print('CUDA device name:',torch.cuda.get_device_name(0))"
else
    echo ""
    echo "Torch:"
    python3 -c "import torch; print('Torch version:',torch.__version__);"
fi
