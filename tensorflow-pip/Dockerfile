FROM nvidia/cuda:8.0-cudnn5-devel

MAINTAINER Andrew Stepanov <karn9050@gmail.com>

RUN apt-get update && apt-get install -y --no-install-recommends \
        python \
	python-dev \
        python3 \
	python3-dev \
	vim \
	gfortran \
	libblas-dev \
	liblapack-dev \
	libffi-dev \
	libssl-dev \
	ca-certificates \
	curl

RUN curl --silent --show-error --retry 5 https://bootstrap.pypa.io/get-pip.py | python3
RUN curl --silent --show-error --retry 5 https://bootstrap.pypa.io/get-pip.py | python

RUN pip install --upgrade pip
RUN pip install --upgrade requests
RUN pip install requests[security]

RUN pip3 install --upgrade pip
RUN pip3 install --upgrade requests
RUN pip3 install requests[security]

RUN pip install ipython \
		jupyter \
		python_speech_features \
		scipy \
		cython \
		numpy \
		typing \
		matplotlib \
		pandas \
		scikit-image \
		sklearn \
		seaborn

RUN pip3 install ipython \
		jupyter \
		python_speech_features \
		scipy \
		cython \
		numpy \
		typing \
		matplotlib \
		pandas \
		scikit-image \
		sklearn \
		seaborn 

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8  

RUN ipython kernel install
RUN ipython3 kernel install

COPY jupyter_notebook_config.py /root/.jupyter/
COPY run_jupyter.sh /

WORKDIR /root
# TensorBoard
EXPOSE 6006
# IPython
EXPOSE 8888

# Installing Tensorflow for Python 3.4
RUN pip3 install https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-0.12.0-cp34-cp34m-linux_x86_64.whl

# Installing Tensorflow for Python 2.7
RUN pip install https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-0.12.0-cp27-none-linux_x86_64.whl 

CMD "/run_jupyter.sh"
