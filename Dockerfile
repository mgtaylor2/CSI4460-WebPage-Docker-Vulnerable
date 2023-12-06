# Use a minimal base image
FROM httpd:2.4-alpine

# Set environment variables for better security
ENV SERVER_SIGNATURE Off
ENV SERVER_TOKENS Prod

# Copy the HTML and CSS files into the container
COPY ./index.html /usr/local/apache2/htdocs/
COPY ./style.css /usr/local/apache2/htdocs/

# Update and install security updates
RUN apk update && apk upgrade

# Create a new user and group for running the Apache server
# Replace 'apacheuser' with a name of your choice
RUN addgroup -S apacheuser && adduser -S apacheuser -G apacheuser

# Change ownership of the htdocs directory to the new user
RUN chown -R apacheuser:apacheuser /usr/local/apache2/htdocs/

# Change ownership and permissions of the logs directory
# This command needs to be after the creation of apacheuser
RUN mkdir -p /usr/local/apache2/logs/ && chown -R apacheuser:apacheuser /usr/local/apache2/logs/

# Run Apache as non-root user
USER apacheuser

# Expose port 80
EXPOSE 80

# Start the Apache server
CMD ["httpd-foreground"]
