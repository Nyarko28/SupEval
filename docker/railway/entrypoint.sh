#!/bin/sh
set -e
PORT="${PORT:-80}"

# Railway injects PORT; Apache must listen on the same port as <VirtualHost>
sed -i "s/^Listen .*/Listen ${PORT}/" /etc/apache2/ports.conf 2>/dev/null || true
sed -i "s|<VirtualHost \*:80>|<VirtualHost *:${PORT}>|" /etc/apache2/sites-available/000-default.conf

exec apache2-foreground
