FROM nvidia/cuda:8.0-cudnn5-devel

RUN apt-get update && apt-get install -y python3 python3-dev python3-pip \
                                         gfortran cmake

RUN pip3 install numpy
RUN pip3 install --upgrade pip
RUN pip3 install cython
RUN pip3 install pandas
RUN pip3 install jupyter
RUN pip3 install matplotlib
RUN pip3 install https://github.com/Theano/Theano/archive/master.zip
RUN pip3 install https://github.com/Lasagne/Lasagne/archive/master.zip
RUN pip3 install nose

RUN apt-get install -y vim nano wget curl git

COPY jupyter_notebook_config.py /root/.jupyter/
COPY run_jupyter.sh /

RUN mkdir /root/notebooks
WORKDIR /root/notebooks

COPY .theanorc /root/.theanorc


CMD "/run_jupyter.sh"


