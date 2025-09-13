echo "=== [1/7] Hapus cache & dependency lama ==="
rm -rf node_modules package-lock.json yarn.lock

echo "=== [2/7] Download ulang panel (latest) ==="
curl -L https://github.com/pterodactyl/panel/releases/latest/download/panel.tar.gz

echo "=== [3/7] Ekstrak panel ==="
tar -xzvf panel.tar.gz
chmod -R 755 storage/* bootstrap/cache
chown -R www-data:www-data /var/www/pterodactyl

echo "=== [4/7] Install ulang dependency PHP & NodeJS ==="
composer install --no-dev --optimize-autoloader

echo "=== [5/7] Build ulang frontend ==="
npm run build:production

echo "=== [6/7] Clear cache Laravel ==="
php artisan view:clear
php artisan config:clear
php artisan cache:clear

echo "=== [7/7] Restart all service ==="
systemctl restart nginx
systemctl restart php8.3-fpm

echo "=== Berhasil! Panel telah di restore ke default... ==="
