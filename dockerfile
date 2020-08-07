FROM ubuntu:bionic

# Install the packages we need.
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata

# Add scripts
ADD showdate.sh /
RUN chmod +x /showdate.sh

#Run Script
CMD ["/showdate.sh"]

