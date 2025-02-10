# Docker Swarm Basic Project

This project demonstrates a simple **Docker Swarm** deployment with **one manager node** and **two worker nodes** running an **NGINX web service**.

---

## **Project Architecture**
- **1 Manager Node:** Manages and orchestrates the Swarm cluster.
- **2 Worker Nodes:** Execute containerized workloads.

**Objective:** Deploy a scalable NGINX web service with three replicas.

---

## **Prerequisites**

- Three Ubuntu machines (1 manager, 2 workers)
- Docker installed on all nodes:
  ```bash
  sudo apt-get update
  sudo apt-get install -y docker.io
  sudo systemctl enable docker
  sudo systemctl start docker
  ```

---

## **Step 1: Initialize Docker Swarm**

### **On the Manager Node:**
1. Initialize the Swarm cluster:
   ```bash
   sudo docker swarm init --advertise-addr <manager-ip>
   ```
   Replace `<manager-ip>` with the manager node's IP address.

2. Note the `docker swarm join` command provided in the output.

### **On Each Worker Node:**
Join the Swarm cluster:
```bash
sudo docker swarm join --token <worker-token> <manager-ip>:2377
```
Replace `<worker-token>` and `<manager-ip>` with the values from the manager node output.

### **Verify the Cluster:**
On the manager node, check the nodes in the cluster:
```bash
docker node ls
```

---

## **Step 2: Create Docker Compose File**
Create a file named `docker-compose.yml`:

```yaml
version: "3.8"

services:
  web:
    image: nginx:latest
    ports:
      - "80:80"
    deploy:
      replicas: 3
      restart_policy:
        condition: on-failure
      placement:
        constraints:
          - node.role == worker
```

---

## **Step 3: Deploy the Stack**
Deploy the services using Docker Swarm:
```bash
docker stack deploy -c docker-compose.yml myapp
```

### **Verify the Deployment:**
Check the status of the services:
```bash
docker service ls
```
Check the running tasks:
```bash
docker service ps myapp_web
```

---

## **Step 4: Access the Application**
Open your web browser and access the NGINX web service using the manager node's IP address:
```http
http://<manager-ip>
```

---

## **Step 5: Scaling the Service**
To scale the `web` service to 5 replicas:
```bash
docker service scale myapp_web=5
```

### **Verify the Scaling:**
Check the running replicas:
```bash
docker service ps myapp_web
```

---

## **Directory Structure**
```
docker-swarm-basic-project/
└── docker-compose.yml
```

---

## **Project Recap**
- **Manager Node:** Orchestrates the Swarm cluster.
- **Worker Nodes:** Run NGINX services with 3 replicas.
- **Scaling:** Demonstrated scaling the service to 5 replicas.

---

## **Future Enhancements**
- Add persistent storage for data.
- Implement monitoring using Prometheus and Grafana.
- Configure Traefik or HAProxy for load balancing.
- Set up a CI/CD pipeline.

Feel free to reach out or contribute to enhance this project further!

