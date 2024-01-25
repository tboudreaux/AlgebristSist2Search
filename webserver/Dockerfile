# Use Ubuntu as the base image
FROM ubuntu:20.04

# Update and install dependencies
RUN apt-get update
RUN apt-get install -y curl
RUN apt-get install -y libatomic1     # Install libatomic

# Copy the sist2 binary from your local system into the container
COPY ./sist2 /usr/local/bin/sist2

# Make sure the binary is executable
RUN chmod +x /usr/local/bin/sist2

# Copy the startup script
COPY ./runServer.sh /runServer.sh

# Make the script executable
RUN chmod +x /runServer.sh

# Set the script as the entry point
ENTRYPOINT ["/runServer.sh"]

