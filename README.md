Foundation
==========

Repository for constructing Docker images combining Torch and
TensorFlow, some with cuda support (only on x86 for now). Images found
at
https://hub.docker.com/repository/docker/awsteiner/foundation/general
.

* u26.04_tf_2.21_torch_2.11 (CPU only; 1.50 GB)

  - Ubuntu 26.04
  - gcc 15.2.0
  - Python 3.13.13
  - HDF5 1.14.6/h5py 3.14.0
  - numpy 2.3.4
  - Torch 2.11.0
  - TensorFlow 2.21.0

* cuda_12.8_tf_2.20_torch_2.9_m2 (method 2; 10.16 GB)

  - Ubuntu 24.04
  - gcc 13.3.0
  - Python 3.12.3
  - HDF5 1.14.6/h5py 3.13.0
  - CUDA 12.8.1
  - Torch 2.9.0
  - TensorFlow 2.20.0 (uses CUDA 12.5.1)

* ost_tf_2.21_torch_2.11 (CPU only; 1.95 GB)

  - openSUSE Tumbleweed
  - gcc 15.2.1
  - Python 3.13.13
  - HDF5 1.14.6/h5py 3.13.0
  - Torch 2.11.0
  - TensorFlow 2.21

* arch (CPU only; 2.82 GB)

  - Built on archlinux:latest
  - gcc 16.1.1
  - Python 3.14.6
  - numpy 2.5.1
  - HDF5 2.1.1/h5py 3.16.0
  - Torch 2.13.0
  - TensorFlow 2.21.0

Discussion
----------

* TensorFlow is built with a particular HDF5 version, so we install
  the matching version and ensure h5py uses it. This helps with HDF5
  compatibility issues when constructing code with uses HDF5.

* The ``pip-audit`` Python package is used to help avoid security
  vulnerabilities and included with the images.

* The images include one of two scripts, cuda_check.sh and
  nocuda_check.sh, which are used to verify that pip-audit reports no
  vulnerabilities and TensorFlow, Torch, and/or nvcc work as expected.

* 2/2/26: Warning: the images based on Ubuntu 24.04 (including those
  with CUDA) use user installations of pip and wheel to ensure that
  more recent versions of these packages are used which don't have
  security vulnerabilities as reported by pip-audit.

* 5/7/26: Note that Tensorflow does not yet support Python 3.14, and
  Ubuntu 26.04 does not have an official Python 3.13 package, so the
  Ubuntu 26.04 image uses the DeadSnakes PPA to install Python3.13 in
  a virtual environment.

* 7/14/26: Torch 2.11's package requirements require setuptools<82.0,
  in conflict with PYSEC-2026-3447 which requires setuptools>=83.0.0.
  This image forces setuptools==83.0.0. Let me know if this causes you
  issues.

GPUs and CUDA
-------------

* The GPU images require that the Nvidia drivers and the Nvidia
  container toolkit are already installed on the local hardware.

* CUDA and GPU support is what leads to large image sizes. There may
  be a way to optimize these images to make them smaller.

* 2/24/26: Note that there is currently no official TensorFlow release
  that supports CUDA 13.0 out-of-the-box.

* Method 1 involves adding TensorFlow to a pre-built CUDA/PyTorch
  image. For the base image, I'm using the "devel" rather than the
  "runtime" tag, because the former includes nvcc. (Not currently working.)

* Method 2 is built on a CUDA image instead. Then, PyTorch
  installation involves manually installing all the PyTorch
  dependencies except for the CUDA dependencies already included in
  the CUDA image.

Older images
------------

* u24.04_tf_2.20_torch_2.9 (CPU only; 1.50 GB)

  - Ubuntu 24.04
  - gcc 13.3.0
  - Python 3.12.3
  - HDF5 1.14.6/h5py 3.15.1
  - numpy 2.3.4
  - Torch 2.9.1
  - TensorFlow 2.20.0

Experimental images
-------------------

* cuda_12.8_tf_2.20_torch_2.9_m1 (method 1; 7.95GB - in progress)

  - Ubuntu 24.04
  - gcc 13.3.0
  - Python 3.12.3
  - HDF5 1.14.6/h5py 3.13.0
  - CUDA 13.0
  - Torch 2.10.0
  - TensorFlow 2.20.0 (uses CUDA 12.5.1)

* No other older images are currently supported.