# Railway / container web (PHP + Apache). App URL: https://<host>/saas/
FROM php:8.2-apache

RUN docker-php-ext-install pdo_mysql mysqli \
    && a2enmod rewrite \
    && echo "ServerName localhost" >> /etc/apache2/apache2.conf

COPY docker/railway/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY docker/railway/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /var/www/html
COPY . .

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
