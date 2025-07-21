FROM php:8.2-fpm

# Installer nginx, php extensions, composer et supervisord
RUN apt-get update && apt-get install -y \
    nginx \
    supervisor \
    libpq-dev \
    unzip \
    git \
    curl \
    && docker-php-ext-install pdo_pgsql pgsql \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Activer les erreurs PHP
RUN echo "display_errors=On\n\
display_startup_errors=On\n\
error_reporting=E_ALL" > /usr/local/etc/php/conf.d/docker-php-errors.ini

# Installer Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copier configuration Nginx
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf

# Copier configuration supervisord
COPY ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Copier le code de l'application
WORKDIR /var/www/html
COPY . /var/www/html

# Exposer le port HTTP
EXPOSE 80

# Lancer nginx + php-fpm via supervisor
CMD ["/usr/bin/supervisord", "-n"]
