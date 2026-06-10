# Use an official lightweight Python image
FROM python:3.11-slim

# Set the working directory inside the container
WORKDIR /app

# Copy our application code into the container
COPY app.py .

# Expose the port our app runs on
EXPOSE 8080

# Command to run the application
CMD ["python", "app.py"]
