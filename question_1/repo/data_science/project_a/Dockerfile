FROM python:3
# Set the working directory inside the container
WORKDIR /app
#
COPY ../../../repo/local_packages/ ./local_packages/
# Copy the requirements file and install dependencies
RUN pip install ./../../repo/local_packages/
# Copy the Python script into the container
COPY main.py .
# Run the Python script when the container starts
CMD ["python", "main.py"]