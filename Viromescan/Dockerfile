FROM continuumio/miniconda3
LABEL maintainer="pandafake589@gmail.com"


RUN apt-get update
RUN apt-get install gcc make libbz2-dev zlib1g-dev seqtk pigz -y

WORKDIR /

RUN git clone https://github.com/simonerampelli/viromescan.git
#probably useless
RUN mv viromescan viromescan2
RUN conda env create -f viromescan2/viromescan2.yml -p /opt/conda/envs/viromescan

WORKDIR /
COPY ./scripts /scripts