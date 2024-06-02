FROM continuumio/miniconda3
LABEL maintainer="pandafake589@gmail.com"

WORKDIR /

RUN git clone https://github.com/simonerampelli/viromescan.git
#probably useless
RUN mv viromescan viromescan2
RUN conda env create -f viromescan2/viromescan2.yml -p /opt/conda/envs/viromescan