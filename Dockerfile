############################################################
# Dockerfile to build Python WSGI Application Containers
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu

# File Author / Maintainer
MAINTAINER Benedikt Riedel

# Add the application resources URL
#RUN echo "deb http://archive.ubuntu.com/ubuntu/ $(lsb_release -sc) main universe" >> /etc/apt/sources.list

# Update the sources list
RUN apt-get update

# Install basic applications
RUN apt-get install -y tar git curl nano wget dialog net-tools build-essential

# Install Python and Basic Python Tools
RUN apt-get install -y python python-dev python-distribute python-pip

# Install Firebrick Modules
RUN apt-get install -y tgt dcfldd lshw wget 

# Copy the application folder inside the container
ADD /UCD-Python /UCD-Python

RUN wget http://de.archive.ubuntu.com/ubuntu/pool/universe/d/dcfldd/dcfldd_1.3.4.1-2.1_amd64.deb

RUN dpkg -i dcfldd_1.3.4.1-2.1_amd64.deb

# Get the Firebrick
RUN git clone https://github.com/benno16/UCD-Python.git

# Get pip to download and install requirements:
RUN pip install -r /UCD-Python/requirements.txt

# Expose ports
EXPOSE 80

# Set the default directory where CMD will execute
WORKDIR /UCD-Python

# Start Services...
CMD tgtd

# Set the default command to execute    
# when creating a new container
# i.e. using CherryPy to serve the application
CMD python server.py
