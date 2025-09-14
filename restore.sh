echo "=== [1/9] #Enter Maintenance Mode ==="
php artisan down

echo "=== [2/9] #Download the Update ==="
curl -L https://github.com/pterodactyl/panel/releases/latest/download/panel.tar.gz | tar -xzv
chmod -R 755 storage/* bootstrap/cache

echo "=== [4/9] #Update Dependencies ==="
composer install --no-dev --optimize-autoloader

echo "=== [5/9] #Clear Compiled Template Cache ==="
php artisan view:clear
php artisan config:clear

echo "=== [6/9] #Database Updates ==="
php artisan migrate --seed --force

echo "=== [7/9] #Set Permissions ==="
chown -R www-data:www-data /var/www/pterodactyl/*

echo "=== [8/9] #Restarting Queue Workers ==="
php artisan queue:restart

echo "=== [9/9] #Exit Maintenance Mode ==="
php artisan up

echo "=== ALL DONE ==="
echo "=== Thankyou for using this script ==="
