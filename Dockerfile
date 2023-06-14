# Use PyTorch as the base image
FROM pytorch/pytorch:latest

# Install unzip and cmake
RUN apt-get update && apt-get install -y \
    g++\
    unzip \
    cmake \
    wget  \
    curl

# Download your zip file

WORKDIR /root
RUN wget https://github.com/cbigger/OoDoN/archive/refs/heads/main.zip

# Unzip the file
RUN unzip main.zip && rm main.zip

# Change directory to the unzipped folder (assuming the unzipped folder name is oobabooga_linux, change accordingly if not)
WORKDIR /root/OoDoN-main

RUN bash prep_env.sh > preplogs.txt
RUN tail -n 30 preplogs.txt > runner.txt


EXPOSE 7860

# Add the start command as the default command for the container
CMD ["/bin/bash"]

# CMD ["/bin/bash"]

