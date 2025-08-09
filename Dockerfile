# Use official PHP image with Apache
FROM php:7.4-apache

# Install required packages for PHP MySQL connection
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Copy application files to Apache's root directory
COPY index.php /var/www/html/

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Set MySQL environment variables (for linking with DB container)
ENV MYSQL_HOST=mysql-container \
    MYSQL_USER=root \
    MYSQL_PASSWORD=rootpassword \
    MYSQL_DATABASE=studentdb

EXPOSE 80

