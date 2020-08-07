FROM alpine:latest

# Install the packages we need.
RUN apk add tzdata

# Add scripts
ADD showdate.sh /
RUN chmod +x /showdate.sh

#Run Script
CMD ["/showdate.sh"]

