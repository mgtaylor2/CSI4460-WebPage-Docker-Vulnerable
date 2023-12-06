# Use an older version of Apache, which might not include the latest security patches
FROM httpd:2.2

# Disable security enhancements
ENV SERVER_SIGNATURE On
ENV SERVER_TOKENS Full

# Copy the HTML, CSS, and a hypothetical sensitive configuration file into the container
# The sensitive-config.conf is assumed to contain sensitive data which should not be in a Docker image
COPY ./index.html /usr/local/apache2/htdocs/
COPY ./style.css /usr/local/apache2/htdocs/
COPY ./sensitive-config.conf /usr/local/apache2/conf/

# Skip updating and upgrading packages
# This leaves the container vulnerable to known exploits

# Run Apache as the root user (default behavior in this base image)
# This gives the Apache process full control over the container, which is a significant security risk

# Expose port 80
EXPOSE 80

# Start the Apache server with a potentially insecure configuration
CMD ["httpd-foreground"]
