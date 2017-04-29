FROM nvidia/cuda:8.0-cudnn5-devel

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

RUN wget https://www.python.org/ftp/python/3.6.0/Python-3.6.0.tgz
RUN tar xvf Python-3.6.0.tgz
WORKDIR Python-3.6.0
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
		 pandas \
		 mpld3 \
		 ipywidgets
RUN jupyter nbextension enable --py widgetsnbextension

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
RUN git clone https://github.com/google/protobuf.git
WORKDIR /protobuf
RUN apt-get install -y unzip libtool autoconf
RUN ./autogen.sh
RUN CXXFLAGS="-fPIC -g -O2" ./configure
RUN make -j
ENV PROTOC /protobuf/src/protoc
WORKDIR /protobuf/python

# Installing Tensorflow 1.0.0 for Python 3.6
RUN pip3 install --upgrade tensorflow-gpu==1.1.0


RUN python3 setup.py bdist_wheel --cpp_implementation --compile_static_extension
RUN pip3 install -U --force-reinstall dist/*
RUN rm -rf dist/*

ENV LD_LIBRARY_PATH /usr/local/cuda/extras/CUPTI/lib64:$LD_LIBRARY_PATH

WORKDIR /root

# TensorBoard
EXPOSE 6006
# IPython
EXPOSE 8888


CMD "/run_jupyter.sh" --ip=0.0.0.0
