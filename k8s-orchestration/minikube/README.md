# **Minikube - Getting Started with Kubernetes Locally**

## **What is Minikube?**
Minikube is a lightweight tool that allows you to **run Kubernetes locally** on your system. It creates a single-node Kubernetes cluster, making it ideal for learning, development, and testing before deploying to a real cloud or production environment.

---

## **🔧 Prerequisites**
Before installing Minikube, ensure your system meets the following requirements:

### **1️ System Requirements**
- **Operating System** – Windows, macOS, or Linux
- **CPU & RAM** – At least **2 CPUs, 2GB RAM** (Recommended: **4 CPUs, 8GB RAM**)
- **Disk Space** – Minimum **20GB of free storage**

### **2️ Required Dependencies**
To run Minikube, you need one of the following container or VM managers:

#### **🔹 Container Runtime (Preferred)**
- **Docker** (Recommended) → Install Docker based on your OS:
    - Linux: [Install Docker](https://docs.docker.com/engine/install/)
    - macOS: Install via Homebrew → `brew install --cask docker`
    - Windows: Install Docker Desktop

#### **🔹 Virtual Machine (Alternative)**
If you prefer using a VM instead of Docker, install one of the following:
- **VirtualBox** → `sudo apt install virtualbox` (Linux)
- **KVM/QEMU** → `sudo apt install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils`
- **Hyper-V (Windows)** → Enable via Windows Features

#### **🔹 Kubernetes CLI (kubectl)**
`kubectl` is required to interact with the Kubernetes cluster. Install it using:
```sh
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install kubectl /usr/local/bin/kubectl
```
Verify installation:
```sh
kubectl version --client
```

---

## **Installing Minikube**
Once the prerequisites are met, install Minikube with the following steps:

### **🔹 Install Minikube (Linux & macOS)**
```sh
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
```

### **🔹 Install Minikube (Windows)**
Download the Minikube executable from the [official website](https://minikube.sigs.k8s.io/docs/start/) and add it to your system PATH.

---

## **What’s Next?**
Once Minikube is installed, move on to:
1️ **Starting a Minikube Cluster** → `minikube start`
2️ **Deploying Applications** → Run an NGINX server
3️ **Exploring Kubernetes Concepts** → Pods, Services, and Deployments
4️ **Configuring Add-ons** → Ingress, Storage, and Monitoring

# **Minikube - Command Reference Guide**

Below is a list of essential **Minikube** commands along with their descriptions and usage examples. This will help users efficiently manage their local Kubernetes cluster.

---

## **1️ Starting and Stopping Minikube**

| Command | Description |
|---------|-------------|
| `minikube start` | Starts a Minikube cluster using the default container runtime. |
| `minikube start --driver=docker` | Starts Minikube using Docker as the driver. |
| `minikube stop` | Stops the running Minikube cluster. |
| `minikube delete` | Deletes the Minikube cluster and all associated resources. |
| `minikube pause` | Pauses the Minikube cluster to free up system resources. |
| `minikube unpause` | Resumes a paused Minikube cluster. |

---

## **2️ Cluster and Node Management**

| Command | Description |
|---------|-------------|
| `minikube status` | Displays the status of the Minikube cluster. |
| `kubectl get nodes` | Lists the nodes available in the cluster. |
| `minikube ip` | Shows the IP address of the Minikube cluster. |
| `minikube dashboard` | Opens the Kubernetes web dashboard for managing workloads. |
| `minikube logs` | Retrieves logs from the Minikube cluster. |

---

## **3️ Deploying and Managing Applications**

| Command | Description |
|---------|-------------|
| `kubectl create deployment <name> --image=<image>` | Creates a deployment using the specified container image. |
| `kubectl expose deployment <name> --type=NodePort --port=<port>` | Exposes the deployment as a service accessible on a specific port. |
| `kubectl get pods` | Lists all running pods in the cluster. |
| `kubectl get services` | Displays all services running in the cluster. |
| `kubectl delete deployment <name>` | Deletes a specified deployment. |

---

## **4️ Accessing Services and Applications**

| Command | Description |
|---------|-------------|
| `minikube service <service-name>` | Opens the service in a web browser. |
| `minikube service <service-name> --url` | Displays the URL of the service. |
| `kubectl port-forward <pod-name> <local-port>:<pod-port>` | Forwards a port from a local machine to a pod. |

---

## **5️ Working with Add-ons**

| Command | Description |
|---------|-------------|
| `minikube addons list` | Lists all available add-ons in Minikube. |
| `minikube addons enable <addon-name>` | Enables a specific Minikube add-on. |
| `minikube addons disable <addon-name>` | Disables a Minikube add-on. |

🔹 **Useful Add-ons:**
- **Ingress** → `minikube addons enable ingress`
- **Metrics Server** → `minikube addons enable metrics-server`
- **Dashboard** → `minikube addons enable dashboard`

---

## **6️ Managing Storage**

| Command | Description |
|---------|-------------|
| `minikube mount <local-path>:<container-path>` | Mounts a local directory inside the Minikube cluster. |
| `kubectl get pvc` | Lists all persistent volume claims. |
| `kubectl get pv` | Lists all persistent volumes. |

---

## **7️ Multi-Node and Advanced Configurations**

| Command | Description |
|---------|-------------|
| `minikube profile list` | Lists all Minikube profiles. |
| `minikube profile <profile-name>` | Switches between different Minikube profiles. |
| `minikube start --cpus=4 --memory=8192` | Allocates more CPUs and memory to Minikube. |
| `minikube config set memory 8192` | Permanently sets memory allocation for future Minikube starts. |

---

## **8️ Debugging and Logs**

| Command | Description |
|---------|-------------|
| `kubectl describe pod <pod-name>` | Shows detailed information about a pod. |
| `kubectl logs <pod-name>` | Displays logs of a running pod. |
| `kubectl exec -it <pod-name> -- /bin/sh` | Accesses a running pod’s shell. |
| `minikube ssh` | SSH into the Minikube virtual machine. |

---

## **9️ Deleting Resources and Resetting Minikube**

| Command | Description |
|---------|-------------|
| `kubectl delete pod <pod-name>` | Deletes a specific pod. |
| `kubectl delete service <service-name>` | Deletes a service. |
| `kubectl delete deployment <deployment-name>` | Deletes a deployment. |
| `minikube delete --all` | Removes all Minikube clusters. |

---

## **Summary**

Minikube provides a powerful way to **run Kubernetes locally** and experiment with clusters before moving to cloud environments. By mastering these commands, you can efficiently **deploy, manage, and troubleshoot** Kubernetes applications.

**Next Steps:**
- Start **practicing deployments** using Minikube
- Explore Kubernetes networking and storage
- Learn about **Ingress, Secrets, and ConfigMaps**

Happy Kubernetes Learning!

Minikube is a **powerful tool** to practice Kubernetes locally before moving to real-world deployments. 🚀
