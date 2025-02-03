# KVM Installation Guide
 
This guide provides instructions for installing and setting up Kernel-based Virtual Machine (KVM) on a Linux-based system. Follow the steps below to get started.
 
---
 
## Prerequisites

1. **Ensure Required Packages are Installed:**

   - Ensure you have `sudo` or root access.

   - Update the package list:

     ```bash

     sudo apt update

     ```
 
2. **Check CPU Virtualization Support:**

   ```bash

   egrep -c '(vmx|svm)' /proc/cpuinfo

   ```

   - If the output is greater than `0`, your system supports virtualization.

3. **Next, check if your system can use KVM acceleration:**

   ```bash

   sudo kvm-ok

   ```

   - If kvm-ok returns an error, install cpu-checker to resolve the issue.
   
4. **. To install cpu-checker, run the following command:**

   ```bash

   sudo apt install cpu-checker

   ```

5. **. When the installation completes, rerun the command to check KVM acceleration availability, and if everything is ok, you are ready to start installing KVM.**

   - If the output is greater than `0`, your system supports virtualization.

---
 
## Installation Steps
 
### 1. Install KVM and Supporting Packages

Run the following commands to install KVM:

```bash

sudo apt install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager

```
 
### 2. Authorize Users

Only members of the libvirt and kvm user groups can run virtual machines. If you want specific users to run VMs, add them to those user groups. Follow the steps below:

1. Add the user you want to run the virtual machines to the libvirt group:

```bash

sudo adduser [username] libvirt

```

Replace [username] with the actual username.

 
Next, do the same for the kvm group:

```bash

sudo adduser [username] kvm

```
 
### 3. Verify the Installation

Confirm that the KVM installation was successful with the virsh command. The virsh command is a command-line tool for managing virtual machines on Linux systems. Run the command below:

```bash

sudo virsh list --all

```
 The command lists all active and inactive virtual machines on the system. 


 Alternatively, use the systemctl command to check the status of libvirtd.

 ```bash

 sudo systemctl status libvirtd

 ```
 If the virtualization daemon is not active, activate it with the following command:

 ```bash

 sudo systemctl enable --now libvirtd

 ```

---

## Create Virtual Machine on Ubuntu

Before you choose one of the two methods below for creating a VM, install virt-manager, a tool for creating and managing VMs:

```bash

sudo apt install virt-manager -y

```
Download the ISO with the OS you wish to install on a VM and proceed to pick an installation method below.

### Method 1: Virt Manager GUI

Virt-manager is a graphical user interface tool for managing virtual machines, allowing users to create, configure, and control VMs using libvirt.

1. Start virt-manager by running the command below:

```bash

sudo virt-manager

```
Note: If you are using a bare metal server to run VMs and you want to connect via SSH, specify the -Y option when establishing the connection. It enables trusted X11 forwarding, which allows you to run graphical applications on a remote server and display them on your local machine securely.
The syntax is:

```bash

ssh -Y username@hostname

```
2. In the Virtual Machine Manager window, click the computer icon in the upper-left corner to create a new VM.

3. Select the option to install the VM using an ISO image and click Forward.

4. In the next dialogue, click Browse... and navigate to the path where you stored the ISO you wish to install. Select the ISO and click Forward to continue.

5. Enter the amount of RAM and the number of CPUs you wish to allocate to the VM and click Forward to proceed to the next step.

6. Allocate sufficient hard disk space to the VM. Click Forward to go to the last step.

7. Specify the name for your VM and click Finish to complete the setup.

The VM starts automatically, prompting you to start installing the OS that's on the ISO file.

### Method 2: Using Command Line

Use the virt-install command to create a VM via a Linux terminal. The syntax is:

virt-install --option1=value --option2=value ...


```bash

 sudo virt-install \
  --name myvm \
  --vcpus 2 \
  --memory 2048 \
  --cdrom /var/lib/libvirt/images/ubuntu-24.04.1-live-server-amd64.iso\
  --disk size=10 \
  --os-variant generic   


```

## Configuration
 
### 1. Enable Virtual Network

Check if the default virtual network is active:

```bash

sudo virsh net-list

```
 
If not active, start it:

```bash

sudo virsh net-start default

sudo virsh net-autostart default

```
 
### 2. Configure Bridged Networking (Optional)

For bridged networking, edit the network configuration file, usually found at `/etc/network/interfaces` or using `netplan` on newer systems. Example:
 
#### Netplan Example:

```yaml

network:

  version: 2

  ethernets:

    enp0s3:

      dhcp4: no

  bridges:

    br0:

      interfaces: [enp0s3]

      dhcp4: yes

```

Apply the changes:

```bash

sudo netplan apply

```
 
---
 
 
## Troubleshooting
 
- **Check Virtualization Support:**

  Ensure virtualization is enabled in the BIOS/UEFI.
 
- **Permissions Issue:**

  Add your user to the `kvm` group:

  ```bash

  sudo usermod -aG kvm $USER

  ```
 
- **Service Issues:**

  Restart the libvirt service:

  ```bash

  sudo systemctl restart libvirtd

  ```
 
---
 

 


 