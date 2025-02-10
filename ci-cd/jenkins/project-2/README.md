# Jenkins Installation and Configuration (Master-Worker Setup on Local Virtual Machines)

## Master Node Setup

### 1. Install Jenkins

```bash
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
    https://pkg.jenkins.io/debian/jenkins.io-2023.key

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian binary/" | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update
sudo apt-get install fontconfig openjdk-17-jre
sudo apt-get install jenkins

```
### 2. Get Server IP Address

```bash

ip a

```
### 3. Retrieve Initial Jenkins Admin Password

```bash

sudo cat /var/lib/jenkins/secrets/initialAdminPassword

```
### 4. Configure SSH Key for Secure Connection to Worker Node

```bash

ssh-keygen
ls -a
cd .ssh/
ls
cat id_ed25519.pub

```
## Worker Node Setup

### 1. Get Server IP Address

```bash
ip 

```
### 2. Navigate to SSH Directory

```bash

cd .ssh/
ls

```
### 3. Edit Authorized Keys (If Needed)

```bash

vim authorized_keys

```

### 4. Verify SSH Connection

```bash

ssh ubuntu@<worker-node-ip> "echo 'SSH connection successful'"

```

## Jenkins Dashboard Configuration

1.Navigate to Jenkins Dashboard → Manage Jenkins → Credentials → Global → Add Credentials

2.Select Kind = SSH Username with Private Key

3.Set ID = id_rsa

4.Set Username = ubuntu

5.Click on Private Key → Select Enter Directly

6.Copy and paste the id_rsa (private key of master)

7.Save the credentials

