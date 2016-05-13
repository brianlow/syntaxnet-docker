FROM ubuntu:15.10

MAINTAINER Brian Low <brian.low22@gmail.com>

RUN apt-get update && apt-get install -y \
        build-essential \
        curl \
        g++ \
        git \
        libfreetype6-dev \
        libpng12-dev \
        libzmq3-dev \
        openjdk-8-jdk \
        pkg-config \
        python-dev \
        python-numpy \
        python-pip \
        software-properties-common \
        swig \
        unzip \
        zip \
        zlib1g-dev \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN update-ca-certificates -f

# Set up Bazel.

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
ENV BAZEL_VERSION 0.2.2
WORKDIR /
RUN mkdir /bazel && \
    cd /bazel && \
    curl -fSsL -O https://github.com/bazelbuild/bazel/releases/download/$BAZEL_VERSION/bazel-$BAZEL_VERSION-installer-linux-x86_64.sh && \
    curl -fSsL -o /bazel/LICENSE.txt https://raw.githubusercontent.com/bazelbuild/bazel/master/LICENSE.txt && \
    chmod +x bazel-*.sh && \
    ./bazel-$BAZEL_VERSION-installer-linux-x86_64.sh && \
    cd / && \
    rm -f /bazel/bazel-$BAZEL_VERSION-installer-linux-x86_64.sh


# Syntaxnet dependencies

RUN pip install -U protobuf==3.0.0b2
RUN pip install asciitree

# Download and build Syntaxnet

RUN git clone --recursive https://github.com/tensorflow/models.git /root/models
RUN cd /root/models/syntaxnet/tensorflow && echo | ./configure
RUN cd /root/models/syntaxnet && bazel test syntaxnet/... util/utf8/...

WORKDIR /root/models/syntaxnet/

CMD /root/models/syntaxnet/syntaxnet/demo.sh

