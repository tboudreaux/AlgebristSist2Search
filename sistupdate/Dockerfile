# Use Ubuntu as the base image
FROM ubuntu:20.04

# Update and install dependencies
RUN apt-get update
RUN apt-get install -y curl
RUN apt-get install -y libatomic1     # Install libatomic
RUN apt-get install -y tzdata
RUN apt-get install -y cron

ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Copy the sist2 binary from your local system into the container
COPY ./sist2 /usr/local/bin/sist2

# Make sure the binary is executable
RUN chmod +x /usr/local/bin/sist2
RUN echo "0 0 * * * /runUpdate.sh >> /var/log/cron.log 2>&1" > /etc/cron.d/my-cron-job
RUN chmod 0644 /etc/cron.d/my-cron-job

# Copy the startup script
COPY ./runUpdate.sh /runUpdate.sh

# Make the script executable
RUN chmod +x /runUpdate.sh
CMD cron -f
