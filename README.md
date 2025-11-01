Foundation
==========

Repository for constructing Docker images combining Torch and
TensorFlow, some with cuda support (only on x86 for now). Images found
at
https://hub.docker.com/repository/docker/awsteiner/foundation/general
.

* u24.04_tf_2.20_torch_2.9 (CPU only; 1.45 GB)

  - Ubuntu 24.04
  - gcc 13.3.0
  - Python 3.12.3
  - HDF5 1.14.6/h5py 3.15.1
  - numpy 2.3.4
  - Torch 2.9
  - TensorFlow 2.20

* cuda_12.8_tf_2.20_torch_2.9_m1 (method 1; 10.39GB)

  - Ubuntu 22.04
  - Python 3.11.14
  - HDF5 1.14.6/h5py 3.13.0
  - CUDA 12.8.1
  - Torch 2.9
  - TensorFlow 2.20.0

* cuda_12.8_tf_2.18_torch_2.7_m2 (method 2; 9.89GB)

  - Ubuntu 24.04
  - Python 3.12.3
  - HDF5 1.14.6/h5py 3.13.0
  - CUDA 12.8.1
  - Torch 2.7
  - TensorFlow 2.18

* ost_tf_2.20_torch_2.9 (CPU only; 1.97 GB)

  - openSUSE Tumbleweed
  - gcc 15.2.1
  - Python 3.12.12
  - HDF5 1.14.6/h5py 3.15.1
  - Torch 2.9.0
  - TensorFlow 2.20

* arch (CPU only; 2.47 GB)

  - Built on archlinux:latest
  - gcc 15.2.1
  - Python 3.13.7
  - HDF5 1.14.6/h5py 3.15.1
  - Torch 2.9.0
  - TensorFlow 2.20

Discussion
----------

* TensorFlow is built with a particular HDF5 version, so we install
  the matching version and ensure h5py uses it. This helps with HDF5
  compatibility issues when constructing code with uses HDF5.

* The images include two scripts, tf_check.sh and torch_check.sh which
  are used to verify that TensorFlow, Torch, and/or nvcc work as expected.

GPUs and CUDA
-------------

* The GPU images require that the Nvidia drivers and the Nvidia
  container toolkit are already installed on the local hardware.

* CUDA and GPU support is what leads to large image sizes. There may
  be a way to optimize these images to make them smaller.

* Method 1 involves adding TensorFlow to a pre-built CUDA/PyTorch
  image, which gives slightly smaller images than Method 2. For the
  base image, I'm using the "devel" rather than the "runtime" tag
  because the former includes nvcc. (The base image is already quite
  large.) The downsides are:

  - They're only available for Ubuntu 22.04. I don't think
    PyTorch/CUDA/Ubuntu 24.04 images are available yet. This method
    requires one to rebuild HDF5 from source to create the image
    (since HDF5 1.14.6 releases are not pre-built for Ubuntu 22.04).
  - Since conda is used in the base image, Users of this image are
    additionally subject to the conda licensing requirements.

* Method 2 is built on a CUDA image instead. Then, PyTorch
  installation involves manually installing all the PyTorch
  dependencies except for the CUDA dependencies already included in
  the CUDA image.

Older images
------------

* u24.04_tf_2.18_torch_2.7 (CPU only; 1.41 GB)

  - Ubuntu 24.04
  - gcc 13.3.0
  - Python 3.12.3
  - HDF5 1.14.6/h5py 3.13.0
  - numpy 2.0.2
  - Torch 2.7
  - TensorFlow 2.18

* cuda_12.6_tf_2.18_torch_2.7_m1 (method 1; 8.41GB)

  - Ubuntu 22.04
  - Python 3.11.12
  - HDF5 1.14.6/h5py 3.13.0
  - CUDA 12.6.3
  - Torch 2.7
  - TensorFlow 2.18.0

* ost_tf_2.19_torch_2.7.1 (CPU only; 1.98 GB)

  - openSUSE Tumbleweed
  - gcc 15.2.0
  - Python 3.12.11
  - HDF5 1.14.6/h5py 3.14.0
  - Torch 2.7.1
  - TensorFlow 2.19

