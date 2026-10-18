FROM php:8.2-cli-alpine

# Install system dependencies and PHP extensions
RUN apk add --no-cache \
    curl \
    git \
    libpng-dev \
    libxml2-dev \
    libzip-dev \
    zip \
    unzip \
    sqlite-dev \
    oniguruma-dev \
    icu-dev \
    && docker-php-ext-install pdo pdo_mysql pdo_sqlite mbstring bcmath xml curl zip intl

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

# Copy composer files first for optimal caching
COPY composer.json composer.lock ./

# Install production dependencies without running scripts
RUN composer install --no-dev --no-scripts --no-autoloader --prefer-dist

# Copy application source code
COPY . .

# Generate optimized autoload files
RUN composer dump-autoload --optimize --no-dev

# Set permissions for storage and cache directories
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache \
    && chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

EXPOSE 8000

CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
