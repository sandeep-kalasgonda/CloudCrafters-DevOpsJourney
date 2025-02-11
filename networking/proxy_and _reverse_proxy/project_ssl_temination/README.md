# Reverse Proxy with Nginx and SSL (Without Domain)

## Introduction
This document provides a step-by-step guide on setting up a reverse proxy using Nginx without a domain name. A reverse proxy is an intermediary server that forwards client requests to backend servers, improving security, load balancing, and performance. In this setup, we will configure a reverse proxy to handle HTTPS traffic and distribute requests to multiple backend servers.

## Overview
We will set up a **Reverse Proxy with Nginx and SSL** without using a domain name. The architecture consists of:

- **Reverse Proxy VM (192.168.5.140)** → Handles HTTPS
- **Backend Server 1 (192.168.5.141)** → Serves a simple Nginx webpage
- **Backend Server 2 (192.168.5.142)** → Serves another Nginx webpage

---

## 1️⃣ Backend Server Configuration (192.168.5.141 & 192.168.5.142)

### Step 1: Install Nginx on Both Backend Servers
Run these commands on **both** backend servers:

```bash
sudo apt update && sudo apt install nginx -y
```

### Step 2: Modify the Default Nginx Page on Each Backend Server

#### On Backend Server 1 (192.168.5.141)
```bash
echo "<h1>Welcome to Backend Server 1</h1>" | sudo tee /var/www/html/index.html
```

#### On Backend Server 2 (192.168.5.142)
```bash
echo "<h1>Welcome to Backend Server 2</h1>" | sudo tee /var/www/html/index.html
```

### Step 3: Allow Nginx in Firewall (Optional)
If UFW firewall is enabled, allow HTTP traffic:

```bash
sudo ufw allow 'Nginx Full'
```

### Step 4: Restart Nginx
```bash
sudo systemctl restart nginx
```

### Step 5: Test the Backend Servers
From your **Reverse Proxy VM (192.168.5.140)**, test the backends:

```bash
curl http://192.168.5.141
curl http://192.168.5.142
```

✅ **Backend servers are ready!**

---

## 2️⃣ Reverse Proxy VM Configuration (192.168.5.140)

### Step 1: Install Nginx
```bash
sudo apt update && sudo apt install nginx -y
```

### Step 2: Generate a Self-Signed SSL Certificate
```bash
sudo mkdir /etc/nginx/ssl
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
 -keyout /etc/nginx/ssl/selfsigned.key \
 -out /etc/nginx/ssl/selfsigned.crt
```

🔹 **What these commands do:**
- `sudo mkdir /etc/nginx/ssl` → Creates a directory for SSL files.
- `openssl req -x509 -nodes -days 365 -newkey rsa:2048 ...` → Creates a self-signed SSL certificate (valid for 1 year) with a 2048-bit RSA key.
  - When prompted, enter details like **country, state, city, and hostname (use IP: 192.168.5.140)**.

### Step 3: Configure Nginx as a Reverse Proxy
Create a new configuration file:

```bash
sudo nano /etc/nginx/sites-available/reverse-proxy
```

Add the following:

```nginx
# Redirect HTTP to HTTPS
server {
    listen 80;
    server_name 192.168.5.140;
    return 301 https://$host$request_uri;
}

# Reverse Proxy for HTTPS
server {
    listen 443 ssl;
    server_name 192.168.5.140;

    ssl_certificate /etc/nginx/ssl/selfsigned.crt;
    ssl_certificate_key /etc/nginx/ssl/selfsigned.key;

    location / {
        proxy_pass http://backend_servers;
        proxy_set_header X-Forwarded-Proto https;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}

# Define Backend Servers
upstream backend_servers {
    server 192.168.5.141:80;
    server 192.168.5.142:80;
}
```

🔹 **Explanation of the commands:**
- `listen 80;` → Listens for HTTP traffic on port 80.
- `server_name 192.168.5.140;` → Defines the server’s hostname/IP.
- `return 301 https://$host$request_uri;` → Redirects all HTTP requests to HTTPS.
- `listen 443 ssl;` → Listens for HTTPS traffic on port 443.
- `ssl_certificate` and `ssl_certificate_key` → Specifies the SSL certificate and key paths.
- `proxy_pass http://backend_servers;` → Forwards client requests to backend servers.
- `proxy_set_header` → Passes necessary headers to backend servers for logging and security.

### Step 4: Enable the Reverse Proxy Configuration
```bash
sudo ln -s /etc/nginx/sites-available/reverse-proxy /etc/nginx/sites-enabled/
```
🔹 **What this does:**
- Creates a symbolic link for the configuration file in the active Nginx directory.

### Step 5: Remove Default Nginx Configuration (If Needed)
```bash
sudo rm /etc/nginx/sites-enabled/default
```
🔹 **Why?**
- This prevents conflicts with the default Nginx configuration.

### Step 6: Restart Nginx and Test
```bash
sudo nginx -t  # Test config for errors
sudo systemctl restart nginx
```
🔹 **What these commands do:**
- `nginx -t` → Tests the Nginx configuration for syntax errors.
- `systemctl restart nginx` → Restarts Nginx to apply changes.

---

## 3️⃣ Testing the Reverse Proxy

### Test HTTP → Should Redirect to HTTPS
```bash
curl -I http://192.168.5.140
```
**Expected Output:**
```
HTTP/1.1 301 Moved Permanently
Location: https://192.168.5.140/
```

### Test HTTPS → Should Return Backend Response
```bash
curl -k https://192.168.5.140
```
**Expected Output:**
```
<h1>Welcome to Backend Server 1</h1>
OR
<h1>Welcome to Backend Server 2</h1>
```

🔹 **Why `-k`?**
- `-k` **ignores SSL certificate warnings** (since we’re using a self-signed cert).

---

## Summary
- created the SSL certificate without domain-name
- configured the proxy server for the SSL termination fuction for the nginx
- And made the http connection into the https connection using the nginx-proxy 
---
