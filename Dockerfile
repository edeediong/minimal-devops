# Base image
FROM python:3.9-slim

EXPOSE 5100

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file to the container
COPY requirements.txt .

# Install the Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code to the container
COPY hello_world.py /app/

# Start the Flask application
CMD ["python3","hello_world.py"]
