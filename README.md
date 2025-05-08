Foundation
==========

Repository for constructing Docker images combining nvcc, CUDA, Torch
and TensorFlow on Ubuntu. 

* tf_2.18_torch_2.7 (CPU only; 1.29 GB)

  - Ubuntu 24.04
  - HDF5 1.14.6/h5py 3.13.0
  - numpy 2.0.2
  - Torch 2.7
  - TensorFlow 2.18

* cuda_12.6_tf_2.18_torch_2.7 (method 1; 8.40GB)

  - Ubuntu 22.04
  - HDF5 1.14.6/h5py 3.13.0
  - CUDA 12.6
  - Torch 2.7
  - TensorFlow 2.18

* cuda_12.8_tf_2.18_torch_2.7 (method 2; 9.88GB)

  - Ubuntu 24.04
  - HDF5 1.14.6/h5py 3.13.0
  - CUDA 12.8
  - Torch 2.7
  - TensorFlow 2.18

Discussion
----------

* TensorFlow is built with a particular HDF5 version, so we install
the matching version and ensure h5py uses it.

* The GPU images require that the Nvidia drivers and the Nvidia
container toolkit are already installed on the local hardware.

* CUDA and GPU support is what leads to large image sizes.
There may be a way to optimize these images to make them smaller.

* Method 1 involves adding TensorFlow to a pre-built CUDA/PyTorch
image, which gives slightly smaller images than Method 2. The
downsides are:

  - I don't think Ubuntu 24.04 images are available yet. This requires
    one to rebuild HDF5 from source to create the image (since HDF5
    1.14.6 releases are not pre-built for Ubuntu 22.04).
  - Users of this image are additionally subject to the conda
    licensing requirements.

* Method 2 is built on a CUDA image instead. Then, PyTorch
  installation involves manually installing all the PyTorch
  dependencies except for the CUDA dependencies already included in
  the CUDA image.

* Both of the GPU images include two scripts, tf_check.sh and
  torch_check.sh which are used to verify that TensorFlow and Torch
  work as expected.

