# Use a lightweight base image
FROM alpine:latest

# Set a working directory
WORKDIR /app

# Copy a simple script into the container
COPY hello.sh .

# Make the script executable
RUN chmod +x hello.sh

# Define the command to run when the container starts
CMD ["./hello.sh"]