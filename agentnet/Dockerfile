FROM standy/lasagne

MAINTAINER Andrew Stepanov <karn9050@gmail.com>

RUN apt-get install -y cmake
RUN apt-get install -y zlib1g-dev

RUN pip3 install https://github.com/yandexdataschool/AgentNet/archive/master.zip
RUN mkdir ~/gym && cd ~/gym && git clone https://github.com/openai/gym.git && \
cd gym && pip3 install -e .[atari]
