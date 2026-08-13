FROM php:8.2-apache

# Install PDO MySQL extension required for MySQL database connectivity
RUN docker-php-ext-install pdo pdo_mysql mysqli


# Copy application code into the Apache document root
COPY . /var/www/html/

# Set proper ownership and permissions for the www-data user
RUN chown -R www-data:www-data /var/www/html \
    && find /var/www/html -type d -exec chmod 755 {} \; \
    && find /var/www/html -type f -exec chmod 644 {} \;

EXPOSE 80
