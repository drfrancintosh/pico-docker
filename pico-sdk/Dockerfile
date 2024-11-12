# Use an appropriate base image, like Ubuntu or Alpine, or any other.
FROM debian

# Get some missing commands
RUN echo "...Get Some Missing Commands..."
RUN apt-get update
RUN apt-get install -y sudo
RUN apt-get install -y python3
RUN apt-get install -y python3-pip 
RUN apt-get install -y vim
RUN apt-get install -y curl
RUN apt-get install -y indent
RUN apt-get install -y nodejs
RUN apt-get install -y npm
RUN apt-get install -y pkg-config
RUN apt-get install -y minicom
RUN apt-get install -y usbutils


# Copy the script to the container
RUN echo "...copy some install scripts..."
COPY scripts/* /usr/local/bin
COPY scripts/bashrc /home/.bashrc

# Give execution rights on the script
RUN echo "... chmod installed scripts..."
RUN chmod +x /usr/local/bin/*.sh

# install all the RPI SDK
RUN /usr/local/bin/install.sh

# Command to execute the script when the container starts
CMD ["/bin/bash"]