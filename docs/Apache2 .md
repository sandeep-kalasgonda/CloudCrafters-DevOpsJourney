# Setting Up Apache Web Server and Creating a Website

## Prerequisites
Ensure you have:
- An Ubuntu server environment
- Sudo privileges

## Step 1: Installing Apache
To install Apache, follow these steps:

1. Update the package index:
   ```bash
   sudo apt update
   ```
2. Install the `apache2` package:
   ```bash
   sudo apt install apache2
   ```

After the installation is complete, test it by typing your server's IP address in a web browser. If Apache is installed correctly, you should see the default Apache welcome page.

---

## Step 2: Creating Your Own Website

By default, Apache serves a basic site from `/var/www/html`. To set up your custom site:

### 2.1 Create a New Directory for Your Site
Run the following commands to create a directory for your new website:
```bash
sudo mkdir /var/www/gci/
cd /var/www/gci/
sudo nano index.html
```

Paste the following HTML content into the `index.html` file:
```html
<html>
<head>
  <title>Ubuntu rocks!</title>
</head>
<body>
  <p>I'm running this website on an Ubuntu Server server!</p>
</body>
</html>
```

Save and exit the file.

---

## Step 3: Configuring the VirtualHost File

### 3.1 Create a VirtualHost Configuration File
Navigate to the Apache configuration files directory:
```bash
cd /etc/apache2/sites-available/
```

Copy the default configuration file to create a new one for your site:
```bash
sudo cp 000-default.conf gci.conf
```

### 3.2 Edit the Configuration File
Open the newly created configuration file:
```bash
sudo nano gci.conf
```

Update the file with the following:
```apache
ServerAdmin yourname@example.com
DocumentRoot /var/www/gci/
ServerName gci.example.com
```
Save and exit the file.

---

## Step 4: Activating the VirtualHost File
To activate your new site configuration:

1. Enable the site:
   ```bash
   sudo a2ensite gci.conf
   ```
   You should see this output:
   ```
   Enabling site gci.
   To activate the new configuration, you need to run:
     service apache2 reload
   ```
2. Reload Apache to apply the changes:
   ```bash
   service apache2 reload
   ```

---

## Step 5: Testing Your Website

Open a web browser and navigate to `http://gci.example.com`. If everything is set up correctly, you should see the webpage with the message:

```
I'm running this website on an Ubuntu Server server!
