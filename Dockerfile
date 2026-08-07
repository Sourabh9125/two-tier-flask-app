# Use an official Python runtime as the base image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt .

# install required packages for system
RUN apt-get update \
    && apt-get install gcc  -y --no-install-recommends \
        gcc=4:12.2.0-3 \
        default-libmysqlclient-dev=1.1.0 \
        pkg-config=0.29.2 && \
    pip install --no-cache-dir mysqlclient && \
    pip install --no-cache-dir --requirement requirements.txt && \
    rm -rf /var/lib/apt/lists/*
    

# # Copy the requirements file into the container
# COPY requirements.txt .

# Install app dependencies
# RUN pip install mysqlclient \
#     pip install --requirement requirements.txt

# Copy the rest of the application code
COPY . .

# Specify the command to run your application
CMD ["python", "app.py"]

