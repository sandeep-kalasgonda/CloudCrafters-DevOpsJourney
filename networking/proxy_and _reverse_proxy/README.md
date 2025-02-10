# Proxy vs Reverse Proxy

## 1. What is a Proxy?
A proxy server is an intermediate server that sits between a client (user’s device) and a destination server (website, application, etc.). The main job of a proxy is to forward requests and responses between the client and the destination.

### How a Proxy Works (Forward Proxy)
1. **User Request**: A user wants to access a website (e.g., example.com).
2. **Proxy Server**: The request is first sent to the proxy server.
3. **Forwarding**: The proxy server forwards the request to example.com on behalf of the user.
4. **Response**: The website (example.com) sends data back to the proxy server.
5. **Delivery**: The proxy server forwards this data back to the user.

### Why Use a Proxy?
✅ **Anonymity**: The actual user’s IP is hidden, and the proxy’s IP is shown instead.  
✅ **Access Control**: Blocks or allows specific websites (used in offices/schools).  
✅ **Content Filtering**: Can restrict access to harmful or inappropriate content.  
✅ **Caching**: Can store copies of frequently visited websites for faster access.  

### Example of Proxy Use Case
You are in India and want to access a website blocked in your country. A proxy server located in the US can request the website on your behalf.

---

## 2. What is a Reverse Proxy?
A reverse proxy works in front of a web server instead of a client. It receives requests from users and forwards them to the appropriate backend server.

### How a Reverse Proxy Works
1. **User Request**: A user wants to access example.com.
2. **Reverse Proxy Server**: The request is first sent to the reverse proxy.
3. **Backend Routing**: The reverse proxy forwards the request to one of the backend web servers (e.g., Server 1, Server 2).
4. **Response**: The selected backend server processes the request and sends the response back to the reverse proxy.
5. **Delivery**: The reverse proxy forwards the response to the user.

### Why Use a Reverse Proxy?
✅ **Load Balancing**: Distributes traffic among multiple servers to avoid overload.  
✅ **Security**: Hides backend servers from direct exposure to the internet.  
✅ **SSL Termination**: Handles encryption/decryption to reduce the load on backend servers.  
✅ **Caching**: Stores static content to serve users faster.  

### Example of Reverse Proxy Use Case
A popular e-commerce website (like Amazon) receives millions of requests. Instead of overloading a single server, a reverse proxy distributes the traffic to multiple backend servers.

---

## Configuring the Reverse Proxy
- In this repository you can find multipass virtualization you can refer that.
### Nginx Reverse Proxy with Three VMs
- **1 VM** will act as a **Reverse Proxy (Nginx)**
- **2 VMs** will act as **Backend Web Servers**
- **Your current system will access the reverse proxy**

### Configure VMs
Install Nginx on all the machines:
```
sudo apt update
sudo apt install nginx -y
```

### Configure Servers
Create a sample HTML page in both backend servers:
- Configure this in both ther server's identical pages or different pages 
```
echo "<h1>Welcome to Backend Server 1</h1>" | sudo tee /var/www/html/index.html
```
Use this for a sample web-page or else go to the file and manually configure the web-page as you like

### Configure Proxy Server
Edit the Nginx configuration file:
```
sudo vim /etc/nginx/sites-available/reverse-proxy
```
Create the configuration file:
```
upstream backend_servers {
    server 10.112.222.35:80;  # Backend-1 or server IP
    server 10.112.222.208:80;  # Backend-2 or server IP
}
server {
    listen 80;
    server_name 10.112.222.178; # Proxy server IP

    location / {
        proxy_pass http://backend_servers;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```
## what this configuratio do:
- upstream backend_servers {} → Defines a load-balancing group of backend servers.
- server { listen 80; } → Listens for HTTP traffic on port 80.
- proxy_pass http://backend_servers; → Routes all incoming requests to the backend servers.
- proxy_set_header → Passes client headers for better tracking.

### Enable the Reverse Proxy Configuration
Run the following commands:
```
sudo ln -s /etc/nginx/sites-available/reverse-proxy /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

## what this comand do 
- ln -s → Creates a symbolic link to enable the configuration.
- nginx -t → Checks for syntax errors.
- systemctl restart nginx → Applies changes.

### Testing the Setup
From your current system (as a client), open a browser and enter:
```
http://10.112.222.178/
```
Replace the IP with the actual proxy server's IP.

## Result
- When you refresh this web-site you will able to see the requests that randomly sent to the server's
- To see that more accurately edit the two server's web-page differently 

