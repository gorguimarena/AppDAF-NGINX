FROM php:8.2-fpm

# Installer Nginx, extensions PHP, Supervisor, Composer
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

# Activer les erreurs PHP
RUN echo "display_errors=On\n\
display_startup_errors=On\n\
error_reporting=E_ALL" > /usr/local/etc/php/conf.d/docker-php-errors.ini

# Créer répertoire de travail
WORKDIR /var/www/html

# Copier les fichiers essentiels
COPY composer.json composer.lock ./

# Installer les dépendances (Render peut aussi le faire si tu veux l’ignorer ici)
RUN composer install --no-dev --optimize-autoloader

# Copier le reste du projet
COPY . .

# Copier séparément la config nginx et supervisord (important pour ne pas qu’elles soient écrasées)
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY ./supervisord.conf /etc/supervisord.conf

# Exposer le port attendu par Render
EXPOSE 80

# Lancer supervisord pour gérer php-fpm et nginx
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
