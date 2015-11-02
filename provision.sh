sudo apt-get update
sudo apt-get install -y apache2
sudo apt-get install -y git
sudo apt-get install -y curl
curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo rm -rf /var/www
sudo ln -fs /vagrant /var/www
echo "Generated symbolic link"
