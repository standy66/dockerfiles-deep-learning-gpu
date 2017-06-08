FROM standy/tensorflow:master-intel

RUN mkdir /opencv
WORKDIR /opencv
RUN git clone https://github.com/opencv/opencv.git .
RUN git checkout tags/3.2.0

RUN apt-get install -y ffmpeg

RUN mkdir /opencv/build
WORKDIR /opencv/build

RUN apt-get install -y cmake pkg-config

RUN apt-get install -y libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
RUN apt-get install -y libxvidcore-dev libx264-dev

RUN apt-get install -y libjpeg8-dev libtiff5-dev libjasper-dev libpng12-dev
RUN apt-get install -y libavresample-dev

RUN cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D WITH_CUDA=OFF \
    -D INSTALL_PYTHON_EXAMPLES=OFF \
    -D INSTALL_C_EXAMPLES=OFF \
    -D PYTHON_EXECUTABLE=/usr/local/bin/python3.6 \
    -D BUILD_EXAMPLES=OFF ..

RUN make -j
RUN make install

WORKDIR /root/notebooks
