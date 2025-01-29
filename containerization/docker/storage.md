Got it! Below is the full explanation of Docker storage types with the correct syntax for each.

---

# **Docker Storage Options: Syntax & Examples**

### **1️⃣ Docker Volumes (Recommended for Persistent Data)**  
**What is it?**  
Volumes are managed by Docker and persist even after containers are removed.  

**Use Case:**  
Best for databases, logs, or persistent data that needs to survive container restarts.

**📌 Syntax:**
```bash
# Create a new volume
docker volume create <volume_name>

# Run a container and mount the volume
docker run -d -v <volume_name>:<container_path> <image>

# List all volumes
docker volume ls

# Inspect a specific volume
docker volume inspect <volume_name>

# Remove a volume
docker volume rm <volume_name>

# Remove all unused volumes
docker volume prune
```

**✅ Example:**
```bash
# Create a volume named "my_data"
docker volume create my_data

# Run an Nginx container and attach the volume to /app/data inside the container
docker run -d -v my_data:/app/data nginx
```

---

### **2️⃣ Bind Mounts (Directly Mount Host Files)**  
**What is it?**  
Bind mounts link a directory or file from the host machine into the container.

**Use Case:**  
Useful when you need direct access to host files, such as during local development.

**📌 Syntax:**
```bash
# Run a container and mount a host directory
docker run -d -v <host_path>:<container_path> <image>

# Example: Mount the local directory ~/projects inside the container
docker run -d -v <host_directory>:/usr/share/nginx/html nginx
```

**✅ Example:**
```bash
# Run Nginx container and mount the local directory ~/projects to container path
docker run -d -v ~/projects:/usr/share/nginx/html nginx
```

---

### **3️⃣ Tmpfs Mounts (In-Memory Storage)**  
**What is it?**  
Tmpfs mounts store data in RAM, meaning it is temporary and disappears when the container stops.

**Use Case:**  
Used for sensitive, temporary data like cache or session storage.

**📌 Syntax:**
```bash
# Run a container with a tmpfs mount
docker run -d --tmpfs <container_path> <image>
```

**✅ Example:**
```bash
# Run Nginx container with tmpfs mount for /app/tmpfs
docker run -d --tmpfs /app/tmpfs nginx
```

---

### **4️⃣ Container Filesystem (UnionFS)**  
**What is it?**  
Each container has its own writable layer stored inside Docker's storage backend. Data is lost when the container is removed.

**Use Case:**  
Good for testing or containers that do not need persistent data.

**📌 Syntax:**
```bash
# Run a container without mounting storage
docker run -it --name <container_name> <image> bash
```

**✅ Example:**
```bash
# Run Ubuntu container and access bash
docker run -it --name test_container ubuntu bash
```

---

### **5️⃣ Managing Docker Storage**  
**📌 Key Commands:**
```bash
# Show disk usage of Docker objects
docker system df

# Remove unused volumes
docker volume prune

# Remove all stopped containers, unused networks, and dangling images
docker system prune
```

---

### **📌 Summary Table**

| Storage Type     | Persistent? | Speed | Best Use Case |
|-----------------|-------------|-------|--------------|
| **Volumes**     | ✅ Yes       | ⚡ Fast | Databases, shared data |
| **Bind Mounts** | ✅ Yes       | ⚡ Fast | Access host files |
| **Tmpfs**       | ❌ No        | 🚀 Very Fast | Temporary data (cache, sessions) |
| **Container FS**| ❌ No        | ⚡ Fast | Stateless applications |

---

