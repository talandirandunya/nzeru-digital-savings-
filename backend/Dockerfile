# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set work directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    postgresql-client \
    build-essential \
    libpq-dev \
    sed \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copy project
COPY . /app/

# Fix line endings (CRLF -> LF) and make executable
RUN sed -i 's/\r$//' /app/entrypoint.sh && \
    chmod +x /app/entrypoint.sh && \
    mkdir -p /app/staticfiles


# Create a non-privileged user and switch to it
RUN adduser --disabled-password --no-create-home django-user && \
    chown -R django-user:django-user /app
USER django-user

# Expose the port (Railway will assign $PORT at runtime)
EXPOSE 8000

# Use the entrypoint script to run migrations and start the server
CMD ["/app/entrypoint.sh"]