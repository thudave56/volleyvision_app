# Use an official Python runtime as a parent image
FROM python:3.9

# Install dependencies
RUN apt-get update && apt-get install -y libgl1-mesa-glx

# Set the working directory in the container
WORKDIR /app

# Install PostgreSQL client libraries and video codecs
RUN apt-get update && apt-get install -y \
    libpq-dev \
    gcc \
    libx264-dev \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# Copy the requirements file into the container
COPY requirements.txt /app/requirements.txt

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

# Copy the current directory contents into the container at /app
COPY . /app

# Set environment variables
ENV DJANGO_SETTINGS_MODULE=volleyvision.settings
ENV PYTHONUNBUFFERED=1
ENV ROBOFLOW_API_KEY=YOUR_API_KEY

# Expose port 8000 for the Django app
EXPOSE 8000

# Command to run the Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]