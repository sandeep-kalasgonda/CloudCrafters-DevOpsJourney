
# Docker and Docker Compose Installation Guide

## Prerequisites
Ensure that your system meets the following requirements:
- A system with a supported OS (Linux, macOS, or Windows)
- Administrative privileges
- Internet connection

## Installing Docker

### On Linux (Ubuntu/Debian)
1. Update the package list:
   ```sh
   sudo apt update
   ```
2. Install required dependencies:
   ```sh
   sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
   ```
3. Add Docker’s official GPG key:
   ```sh
   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
   ```
4. Add the Docker repository:
   ```sh
   echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
   ```
5. Install Docker:
   ```sh
   sudo apt update
   sudo apt install docker.io -y
   
   ```
6. Verify installation:
   ```sh
   docker --version
   ```

### On macOS
1. Download Docker Desktop from [Docker's official website](https://www.docker.com/products/docker-desktop/).
2. Install it by following the on-screen instructions.
3. Verify installation:
   ```sh
   docker --version
   ```

### On Windows
1. Download and install Docker Desktop from [Docker's official website](https://www.docker.com/products/docker-desktop/).
2. Enable WSL2 backend during installation.
3. Verify installation:
   ```sh
   docker --version
   ```

## Installing Docker Compose
1. Download the latest version of Docker Compose:
   ```sh
   sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
   ```
2. Apply executable permissions:
   ```sh
   sudo chmod +x /usr/local/bin/docker-compose
   ```
3. Verify installation:
   ```sh
   docker-compose --version
   ```

## Docker Compose YAML File for WordPress and MySQL

Save the following content as `docker-compose.yml`:

```yaml
version: '3.9'

services:
  db:
    image: mysql:8.0
    container_name: wordpress-db
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: rootpassword  
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wp_user
      MYSQL_PASSWORD: wp_password     
    volumes:
      - db_data:/var/lib/mysql
    networks:
      - wp_network

  wordpress:
    image: wordpress:latest
    container_name: wordpress-site
    depends_on:
      - db
    restart: always
    ports:
      - "8080:80"
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_USER: wp_user
      WORDPRESS_DB_PASSWORD: wp_password
      WORDPRESS_DB_NAME: wordpress
    volumes:
      - wp_data:/var/www/html
    networks:
      - wp_network

volumes:
  db_data:
  wp_data:

networks:
  wp_network:
```

## Running the WordPress and MySQL Containers
1. Navigate to the directory containing the `docker-compose.yml` file.
2. Run the following command to start the services:
   ```sh
   docker-compose up -d
   ```
3. Access WordPress by opening `http://localhost:8080` in a web browser.

## Stopping and Removing the Containers
To stop and remove the containers, run:
```sh
docker-compose down
```

This will shut down the services and remove the containers but will preserve the database data in the named volumes.

## Conclusion
You have successfully set up a WordPress site using Docker and Docker Compose. Modify the environment variables as needed to suit your requirements.

