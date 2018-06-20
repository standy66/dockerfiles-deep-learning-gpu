FROM ubuntu:18.04

RUN apt update && apt install -y curl libexpat1 libssl1.0.0 build-essential gcc
RUN curl -L -s http://buildbot.pypy.org/nightly/py3.6/pypy-c-jit-latest-linux64.tar.bz2 | \
    tar xvjf - -C /opt && mv /opt/pypy* /opt/pypy/ && cd /opt/pypy/bin && \
    ln -s pypy3 python && ./python -m ensurepip && ./python -m pip install -U pip
ENV PATH="/opt/pypy/bin:${PATH}"

RUN pip install grpcio grpcio_tools

CMD ["/opt/pypy/bin/python"]
