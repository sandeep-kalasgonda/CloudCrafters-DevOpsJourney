# Vagrant Documentation

Vagrant is a tool for building and managing virtual machine environments. This guide explains how to install and set up Vagrant on an Ubuntu system.

## Prerequisites

- VirtualBox installed as the virtualization provider (or an alternative provider VMware can also used)

---

## Step 1: Install VirtualBox

Vagrant requires a virtualization provider like VirtualBox to manage virtual machines. To install VirtualBox, run:

```bash
sudo apt update
sudo apt install virtualbox -y
```

Verify the installation

```bash
virtualbox --help
```

---

## Step 2: Install Vagrant

1. **Download the Vagrant Package**  
   Download the latest Vagrant `.deb` package from the [official Vagrant website](https://www.vagrantup.com/downloads).

   Alternatively, use the following commands to download and install it directly via terminal:

   ```bash
   curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
   echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
   sudo apt update
   sudo apt install vagrant -y
   ```

2. **Verify the Installation**  
   Check that Vagrant is installed correctly by running:

   ```bash
   vagrant --version
   ```

---

## Step 3: Set Up Vagrant

0. **SHORTCUT**  
   Use only when there is no requirment for the N/W or File-mounting    
   -vagrant init "ubuntu/bionic64"  --> use this example:

   ```bash
   vagrant init "OS You Prefer/Version and Architecture"
   ```

1. **Create a Project Directory**  
   Choose or create a directory to initialize a Vagrant project:

   ```bash
   mkdir any_directory_name
   cd any_directory_name
   ```

2. **Initialize Vagrant**  
   Run the following command to create a `Vagrantfile`:

   ```bash
   vagrant init
   ```

   This generates a basic configuration file named `Vagrantfile`.
   Edit that file for the customize VM's

3. **Customize the `Vagrantfile`**  
   Open the `Vagrantfile` in a text editor and configure it to use a specific box (e.g., Ubuntu 20.04):

   ```ruby
   Vagrant.configure("2") do |config|
     config.vm.box = "ubuntu/focal64"
   end
   ```

4. **Start the Virtual Machine**  
   Bring up the virtual machine using:

   ```bash
   vagrant up
   ```

5. **Access the Virtual Machine**  
   SSH into the VM:

   ```bash
   vagrant ssh
   ```

6. **Stop the Virtual Machine**  
   To stop the VM, run:

   ```bash
   vagrant halt
   ```

7. **Kill/Delete the Virtual Machine**  
   To kill the VM, run:

   ```bash
   vagrant destroy
   ```

8. **Restart the Virtual Machine**  
   To restart the VM, run:

   ```bash
   vagrant reload
   ```

9. **Provisioning the Virtual Machine**  
    This will helpful in running the commands which given in the VagrantFile inside the created VM's.
   To Provisionig the VM, run:

   ```bash
   vagrant provision
   ```





---


## Step 4: Networking Options in Vagrant

Vagrant provides various networking options to suit different use cases:

1. **Public Networking**  
   ```ruby
      config.vm.network "public_network", bridge: "en0: Wi-Fi"
   ```

2. **Private Networking**  
   ```ruby
   config.vm.network "private_network", ip: "192.168.56.101"
   ```

3. **Port Forwarding**  
   ```ruby
   config.vm.network "forwarded_port", guest: 80, host: 8080
   ```

   This above commands are the example. 
   you can modify the Bridge,IP,PORTS

---

## Step 5: File Mounting

Vagrant allows you to share folders between the host and guest machine. By default, the project directory is synced to `/vagrant` in the guest machine. You can customize synced folders as follows:

1. **Default Synced Folder**  
   The project folder is automatically mounted to `/vagrant` in the guest machine. To access it:

   ```bash
   cd /vagrant
   ```

2. **Custom Synced Folder**  
   ```ruby
   config.vm.synced_folder "./data", "/home/vagrant/data"
   ```

   Here, the `./data` folder on the host is synced to `/home/vagrant/data` on the guest.

3. **NFS Synced Folder**  
   ```ruby
   config.vm.synced_folder "./data", "/home/vagrant/data", type: "nfs"
   ```

   Note: NFS requires root permissions on the host system.





---

## Uninstalling Vagrant 

To remove Vagrant, run:

```bash
sudo apt remove --purge vagrant -y
```

---

