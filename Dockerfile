# Use a specific Python version (3.10 or 3.11) to avoid issues with distutils
FROM python:3.10

# Install necessary dependencies, including distutils
RUN apt-get update && apt-get install -y python3-distutils build-essential

# Install Django
RUN pip install django==3.2

# Copy your project files into the container
COPY . .

# Run migrations
RUN python manage.py migrate

# Expose port 8000
EXPOSE 8000

# Command to run the server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]




