FROM standy/tensorflow:r1.0-pip

RUN mkdir /neuralmonkey

WORKDIR /neuralmonkey

RUN git clone https://github.com/standy66/neuralmonkey .

RUN pip3 install -r requirements-gpu.txt

WORKDIR /root


