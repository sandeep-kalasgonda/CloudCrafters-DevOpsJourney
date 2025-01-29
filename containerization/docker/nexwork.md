
---

# **Docker Networking Options: Syntax & Examples**

### **1️⃣ Bridge Network (Default Network Type)**  
**What is it?**  
The bridge network is Docker's default network driver. Containers on the same bridge network can communicate with each other but are isolated from containers on other networks.

**Use Case:**  
Ideal for when you need container-to-container communication on the same host.

**📌 Syntax:**
```bash
# Run a container on the bridge network
docker run -d --name <container_name> --network bridge <image>

# List all networks
docker network ls

# Inspect a specific network
docker network inspect bridge

# Disconnect a container from a network
docker network disconnect <network_name> <container_name>

# Connect a container to a network
docker network connect <network_name> <container_name>
```

**✅ Example:**
```bash
# Run a container on the bridge network
docker run -d --name my_nginx --network bridge nginx
```

---

### **2️⃣ Host Network (Directly Use Host's Network)**  
**What is it?**  
Containers on the host network use the host’s IP address and networking stack, making it as if the container is running directly on the host.

**Use Case:**  
Useful when you need the container to access the host's network directly (e.g., high-performance scenarios).

**📌 Syntax:**
```bash
# Run a container on the host network
docker run -d --name <container_name> --network host <image>
```

**✅ Example:**
```bash
# Run a container on the host network
docker run -d --name my_nginx --network host nginx
```

---

### **3️⃣ Overlay Network (Multi-Host Communication)**  
**What is it?**  
Overlay networks allow containers across multiple Docker hosts to communicate securely, typically used in Docker Swarm or Docker Compose for multi-host networking.

**Use Case:**  
Used for scaling applications across multiple Docker hosts, ideal for Docker Swarm or Kubernetes setups.

**📌 Syntax:**
```bash
# Create an overlay network
docker network create --driver overlay <network_name>

# Run a container on the overlay network
docker run -d --name <container_name> --network <network_name> <image>
```

**✅ Example:**
```bash
# Create an overlay network named "my_overlay"
docker network create --driver overlay my_overlay

# Run a container on the overlay network
docker run -d --name my_nginx --network my_overlay nginx
```

---

### **4️⃣ None Network (No Networking)**  
**What is it?**  
Containers using the `none` network driver have no external network access. They can still communicate with other containers on the same host using the localhost interface.

**Use Case:**  
For isolated containers that don’t need networking, e.g., standalone services or testing.

**📌 Syntax:**
```bash
# Run a container with no networking
docker run -d --name <container_name> --network none <image>
```

**✅ Example:**
```bash
# Run a container with no networking
docker run -d --name my_nginx --network none nginx
```

---

### **5️⃣ Custom User-Defined Network (Isolated Network)**  
**What is it?**  
You can create custom networks with more control, allowing you to isolate containers and customize network settings like DNS.

**Use Case:**  
Used when you need more granular control over container networking and isolation.

**📌 Syntax:**
```bash
# Create a custom network
docker network create <network_name>

# Run a container on a custom network
docker run -d --name <container_name> --network <network_name> <image>
```

**✅ Example:**
```bash
# Create a custom network named "my_custom_network"
docker network create my_custom_network

# Run a container on the custom network
docker run -d --name my_nginx --network my_custom_network nginx
```

---

### **6️⃣ Inspecting Networks**  
**📌 Syntax:**
```bash
# Inspect network details
docker network inspect <network_name>

# Get container's IP address in a specific network
docker network inspect <network_name> --format '{{range .Containers}}{{.Name}}: {{.IPv4Address}}{{end}}'
```

**✅ Example:**
```bash
# Inspect the details of the "bridge" network
docker network inspect bridge

# Get the IP address of a container in the "my_custom_network"
docker network inspect my_custom_network --format '{{range .Containers}}{{.Name}}: {{.IPv4Address}}{{end}}'
```

---

### **📌 Summary Table**

| Network Type     | Communication Scope                | Use Case                                       |
|------------------|------------------------------------|------------------------------------------------|
| **Bridge**       | Local (same host)                  | Containers on the same host need to communicate |
| **Host**         | Host’s network                     | Direct access to host network, ideal for performance |
| **Overlay**      | Multi-host (swarm mode or Kubernetes) | Cross-host communication in multi-host setups  |
| **None**         | Isolated, no network               | Containers with no networking, isolated services |
| **Custom**       | Isolated (user-defined)            | Containers that need isolated or custom networks |

---

