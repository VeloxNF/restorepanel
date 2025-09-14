echo "=== [1/8] #Enter Maintenance Mode ==="
php artisan down

echo "=== [2/8] #Download the Update ==="
curl -L https://github.com/pterodactyl/panel/releases/latest/download/panel.tar.gz | tar -xzv
chmod -R 755 storage/* bootstrap/cache

echo "=== [3/8] #Update Dependencies ==="
composer install --no-dev --optimize-autoloader

echo "=== [4/8] #Clear Compiled Template Cache ==="
php artisan view:clear
php artisan config:clear

echo "=== [5/8] #Database Updates ==="
php artisan migrate --seed --force

echo "=== [6/8] #Set Permissions ==="
chown -R www-data:www-data /var/www/pterodactyl/*

echo "=== [7/8] #Restarting Queue Workers ==="
php artisan queue:restart

echo "=== [8/8] #Exit Maintenance Mode ==="
php artisan up

echo "=== ALL DONE ==="
echo "=== Thankyou for using this script ==="
