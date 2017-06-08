FROM nvidia/cuda:8.0-cudnn6-devel

MAINTAINER Andrew Stepanov <karn9050@gmail.com>

RUN apt-get update && apt-get install -y --no-install-recommends \
	vim \
	gfortran \
	libblas-dev \
	liblapack-dev \
	libffi-dev \
	libssl-dev \
	ca-certificates \
	curl \
	wget \
	libsqlite3-dev \
	libbz2-dev

RUN wget https://www.python.org/ftp/python/3.6.1/Python-3.6.1.tgz
RUN tar xvf Python-3.6.1.tgz
WORKDIR Python-3.6.1
RUN ./configure
RUN make -j
RUN make install
RUN curl --silent --show-error --retry 5 https://bootstrap.pypa.io/get-pip.py | python3

RUN pip3 install --upgrade pip
RUN pip3 install --upgrade requests
RUN pip3 install requests[security]

RUN pip3 install ipython \
		 jupyter \
		 python_speech_features \
		 scipy \
		 cython \
		 numpy \
		 typing \
		 matplotlib \
		 pandas

RUN pip3 install scikit-image \
		 sklearn \
		 seaborn

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8  

COPY jupyter_notebook_config.py /root/.jupyter/
COPY run_jupyter.sh /

WORKDIR /
RUN apt-get install -y git

RUN apt-get update

# Installing bazel
RUN apt-get install -y openjdk-8-jdk

RUN echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list
RUN curl https://bazel.build/bazel-release.pub.gpg | apt-key add -

RUN apt-get update
RUN apt-get install -y bazel


# Building Tensorflow master form source for Python 3.6
WORKDIR /
RUN git clone https://github.com/tensorflow/tensorflow
WORKDIR /tensorflow
RUN git checkout r1.1

ENV CC_OPT_FLAGS "-mavx -mavx2 -mfma -mfpmath=both -msse4.2 -msse4.1"
ENV TF_ENABLE_XLA 1
ENV TF_NEED_CUDA 1
ENV TF_CUDNN_VERSION 6
ENV TF_CUDA_COMPUTE_CAPABILITIES "3.5,5.2,6.1"
ENV PYTHON_BIN_PATH /usr/local/bin/python3.6
ENV PYTHON_LIB_PATH /usr/local/lib/python3.6/site-packages
ENV TF_NEED_JEMALLOC 1
ENV TF_NEED_GCP 0
ENV TF_NEED_HDFS 1
ENV TF_NEED_OPENCL 0
ENV GCC_HOST_COMPILER_PATH /usr/bin/gcc
ENV TF_CUDA_VERSION 8.0
ENV CUDA_TOOLKIT_PATH /usr/local/cuda
ENV CUDNN_INSTALL_PATH /usr/local/cuda
ENV TF_NEED_VERBS 0
ENV TF_CUDA_CLANG 0

RUN ln -s /usr/lib/x86_64-linux-gnu/libcudnn.so /usr/local/cuda/lib64
RUN ln -s /usr/lib/x86_64-linux-gnu/libcudnn.so.6 /usr/local/cuda/lib64
RUN ln -s /usr/lib/x86_64-linux-gnu/libcudnn.so.6.0.20 /usr/local/cuda/lib64
RUN ln -s /usr/lib/x86_64-linux-gnu/libcudnn_static.a /usr/local/cuda/lib64
RUN ln -s /usr/lib/x86_64-linux-gnu/libcudnn_static_v6.a /usr/local/cuda/lib64

RUN ln -s /usr/include/x86_64-linux-gnu/cudnn_v6.h /usr/local/cuda/include

RUN ./configure

RUN apt-get install -y python

RUN bazel build --config=opt --config=cuda //tensorflow/tools/pip_package:build_pip_package
RUN ./bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg
RUN pip3 install /tmp/tensorflow_pkg/tensorflow-*.whl

ENV LD_LIBRARY_PATH /usr/local/cuda/extras/CUPTI/lib64:$LD_LIBRARY_PATH
RUN ln -s /usr/local/cuda/lib64/stubs/libcuda.so /usr/local/cuda/lib64/stubs/libcuda.so.1

WORKDIR /root

# TensorBoard
EXPOSE 6006
# IPython
EXPOSE 8888

CMD "/run_jupyter.sh" --ip=0.0.0.0 --allow-root
