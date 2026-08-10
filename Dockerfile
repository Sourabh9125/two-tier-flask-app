# Use an official Python runtime as the base image
FROM python:3.12 AS builder

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt .

# install required packages for system
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        gcc=4:14.2.0-1 \
        default-libmysqlclient-dev=1.1.1 \
        pkg-config=1.8.1-4 && \
    pip install --no-cache-dir  --prefix=/install -r requirements.txt && \
    rm -rf /var/lib/apt/lists/*
    

FROM python:3.12-slim

WORKDIR /app

RUN apt-get update && \
    apt-get install -y --no-install-recommends libmariadb3=1:11.8.6-0+deb13u1 && \
    rm -rf /var/lib/apt/lists/*

# Copy the rest of the application code
COPY --from=builder /install /usr/local

COPY . .

# CMD ["python", "app.py"]
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]

