# Pull base image first
FROM python:3.13.4-slim-bullseye

# Build args for UID and GID
ARG USER_ID=1000
ARG GROUP_ID=1000

# Create group and user with the build args before switching user
RUN groupadd -g ${GROUP_ID} devgroup && \
    useradd -u ${USER_ID} -g devgroup -m devuser

# Set environment variables
ENV PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /code

# Install dependencies as root (before switching user)
COPY ./requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files (owned by root initially)
COPY . .

# Run collectstatic during build
#RUN python manage.py collectstatic --noinput

# Change ownership of /code to devuser
#RUN chown -R devuser:devgroup /code

# Switch to the non-root user
#USER devuser

# By default, the container will start here, e.g.:
# CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
