FROM standy/tensorflow:r1.0-pip

RUN mkdir /tf-seq2seq

WORKDIR /tf-seq2seq

RUN git clone https://github.com/google/seq2seq.git .

RUN pip3 install -e .

WORKDIR /root

RUN git clone https://github.com/rsennrich/subword-nmt /subword-nmt

