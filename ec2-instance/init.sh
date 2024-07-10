#!/bin/bash

echo "*** Installing apache"
sudo yum update -y
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
echo "*** Completed Installing apache"

echo "*** Configure firewall"
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --reload

sudo chmod 777 /var/www/html

cat <<EOF >>/var/www/html/index.html
<!DOCTYPE html>
<html>
	<head>
		<title>Apache Web Server</title>
	</head>
	<body>
		<h1>Apache Web Server</h1>
		<p>This is a simple HTML web page.</p>
	</body>
</html>
EOF
