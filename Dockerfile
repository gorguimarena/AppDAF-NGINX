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

RUN echo "display_errors=On\n\
display_startup_errors=On\n\
error_reporting=E_ALL" > /usr/local/etc/php/conf.d/docker-php-errors.ini

WORKDIR /var/www/html

COPY composer.json composer.lock ./

RUN composer install --no-dev --optimize-autoloader || true

COPY . .

# Remplacer la config nginx par celle modifiée (avec pid dans /tmp)

COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY ./supervisord.conf /etc/supervisord.conf

RUN chown -R www-data:www-data /var/www/html

RUN mkdir -p /var/log/php-fpm && chown -R www-data:www-data /var/log/php-fpm

EXPOSE 80

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
