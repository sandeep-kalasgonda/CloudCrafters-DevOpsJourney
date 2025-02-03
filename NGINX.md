# Nginx Installation and Configuration on Ubuntu 24.04

## Overview

Nginx is a high-performance web server that can also be used as a reverse proxy, load balancer, and HTTP cache. This guide will walk you through the steps to install and configure Nginx on Ubuntu 24.04.

## Prerequisites

- An Ubuntu 24.04 server instance.
- A non-root user with `sudo` privileges.
- Internet connectivity.

## Installation Steps

### Step 1: Update Package Index

Before installing any packages, update the package index to ensure you have the latest information:

```bash

sudo apt update

```

### Step 2: Install Nginx

Install Nginx using the following command:

```bash

sudo apt install nginx -y

```

### Step 3: Start and Enable Nginx

After installation, start the Nginx service and enable it to start at boot:

```bash

sudo systemctl start nginx
sudo systemctl enable nginx

```

### Step 4: Verify Installation

Check the status of the Nginx service to ensure it is running:

```bash

sudo systemctl status nginx

```

You should see an output indicating that Nginx is active (running).

### Step 5: Configure Firewall (UFW)

If you are using UFW (Uncomplicated Firewall), allow HTTP and HTTPS traffic:

```bash

sudo ufw allow 'Nginx Full'

```

To check if the firewall rules were applied successfully, use:

```bash

sudo ufw status

```

## Configuration Steps

### Step 6: Configure Server Block

1. **Create a Directory for Your Website**:

```bash

cd /var/www
sudo mkdir tutorial
cd tutorial
sudo "${EDITOR:-vi}" index.html

```

Paste the following to the index.html file:

```bash

<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>Hello, Nginx!</title>
</head>
<body>
    <h1>Hello, Nginx!</h1>
    <p>We have just configured our Nginx web server on Ubuntu Server!</p>
</body>
</html>

```

2. **Setting up virtual host**:

To set up virtual host, we need to create file in /etc/nginx/sites-enabled/ directory.

For this tutorial, we will make our site available on 81 port, not the standard 80 port. You can change it if you would like to.

```bash

cd /etc/nginx/sites-enabled
sudo "${EDITOR:-vi}" tutorial

```

```bash

server {
       listen 81;
       listen [::]:81;

       server_name example.ubuntu.com;

       root /var/www/tutorial;
       index index.html;

       location / {
               try_files $uri $uri/ =404;
       }
}

```

root is a directory where we have placed our .html file. index is used to specify file available when visiting root directory of site. server_name can be anything you want, because you aren’t pointing it to any real domain by now.

3. **Activating virtual host and testing results**:

To make our site working, simply restart Nginx service.

```bash

sudo service nginx restart

```

Let’s check if everything works as it should. Open our newly created site in web browser. Remember that we used :81 port.

