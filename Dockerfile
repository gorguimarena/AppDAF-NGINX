FROM php:8.2-fpm

# Installer Nginx
RUN apt-get update && apt-get install -y nginx libpq-dev unzip git curl \
    && docker-php-ext-install pdo_pgsql pgsql \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN echo "display_errors=On\n\
display_startup_errors=On\n\
error_reporting=E_ALL" > /usr/local/etc/php/conf.d/docker-php-errors.ini

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copier configuration nginx
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf

# Copier code source
WORKDIR /var/www/html
COPY . /var/www/html

# Configurer permissions (optionnel)
RUN chown -R www-data:www-data /var/www/html

# Supprimer le demon de nginx au démarrage
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Lancer nginx et php-fpm via supervisord (pour lancer les deux processus)
RUN apt-get install -y supervisor

COPY ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80

CMD ["/usr/bin/supervisord", "-n"]

