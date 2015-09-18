echo "==> Create project directory..."
cd /vagrant/web
mkdir project
cd project

echo "==> Get wp-cli..."

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

echo "==> Downlaod core wordpress..."

php wp-cli.phar core download --version=4.2

echo "==> Set config..."
php wp-cli.phar core config --dbname=wordpress --dbuser=user --dbpass=user

echo "==> Install wordpress"
php wp-cli.phar core install --url=http://gr-wordpress.app --title=WordPress --admin_user=admin --admin_password=password --admin_email=rkarkut@getresponse.com

echo "==> Load WooCommerce plugin..."
php wp-cli.phar plugin install woocommerce --activate
echo "==> Load BuddyPress plugin..."
php wp-cli.phar plugin install buddypress --activate

echo "==> Activate GetResponse plugin..."
mv /vagrant/www/wp-getresponse-integration /vagrant/www/project/wp-content/plugins/wp-getresponse-integration
php wp-cli.phar plugin activate wp-getresponse-integration

echo "==> Done..."