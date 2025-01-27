# Ansible Setup and Apache Server Example on Ubuntu

## Introduction
Ansible is a powerful IT automation tool that simplifies configuration management, application deployment, and task automation. This documentation will guide you through installing and setting up Ansible on Ubuntu and provide an example for setting up an Apache web server using Ansible.

---

## Installing Ansible on Ubuntu

### Step 1: Update the System
```bash
sudo apt update
sudo apt upgrade -y
```

### Step 2: Install Required Dependencies
```bash
sudo apt install software-properties-common -y
```

### Step 3: Add the Ansible PPA
```bash
sudo add-apt-repository --yes --update ppa:ansible/ansible
```

### Step 4: Install Ansible
```bash
sudo apt install ansible -y
```

### Step 5: Verify Installation
To confirm that Ansible is installed:
```bash
ansible --version
```
You should see the version of Ansible installed.

---

## Setting Up SSH Connection for Ansible

Ansible requires SSH connectivity between the controller machine and the managed hosts. Here are the steps to set it up:

### Step 1: Generate SSH Key Pair (On Controller Machine)
If you don’t already have an SSH key, generate one:
```bash
ssh-keygen 
```
Press **Enter** to save the key in the default location (`~/.ssh/id_rsa`) and provide a passphrase if desired.

### Step 2: Copy SSH Key to Managed Host
Use the following command to copy the SSH public key to the managed host:
```bash
ssh-copy-id username@remote_host
```
- Replace `username` with the SSH user on the managed host.
- Replace `remote_host` with the IP address or hostname of the managed host.

### Step 3: Test SSH Connection
Verify the SSH connection from the controller to the managed host:
```bash
ssh username@remote_host
```
If successful, you will access the managed host without entering a password.

---

## Setting Up Ansible Inventory

Ansible uses an **inventory file** to define the hosts it manages.

### Step 1: Create an Inventory File
Edit the default inventory file or create a custom one. For example:
```bash
sudo nano /etc/ansible/hosts
```

Add your target server(s) to the inventory file:
```ini
[webservers]
192.168.1.100 ansible_user=ubuntu ansible_ssh_private_key_file=/path/to/private/key
```

- Replace `192.168.1.100` with your server's IP.
- Set `ansible_user` to the SSH user.
- Provide the path to your SSH private key.

### Step 2: Test Connectivity
Test if Ansible can reach the server:
```bash
ansible all -m ping
```
You should see a `pong` response if the connection is successful.

---

## Example: Apache Server Setup Using Ansible

### Step 1: Create a Playbook File
Create a YAML file for the playbook. For example:
```bash
nano apache-setup.yml
```

Add the following content to the playbook:
```yaml
---
- name: Install and Configure Apache Server
  hosts: webservers
  become: yes
  tasks:
    - name: Ensure Apache is installed
      apt:
        name: apache2
        state: present

    - name: Start and enable Apache service
      systemd:
        name: apache2
        state: started
        enabled: true

    - name: Deploy custom index.html
      copy:
        dest: /var/www/html/index.html
        content: |
          <html>
          <head>
            <title>Welcome to Apache</title>
          </head>
          <body>
            <h1>Apache is running!</h1>
          </body>
          </html>
```

### Step 2: Run the Playbook
Execute the playbook using the following command:
```bash
ansible-playbook apache-setup.yml
```

### Step 3: Verify the Setup
- Open a web browser and navigate to `http://<your-server-ip>`.
- You should see the custom Apache welcome page saying, "Apache is running!"

---

## Additional Notes

### Common Ansible Commands
- **Check Connectivity**: 
  ```bash
  ansible all -m ping
  ```
- **Run a Playbook**: 
  ```bash
  ansible-playbook <playbook-file>.yml
  ```
- **List Hosts in Inventory**: 
  ```bash
  ansible-inventory --list -y
  ```

### Debugging
If a playbook fails, add the `-vvv` flag to see detailed logs:
```bash
ansible-playbook apache-setup.yml -vvv
```

---

## Conclusion
This guide provides a step-by-step approach to installing Ansible on Ubuntu and using it to set up an Apache server. With Ansible, you can automate repetitive tasks and manage infrastructure efficiently. For further customization, explore Ansible's extensive module library in the [official documentation](https://docs.ansible.com/).
