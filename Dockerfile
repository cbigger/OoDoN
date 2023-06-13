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
RUN wget https://github.com/oobabooga/text-generation-webui/releases/download/installers/oobabooga_linux.zip

# Unzip the file
RUN unzip oobabooga_linux.zip && rm oobabooga_linux.zip

# Change directory to the unzipped folder (assuming the unzipped folder name is oobabooga_linux, change accordingly if not)
WORKDIR /root/oobabooga_linux
RUN sed -i '14s/.*/CMD_FLAGS=\"--chat\ --share\"/' webui.py
RUN sed -i '79s/.*/gpuchoice="a"/' webui.py
RUN sed -i '71d;72d;73d;74d;75d;76d;77d;78d;79d' webui.py
RUN sed -i '70s/.*/gpuchoice="a"\ndef install_dependencies():/' webui.py
# Expose port 7860
EXPOSE 7860

# Add the start command as the default command for the container
CMD ["bash", "start_linux.sh"]

# CMD ["/bin/bash"]

