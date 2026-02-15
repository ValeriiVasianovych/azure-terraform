#!/bin/bash

# PUBLIC_IP=$(curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//')
PRIVATE_IP=$(hostname -i)

set -e

echo "Updating package list..."
apt-get update -y

echo "Installing Nginx..."
apt-get install -y nginx

echo "Enabling Nginx to start on boot..."
systemctl enable nginx

echo "Starting Nginx service..."
systemctl start nginx

echo "Checking Nginx status..."
systemctl status nginx --no-pager

cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
    <title>VMSS Nginx Page</title>
</head>
<body>
    <h1>Nginx is Installed Successfully</h1>
    <p><strong>Private IP:</strong> $PRIVATE_IP</p>
</body>
</html>
EOF

echo "Nginx installation completed successfully."