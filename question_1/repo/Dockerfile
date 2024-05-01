FROM python:3
# Set the working directory inside the container
WORKDIR /app
# Copy the local_packages directory into the container
COPY local_packages /app/local_packages
# Install the custom package using pip
RUN pip install ./local_packages