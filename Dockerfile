FROM ubuntu:18.04

#https://qiita.com/yagince/items/deba267f789604643bab
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update --fix-missing && \
    apt-get install -y sudo wget bzip2 ca-certificates curl git vim emacs && \
    apt-get clean && \
    rm -rf /var/lib/apt-get/lists/*
    
# Open3D Installing
RUN (apt-get -y install xorg-dev libglu1-mesa-dev libgl1-mesa-glx || true) && \
    (apt-get install -y libglew-dev || true) && \
    (apt-get install -y libglfw3-dev || true) && \
    (apt-get install -y libjsoncpp-dev || true) && \
    (apt-get install -y libeigen3-dev || true) && \
    (apt-get install -y libpng-dev || true) && \
    (apt-get install -y libpng16-dev || true) && \
    (apt-get install -y python-dev python-tk || true) && \
    (apt-get install -y python3-dev python3-tk || true) && \
    (apt-get install -y python3.7 python3.7-dev || true) && \
    (apt-get install -y python3-distutils || true) && \
    (curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python3.7 get-pip.py) && \
    (apt-get install -y cmake)

RUN cd /opt && \
    git clone --recursive https://github.com/yuki-inaho/Open3D.git && \
    mkdir /opt/Open3D/build

RUN cd /opt/Open3D/build && \
    cmake .. && \
    make -j$(nproc) && \
    make install-pip-package && \
    cd / && rm -rf /opt/Open3D

RUN rm -f /usr/bin/python3 && ln -s /usr/bin/python3.7 /usr/bin/python3 && \
    rm -f /usr/bin/python && ln -s /usr/bin/python3.7 /usr/bin/python && \
    rm -f /usr/local/bin/pip && ln -s /usr/local/bin/pip3.7 /usr/local/bin/pip && \
    rm -f /usr/local/bin/pip3 && ln -s /usr/local/bin/pip3.7 /usr/local/bin/pip3

#RUN echo 'alias python="/usr/bin/python3.7"' >> /root/.bashrc && \
#    echo 'alias pip="/usr/bin/pip3"' >> /root/.bashrc && \
#    source /root/.bashrc

CMD ["/bin/bash"]