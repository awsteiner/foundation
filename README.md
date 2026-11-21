Foundation
==========

Repository for constructing Docker images combining Torch and
TensorFlow, some with cuda support (only on x86 for now). Images found
at
https://hub.docker.com/repository/docker/awsteiner/foundation/general
.

* u26.04_tf_2.22_torch_2.14 (CPU only; 1.46 GB)

  - Ubuntu 26.04
  - gcc 15.2.0
  - Python 3.14.4
  - HDF5 1.14.6/h5py 3.15.1
  - numpy 2.3.4
  - Torch 2.14.1
  - TensorFlow 2.22.0-rc0

* cuda_13.4_tf_2.22_torch_2.15_m2 (method 2; 8.31 GB)

  - Ubuntu 26.04
  - Python 3.14
  - HDF5 1.14.6/h5py 3.15.1
  - CUDA 13.4.3
  - Torch 2.15.0
  - TensorFlow 2.22.0-rc1

* ost_tf_2.21_torch_2.14 (CPU only; 2.00 GB)

  - openSUSE Tumbleweed
  - gcc 16.2.1
  - Python 3.13.16
  - numpy 2.5.4
  - HDF5 1.14.6/h5py 3.13.0
  - Torch 2.14.1
  - TensorFlow 2.21

* arch (CPU only; 2.90 GB)

  - Built on archlinux:latest
  - gcc 16.2.1
  - Python 3.14.9
  - numpy 2.5.4
  - HDF5 2.2.0/h5py 3.16.0
  - Torch 2.15.0
  - TensorFlow 2.21.0

Discussion
----------

* The ``pip-audit`` Python package is used to help avoid security
  vulnerabilities and included with the images.

* The images include one of two scripts, cuda_check.sh and
  nocuda_check.sh, which are used to verify that pip-audit reports no
  vulnerabilities and TensorFlow, Torch, and/or nvcc work as expected.

GPUs and CUDA
-------------

* The GPU images require that the Nvidia drivers and the Nvidia
  container toolkit are already installed on the local hardware.

* Method 1 involves adding TensorFlow to a pre-built CUDA/PyTorch
  image. For the base image, I'm using the "devel" rather than the
  "runtime" tag, because the former includes nvcc. (Not currently
  working.)

* Method 2 is built on a CUDA image instead. Then, PyTorch
  installation involves manually installing all the PyTorch
  dependencies except for the CUDA dependencies already included in
  the CUDA image.

Older images (not updated)
--------------------------

* u24.04_tf_2.20_torch_2.9 (CPU only; 1.50 GB)

  - Ubuntu 24.04
  - gcc 13.3.0
  - Python 3.12.3
  - HDF5 1.14.6/h5py 3.15.1
  - numpy 2.3.4
  - Torch 2.9.1
  - TensorFlow 2.20.0

* cuda_12.8_tf_2.22_torch_2.11_m2 (method 2; 10.71 GB)

  - Ubuntu 24.04.1
  - gcc 13.3.0
  - Python 3.12.3
  - numpy 2.5.4
  - HDF5 1.14.6/h5py 3.13.0
  - CUDA 12.8.1
  - Torch 2.11.0
  - TensorFlow 2.22.0-rc0 (uses CUDA 12.5.1)

* cuda_13.0_tf_2.22_torch_2.14_m2 (method 2; not yet built)

  - Ubuntu 24.04
  - Python 3.12.3
  - HDF5 1.14.6/h5py 3.13.0
  - CUDA 13.0.3
  - Torch 2.14.1 (cu130; the newest Torch with a CUDA 13.0 build)
  - TensorFlow 2.22.0-rc1 (tensorflow-cuda13 package)

* cuda_13.0_tf_2.22_torch_2.14_m1 (method 1; not yet built)

  - Built on pytorch/pytorch:2.14.1-cuda13.0-cudnn9-devel
  - HDF5 1.14.6/h5py 3.13.0
  - Torch 2.14.1
  - TensorFlow 2.22.0-rc1 (tensorflow-cuda13 package)

* cuda_12.8_tf_2.20_torch_2.9_m1 (method 1; 7.95GB - in progress)

  - Ubuntu 24.04
  - gcc 13.3.0
  - Python 3.12.3
  - HDF5 1.14.6/h5py 3.13.0
  - CUDA 13.0
  - Torch 2.10.0
  - TensorFlow 2.20.0 (uses CUDA 12.5.1)

