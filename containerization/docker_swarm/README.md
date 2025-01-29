# Docker Swarm Run Notes

## **1. Introduction to Docker Swarm**
Docker Swarm is a native container orchestration tool for Docker. It allows you to manage multiple Docker nodes as a single cluster, enabling container deployment, scaling, and management.

---

## **2. Initial Setup Commands**

### **Install Docker**
Before using Docker Swarm, ensure Docker is installed on all nodes.
```bash
sudo apt update
sudo apt install docker.io -y
```
Enable and start the Docker service:
```bash
sudo systemctl enable docker
sudo systemctl start docker
```

### **Enable Docker Swarm Mode**

#### **On the Manager Node:**
```bash
docker swarm init --advertise-addr <MANAGER_IP>
```
- `docker swarm init`: Initializes the swarm cluster on the manager node.
- `--advertise-addr`: Specifies the IP address the manager node should advertise to worker nodes.

#### **Example:**
```bash
docker swarm init --advertise-addr 192.168.1.100
```
This command initializes the swarm and provides a command to join worker nodes with private ip (in case using AWS instance).

---

### **Join Worker Nodes to the Swarm**
On each worker node, execute the join command provided by the manager node:
```bash
docker swarm join --token <TOKEN> <MANAGER_IP>:2377
```
- `--token`: The unique token required to join the swarm.
- `2377`: The default port for swarm communication.

#### **Example:**
```bash
docker swarm join --token SWMTKN-1-abc123def456 192.168.1.100:2377
```

To get the join token from the manager node, run:
```bash
docker swarm join-token worker
```

---

## **3. Managing Docker Swarm**

### **List Nodes in the Swarm**
```bash
docker node ls
```
- Displays the status of all nodes in the swarm, including their roles and availability.

### **Deploy a Service in the Swarm**
```bash
docker service create --name <SERVICE_NAME> --replicas <NUMBER> -p <HOST_PORT>:<CONTAINER_PORT> <IMAGE_NAME>
```
- `--name`: Specifies the service name.
- `--replicas`: Number of container replicas.
- `-p`: Maps host ports to container ports.
- `<IMAGE_NAME>`: The Docker image to use.

#### **Example:**
```bash
docker service create --name nginx-service --replicas 3 -p 80:80 nginx
```
This command deploys an Nginx service with three replicas, accessible on port 80.

### **List Services in the Swarm**
```bash
docker service ls
```
- Displays all running services in the swarm.

### **Inspect a Service**
```bash
docker service inspect <SERVICE_NAME>
```
- Provides detailed information about a specific service.

### **Scale a Service**
```bash
docker service scale <SERVICE_NAME>=<REPLICAS>
```
- Adjusts the number of replicas for a service.

#### **Example:**
```bash
docker service scale nginx-service=5
```
This command scales the Nginx service to five replicas.

### **Update a Service**
```bash
docker service update --replicas <NEW_REPLICAS> <SERVICE_NAME>
```
- Updates the service configuration.

#### **Example:**
```bash
docker service update --replicas 2 nginx-service
```

---

## **4. Rolling Updates in Docker Swarm**
A rolling update allows you to update services incrementally without downtime. It updates a few replicas at a time rather than all at once, ensuring the service remains available throughout the update process.

### **Benefits of Rolling Updates:**
- **Minimized Downtime:** Keep services running during updates.
- **Controlled Rollout:** Monitor updates for potential issues and rollback if necessary.
- **Version Management:** Gradually transition to new application versions.

### **Performing a Rolling Update**
```bash
docker service update --image <NEW_IMAGE> <SERVICE_NAME>
```
- `--image`: Specifies the updated image.
- `<SERVICE_NAME>`: The service to be updated.

#### **Example:**
```bash
docker service update --image nginx:latest nginx-service
```

### **Rolling Update Configuration**
You can control the update process using flags:
- `--update-parallelism`: Number of tasks to update at once.
- `--update-delay`: Time delay between updating each set of tasks.

#### **Example:**
```bash
docker service update --image nginx:latest --update-parallelism 2 --update-delay 10s nginx-service
```
This command updates the service to the latest Nginx image, updating two replicas at a time with a 10-second delay between updates.

---

## **5. Monitoring and Debugging**

### **Check Service Logs**
```bash
docker service logs <SERVICE_NAME>
```
- Shows logs for a specific service.

#### **Example:**
```bash
docker service logs nginx-service
```

### **Remove a Service**
```bash
docker service rm <SERVICE_NAME>
```
- Deletes a service from the swarm.

### **Drain and Activate Node Instances**

#### **Drain a Node**
```bash
docker node update --availability drain <NODE_NAME>
```
- Moves all tasks off the node and prevents new tasks from being assigned to it.

#### **Example:**
```bash
docker node update --availability drain worker-node-1
```

#### **Activate a Node**
```bash
docker node update --availability active <NODE_NAME>
```
- Makes the node available for task assignment.

#### **Example:**
```bash
docker node update --availability active worker-node-1
```

### **Leave the Swarm**
On a worker node:
```bash
docker swarm leave
```
On a manager node (force leave):
```bash
docker swarm leave --force
```

---

## **6. Example Use Case: Deploying a Web Application**
### Step 1: Initialize the Swarm on the Manager Node
```bash
docker swarm init --advertise-addr 192.168.1.100
```
### Step 2: Join Worker Nodes
```bash
docker swarm join --token SWMTKN-1-abc123def456 192.168.1.100:2377
```
### Step 3: Deploy an Nginx Service
```bash
docker service create --name nginx-service --replicas 3 -p 80:80 nginx
```
### Step 4: Scale the Service
```bash
docker service scale nginx-service=5
```
### Step 5: Perform a Rolling Update
```bash
docker service update --image nginx:latest --update-parallelism 1 --update-delay 5s nginx-service
```
### Step 6: Monitor Logs
```bash
docker service logs nginx-service
```

---

## **7. Conclusion**
Docker Swarm simplifies container orchestration and scaling. Rolling updates provide a robust way to deploy new versions incrementally, ensuring service availability and minimizing risk.

