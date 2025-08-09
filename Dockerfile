# Dockerfile
FROM php:8.3.10

# Install system dependencies
RUN apt-get update -y && apt-get install -y openssl zip unzip git libpq-dev

# Install PHP extensions for PostgreSQL
RUN docker-php-ext-install pdo pdo_pgsql

# Install Composer (PHP package manager)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set working directory
WORKDIR /app

# Copy composer files just for caching (optional)
COPY composer.json composer.lock /app/

# Note: Do NOT run `composer install` here

# Copy the rest of the application files (optional if volume mounted)
# COPY . /app

# Expose port 8000
EXPOSE 8000

# Default command can be empty or just sleep, because compose will override
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
