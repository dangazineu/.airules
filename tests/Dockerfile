# Dockerfile for running .airules tests
#
# This Dockerfile creates a clean, isolated environment to test the
# install.sh script.
#

# Use a lightweight base image with bash pre-installed.
FROM bash:5.2

# Set the working directory inside the container.
WORKDIR /app

# Copy the entire project into the container's working directory.
# This includes the install.sh script, the rules/, and the tests/.
COPY . .

# Make the scripts executable.
RUN chmod +x /app/install.sh && \
    chmod +x /app/tests/tests.sh

# The command to run when the container starts.
CMD ["/bin/bash"]


