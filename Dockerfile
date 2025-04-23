FROM wordpress:php8.3-apache

# This Dockerfile provides a basic setup for a custom WordPress image.
# It starts with the official WordPress image and allows for some common customizations.

# You can uncomment and modify the following sections as needed.

# ------------------------------------------------------------------------------
# Install additional PHP extensions
# ------------------------------------------------------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip \
    unzip \
  && docker-php-ext-configure gd --with-freetype --with-jpeg \ 
  && docker-php-ext-install -j "$(nproc)" gd mysqli pdo pdo_mysql

# Example: Install other PHP extensions (e.g., curl, xmlrpc)
# RUN docker-php-ext-install -j "$(nproc)" curl xmlrpc

# ------------------------------------------------------------------------------
# Install system-level dependencies (if required by your plugins/themes)
# ------------------------------------------------------------------------------
# Example: Install ImageMagick
# RUN apt-get update && apt-get install -y --no-install-recommends libmagickwand-dev
# RUN pecl install imagick
# RUN docker-php-ext-enable imagick
#

# ------------------------------------------------------------------------------
# Copy custom WordPress configuration (optional)
# If you have a specific wp-config.php, you can copy it here.
# However, it's generally recommended to configure database details via
# environment variables in your docker-compose.yaml file.
# ------------------------------------------------------------------------------
# COPY wp-config.php /usr/src/wordpress/

# ------------------------------------------------------------------------------
# Copy custom themes and plugins (optional)
# If you want to include specific themes or plugins directly in the image.
# ------------------------------------------------------------------------------
# COPY themes/my-theme /usr/src/wordpress/wp-content/themes/my-theme
# COPY plugins/my-plugin /usr/src/wordpress/wp-content/plugins/my-plugin

# ------------------------------------------------------------------------------
# Set working directory (optional, defaults to /var/www/html)
# ------------------------------------------------------------------------------
# WORKDIR /var/www/html

# ------------------------------------------------------------------------------
# Expose WordPress port (already exposed by the base image)
# ------------------------------------------------------------------------------
# EXPOSE 80

# ------------------------------------------------------------------------------
# Define the command to run WordPress (already the default in the base image)
# ------------------------------------------------------------------------------
# CMD ["apache2-foreground"]

# ------------------------------------------------------------------------------
# Instructions on how to use this Dockerfile:
# 1. Save this content as 'Dockerfile' in an empty directory.
# 2. Create 'themes' and 'plugins' subdirectories if you intend to copy custom
#    themes or plugins. Place your theme and plugin files in these directories.
# 3. Build the Docker image using:
#    docker build -t my-wordpress .
# 4. Run the Docker container, linking it to a MySQL database (see docker-compose
#    example in previous responses for a more complete setup). For a basic run
#    (not recommended for production as it doesn't handle database):
#    docker run -p 80:80 my-wordpress
# ------------------------------------------------------------------------------