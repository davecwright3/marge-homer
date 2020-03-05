FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04
MAINTAINER David C. Wright <davecwright@knights.ucf.edu>

# from conda/miniconda3, modified
RUN apt-get -qq update && apt-get -qq -y install curl bzip2 gcc mpich make swig git build-essential \
    && curl -sSL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -bfp /usr/local \
    && rm -rf /tmp/miniconda.sh \
    && conda install -y python=3 \
    && conda update conda \
    && pip install numpy \
    && apt-get -qq -y remove curl bzip2 \
    && apt-get -qq -y autoremove \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /var/log/dpkg.log \
    && conda clean --all --yes

ENV PATH /opt/conda/bin:$PATH

RUN mkdir /code

RUN git clone --recursive https://github.com/exosports/MARGE.git /code/marge
RUN git clone --recursive https://github.com/exosports/HOMER.git /code/homer

ENV PATH /code/homer:$PATH
ENV PATH /code/marge:$PATH

RUN /bin/bash -c 'conda env create -f /code/marge/environment.yml'
RUN echo "source activate marge" >> /etc/bash.bashrc
RUN /bin/bash -c 'source activate marge'

RUN cd /code/marge && make bart
RUN cd /code/homer && make mccubed

ENV PATH /opt/conda/envs/marge/bin:$PATH
