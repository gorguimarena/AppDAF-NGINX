FROM php:8.2-fpm

RUN apt-get update && apt-get install -y \
    nginx \
    supervisor \
    libpq-dev \
    unzip \
    git \
    curl \
    && docker-php-ext-install pdo_pgsql pgsql \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Afficher les erreurs PHP
RUN echo "display_errors=On\n\
display_startup_errors=On\n\
error_reporting=E_ALL" > /usr/local/etc/php/conf.d/docker-php-errors.ini

# Créer le répertoire de travail
WORKDIR /var/www/html

# Copier les fichiers de dépendances uniquement
COPY composer.json composer.lock ./

# Installer les dépendances PHP
RUN composer install --no-dev --optimize-autoloader || true

# Copier tout le reste du projet
COPY . .

# Copier les fichiers de configuration Nginx et Supervisor
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY ./supervisord.conf /etc/supervisord.conf

RUN chown -R www-data:www-data /var/www/html

EXPOSE 80

# Lancer Supervisor qui gère php-fpm + nginx
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
