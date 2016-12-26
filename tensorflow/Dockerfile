FROM nvidia/cuda:8.0-cudnn5-devel

MAINTAINER Andrew Stepanov <karn9050@gmail.com>

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        git \
        libfreetype6-dev \
        libpng12-dev \
        libzmq3-dev \
        pkg-config \
        python \
        python-dev \
        python-numpy \
        python-pip \
        rsync \
        software-properties-common \
        swig \
        unzip \
        zip \
        zlib1g-dev \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN curl -fSsL -O https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    rm get-pip.py

RUN pip --no-cache-dir install \
        ipykernel \
        jupyter \
        matplotlib \
        && \
    python -m ipykernel.kernelspec

# Set up our notebook config.
COPY jupyter_notebook_config.py /root/.jupyter/

# Jupyter has issues with being run directly:
#   https://github.com/ipython/ipython/issues/7062
# We just add a little wrapper script.
COPY run_jupyter.sh /

# Set up Bazel.

# We need to add a custom PPA to pick up JDK8, since trusty doesn't
# have an openjdk8 backport.  openjdk-r is maintained by a reliable contributor:
# Matthias Klose (https://launchpad.net/~doko).  It will do until
# we either update the base image beyond 14.04 or openjdk-8 is
# finally backported to trusty; see e.g.
#   https://bugs.launchpad.net/trusty-backports/+bug/1368094
RUN add-apt-repository -y ppa:openjdk-r/ppa && \
    apt-get update && \
    apt-get install -y --no-install-recommends openjdk-8-jdk openjdk-8-jre-headless && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Running bazel inside a `docker build` command causes trouble, cf:
#   https://github.com/bazelbuild/bazel/issues/134
# The easiest solution is to set up a bazelrc file forcing --batch.
RUN echo "startup --batch" >>/root/.bazelrc
# Similarly, we need to workaround sandboxing issues:
#   https://github.com/bazelbuild/bazel/issues/418
RUN echo "build --spawn_strategy=standalone --genrule_strategy=standalone" \
    >>/root/.bazelrc
ENV BAZELRC /root/.bazelrc
# Install the most recent bazel release.
ENV BAZEL_VERSION 0.3.1
WORKDIR /
RUN mkdir /bazel && \
    cd /bazel && \
    curl -fSsL -O https://github.com/bazelbuild/bazel/releases/download/$BAZEL_VERSION/bazel-$BAZEL_VERSION-installer-linux-x86_64.sh && \
    curl -fSsL -o /bazel/LICENSE.txt https://raw.githubusercontent.com/bazelbuild/bazel/master/LICENSE.txt && \
    chmod +x bazel-*.sh && \
    ./bazel-$BAZEL_VERSION-installer-linux-x86_64.sh && \
    cd / && \
    rm -f /bazel/bazel-$BAZEL_VERSION-installer-linux-x86_64.sh

# Download and build TensorFlow.

RUN git clone -b r0.11 --recursive --recurse-submodules https://github.com/tensorflow/tensorflow.git && \
    cd tensorflow && \
    git checkout r0.11
WORKDIR /tensorflow

# Configure the build for our CUDA configuration.
ENV CUDA_TOOLKIT_PATH /usr/local/cuda
ENV CUDNN_INSTALL_PATH /usr/local/cuda
ENV TF_NEED_CUDA 1

RUN apt-get update && apt-get install -y python3 python3-pip python3-dev

RUN TF_CUDA_COMPUTE_CAPABILITIES=6.1 ./configure && \
    bazel build -c opt --config=cuda tensorflow/tools/pip_package:build_pip_package && \
    bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/pip && \
    pip install --upgrade /tmp/pip/tensorflow-*.whl

RUN apt-get install python3-numpy

RUN TF_CUDA_COMPUTE_CAPABILITIES=6.1 PYTHON_BIN_PATH=/usr/bin/python3 ./configure && \
    bazel build -c opt --config=cuda tensorflow/tools/pip_package:build_pip_package && \
    bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/pip3 && \
    pip3 install --upgrade /tmp/pip3/tensorflow-*.whl

WORKDIR /root

# Set up CUDA variables
ENV CUDA_PATH /usr/local/cuda

# TensorBoard
EXPOSE 6006
# IPython
EXPOSE 8888

RUN apt-get update && apt-get install -y vim libblas-dev liblapack-dev gfortran

RUN pip install python_speech_features scipy

RUN pip3 install python_speech_features scipy

RUN pip install typing

RUN pip3 install typing

RUN pip3 install ipython jupyter

RUN ipython kernel install

RUN ipython3 kernel install

RUN pip install cython

RUN pip3 install cython

RUN pip install pandas

RUN pip3 install pandas

RUN pip install matplotlib

RUN pip3 install matplotlib

RUN pip install scikit-image


RUN pip3 install --upgrade pip

RUN pip3 install scikit-image

RUN pip install --upgrade pip
RUN apt-get install -y libffi-dev libssl-dev
RUN pip install --upgrade requests
RUN pip install requests[security]

RUN pip install sklearn
RUN pip3 install sklearn
RUN pip install seaborn
RUN pip3 install seaborn

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8  

CMD "/run_jupyter.sh"
