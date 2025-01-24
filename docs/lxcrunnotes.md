# LXC Documentation for Installing and Setting Up on Ubuntu

## Introduction
Linux Containers (LXC) provide lightweight virtualization by enabling multiple isolated Linux systems (containers) to run on a single host using the same kernel. This guide walks you through the installation, setup, networking, and volume mounting for LXC on Ubuntu, with examples.

---

## Installing LXC on Ubuntu

Follow these steps to install LXC on an Ubuntu system:

### Step 1: Update the Systemcd D 
```bash
sudo apt update
sudo apt upgrade -y
```

### Step 2: Install LXC
```bash
sudo apt install lxc lxc-utils lxc-templates -y
```

### Step 3: Verify the Installation
Check the installed version of LXC:
```bash
lxc-checkconfig
```
This command ensures your kernel supports all the necessary features for LXC.

---

## Basic LXC Setup

### Step 1: Create a Container
To create a container named `my-container`:
```bash
sudo lxc-create -n my-container -t ubuntu
```
Here, `-t ubuntu` specifies the template to use for the container's root filesystem.

### Step 2: Start the Container
```bash
sudo lxc-start -n my-container -d
```
The `-d` flag runs the container in the background.

### Step 3: Attach to the Container
To attach to the container's shell:
```bash
sudo lxc-attach -n my-container
```

### Step 4: Stop the Container
To stop the container:
```bash
sudo lxc-stop -n my-container
```

---

## Networking Configuration

LXC supports several networking modes. By default, LXC containers use a bridged network setup. Below is an example of configuring a custom bridge:

### Step 1: Create a Network Bridge
1. Install the bridge utilities:
   ```bash
   sudo apt install bridge-utils -y
   ```
2. Edit the network configuration file to define the bridge. For example, modify `/etc/netplan/01-netcfg.yaml`:
   ```yaml
   network:
     version: 2
     renderer: networkd
     ethernets:
       enp0s3:
         dhcp4: no
     bridges:
       br0:
         interfaces: [enp0s3]
         addresses:
           - 192.168.1.100/24
         gateway4: 192.168.1.1
         nameservers:
           addresses: [8.8.8.8, 8.8.4.4]
   ```
3. Apply the changes:
   ```bash
   sudo netplan apply
   ```

### Step 2: Configure LXC to Use the Bridge
Edit the LXC container configuration file (e.g., `/var/lib/lxc/my-container/config`) and add:
```bash
lxc.net.0.type = veth
lxc.net.0.link = br0
lxc.net.0.flags = up
lxc.net.0.hwaddr = 00:16:3e:xx:xx:xx
```

Restart the container to apply the networking changes:
```bash
sudo lxc-stop -n my-container
sudo lxc-start -n my-container
```

---

## Volume Mounting

To share directories between the host and a container, use volume mounting:

### Step 1: Create a Directory on the Host
Create a directory on the host system to share with the container:
```bash
sudo mkdir -p /data/shared
sudo chown 1000:1000 /data/shared
```

### Step 2: Configure the Container to Use the Directory
Edit the LXC container configuration file (e.g., `/var/lib/lxc/my-container/config`) and add:
```bash
lxc.mount.entry = /data/shared data/shared none bind 0 0
```

### Step 3: Verify the Mount Inside the Container
After starting the container, verify the shared directory is mounted:
```bash
sudo lxc-attach -n my-container
ls /data/shared
```

---

## Example: Running an NGINX Server Inside an LXC Container

### Step 1: Create and Start a Container
```bash
sudo lxc-create -n nginx-container -t ubuntu
sudo lxc-start -n nginx-container -d
```

### Step 2: Attach to the Container
```bash
sudo lxc-attach -n nginx-container
```

### Step 3: Install NGINX Inside the Container
Inside the container:
```bash
apt update
apt install nginx -y
```

### Step 4: Start NGINX Inside the Container
```bash
systemctl start nginx
```

### Step 5: Access the NGINX Server
Find the container's IP address:
```bash
sudo lxc-info -n nginx-container | grep IP
```
Access the NGINX server by visiting `http://<container-ip>` in a browser.

---

## Troubleshooting

### Check Container Logs
If a container fails to start, check its logs:
```bash
sudo lxc-start -n my-container -l DEBUG -o my-container.log
```

### Verify Networking concept
Ensure the bridge and container network interfaces are correctly set up:
```bash
ip a
brctl show
```

---

This guide provides a comprehensive setup for LXC on Ubuntu, including networking and volume mounting configurations. If you need further customization or have additional questions, feel free to ask!
