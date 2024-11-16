# Stage 1: Build stage (use a larger base image to install dependencies)
FROM python:3.9-alpine AS build

# Set the working directory
WORKDIR /app

# Install required dependencies (e.g., build tools)
RUN apk add --no-cache build-base

# Install Flask directly (no requirements.txt)
RUN pip install --no-cache-dir flask==2.0.1

# Stage 2: Final stage (use the minimal base image)
FROM python:3.9-alpine

# Set the working directory in the container
WORKDIR /app

# Copy installed Python dependencies from the build stage
COPY --from=build /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages

# Copy the application files into the container
COPY . /app

# Expose port 80 (the port Flask will run on)
EXPOSE 80

# Define the command to run the app
CMD ["python", "app.py"]
