# Use official Python image
FROM python:3.9

# Set working directory
WORKDIR /app

# Copy files to container
COPY . /app

# Install dependencies
RUN pip install flask

# Expose port 5000
EXPOSE 5001

# Run application
CMD ["python", "app.py"]
