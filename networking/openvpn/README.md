# VPN and OpenVPN Setup Guide

## What is a VPN?

A **Virtual Private Network (VPN)** is a technology that creates a secure, encrypted connection over a less secure network, such as the Internet. VPNs are commonly used to protect private web traffic from snooping, interference, and censorship.

### Key Benefits of VPNs:
- **Security:** Encrypts your data, protecting sensitive information.
- **Privacy:** Masks your IP address to maintain anonymity.
- **Remote Access:** Enables secure access to private networks from remote locations.

## VPN Tunneling

**Tunneling** is the process of encapsulating one network protocol within another. This allows data to be securely transferred across public networks.

### Types of VPN Tunneling Protocols:
- **PPTP (Point-to-Point Tunneling Protocol):** Simple but less secure.
- **L2TP/IPsec (Layer 2 Tunneling Protocol):** More secure with encryption.
- **OpenVPN:** Highly secure, open-source, uses SSL/TLS for encryption.

### How Tunneling Works:
1. **Encapsulation:** Data packets are wrapped with additional headers.
2. **Encryption:** Data is encrypted to prevent unauthorized access.
3. **Transmission:** Encrypted data travels through the tunnel.
4. **Decryption:** Data is decrypted at the receiving end.

## OpenVPN Installation and Setup on Ubuntu

### Prerequisites:
- Two Ubuntu systems (Server and Client)
- Sudo privileges

# OpenVPN Server Setup on Ubuntu

## Step 1: Update the System

```bash
sudo apt update && sudo apt upgrade -y
```

## Step 2: Install OpenVPN and Easy-RSA

```bash
sudo apt install openvpn easy-rsa -y
```

- **openvpn:** The actual VPN software.
- **easy-rsa:** A utility to manage SSL certificates, crucial for secure VPN communication.

**Why?** OpenVPN is the VPN software, and Easy-RSA helps generate the encryption keys needed for secure connections.

## Step 3: Set Up the Public Key Infrastructure (PKI)

```bash
make-cadir ~/openvpn-ca
cd ~/openvpn-ca
```

- **make-cadir ~/openvpn-ca:** Creates a directory named `openvpn-ca` with Easy-RSA files.
- **cd ~/openvpn-ca:** Navigates into the newly created directory.

**Why?** This directory will store SSL keys and certificates.

## Step 4: Configure Easy-RSA Variables

```bash
nano vars
```

- **nano vars:** Opens the `vars` file in the Nano editor for configuration.

**Why?** This file holds environment variables used while creating certificates.

Inside the file, set these values (replace defaults with India's details):

```bash
set_var EASYRSA_REQ_COUNTRY    "IN"
set_var EASYRSA_REQ_PROVINCE   "Karnataka"
set_var EASYRSA_REQ_CITY       "Bengaluru"
set_var EASYRSA_REQ_ORG        "MyVPN"
set_var EASYRSA_REQ_EMAIL      "admin@myvpn.com"
set_var EASYRSA_REQ_OU         "MyVPNUnit"
```

**Why?** These details personalize the SSL certificates.

## Step 5: Build the Certificate Authority (CA)

```bash
./easyrsa init-pki
./easyrsa build-ca
```

- **./easyrsa init-pki:** Initializes the Public Key Infrastructure (PKI) directory.
- **./easyrsa build-ca:** Builds the Certificate Authority (CA) to sign certificates.

**Why?** The CA is essential for issuing and verifying SSL certificates.

You'll be prompted to create a CA password—keep it secure.

## Step 6: Generate Server Certificate and Key

```bash
./easyrsa gen-req server nopass
./easyrsa sign-req server server
```

- **gen-req server nopass:** Creates a private key and certificate request for the server (`nopass` skips password protection).
- **sign-req server server:** Signs the server’s certificate with the CA.

**Why?** The server needs its certificate to authenticate with clients securely.

## Step 7: Generate Diffie-Hellman Parameters

```bash
./easyrsa gen-dh
```

**Why?**
- gen-dh generates the Diffie-Hellman (DH) parameters file, usually named dh.pem.
- This file is used for securely exchanging encryption keys between the VPN server and clients.
- It's mandatory for traditional OpenVPN setups (unless you're using Elliptic Curve Diffie-Hellman instead).

# Step 8: Configure the OpenVPN Server

```bash
sudo gunzip -c /usr/share/doc/openvpn/examples/sample-config-files/server.conf.gz | sudo tee /etc/openvpn/server.conf
```

### Explanation:
- gunzip -c: Decompresses the server.conf.gz file without removing the original .gz file.
- | sudo tee /etc/openvpn/server.conf: Sends the decompressed output and saves it as server.conf in /etc/openvpn/.
- This command is commonly used to create a base server configuration for OpenVPN. It saves time because you don’t have to write the whole config file from scratch.


### Edit the File:

```bash
sudo nano /etc/openvpn/server.conf
```

### Key Changes:

```bash
port 1194
proto udp
dev tun
tls-auth /etc/openvpn/ta.key 0
ca ca.crt
cert server.crt
key server.key
dh dh.pem
server 10.8.0.0 255.255.255.0
push "route 10.8.0.0 255.255.255.0"
push "redirect-gateway def1 bypass-dhcp"
cipher AES-256-CBC
auth SHA256
user nobody
group nogroup
persist-key
persist-tun
status openvpn-status.log
verb 3

```

### Explanation:
- **`ca ca.crt`**: Specifies the Certificate Authority file.
- **`cert server.crt`**: Points to the server certificate.
- **`key server.key`**: Indicates the private key for the server.
- **`dh dh.pem`**: Refers to the Diffie-Hellman parameters file.
- After configuring this make sure the files like
    - server.key
    - server.crt
    - ca.crt
    - dh.pem
    - ta.key
- Are in the same folder as the "server.conf" or while configuring give the proper location of this files

## Step 9: start/enable the service  and check the server

```bash
sudo systemctl start openvpn@server
sudo systemctl enable openvpn@server
sudo systemctl status openvpn@server
```

```bash
ip a
```

**Why?**
- you can see new virtual interface "tun0"

# Step 10: Generate Client Private Key and Certificate Signing Request (CSR)

```bash
./easyrsa gen-req client_name nopass
```

### Explanation:
- **`client_name`** → This is the client name.
- **`nopass`** → No password required for the key (optional; omit `nopass` if you prefer password protection).

### Generated Files:
- **Private Key:** `~/openvpn-ca/pki/private/client_name.key`
- **CSR (Certificate Signing Request):** `~/openvpn-ca/pki/reqs/client_name.req`

---

# Step 11: Sign the Client Certificate Request

```bash
./easyrsa sign-req client client_name
```

### Confirmation:
You'll be prompted to confirm the signing request:

```bash
Type the word 'yes' to continue: yes
```

### Generated Certificate:
- `~/openvpn-ca/pki/issued/client_name.crt`


# OpenVPN Client Setup Guide

## Step 1: Copy Client Files to the Client Machine

### Required Files:
- `client_name.crt` (Client Certificate)
- `client_name.key` (Client Private Key)
- `ca.crt` (Certificate Authority Certificate)
- `ta.key` (TLS Authentication Key, if applicable)

### Copy Files Using SCP:
- copy the above required files to the client machine
- Also give the appropriate permissions for the keys and crt's to accessed by the file

---

## Step 2: Install OpenVPN on the Client Machine

```bash
sudo apt update
sudo apt install openvpn -y
```

---

## Step 3: Configure the OpenVPN Client

### Create the Client Configuration File:
```bash
sudo nano /etc/openvpn/client.ovpn
```

### Add the Following Configuration:
```ini
client
dev tun
proto udp
remote 10.112.222.235 1194  # Replace with your server's IP
remote-cert-tls server
float

# TLS Auth key and also location of the key file
tls-auth /etc/openvpn/client/ta.key 1

# Certificates and Keys  and mention the correct location of the files
ca /etc/openvpn/client/ca.crt
cert /etc/openvpn/client/client1.crt
key /etc/openvpn/client/client1.key

# Encryption settings
cipher AES-256-CBC
auth SHA256
data-ciphers AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305  # Added for compatibility

# Network settings
compress lzo             # Updated to avoid deprecation warning
nobind                   # Add this to prevent binding to a specific local port
persist-key              # Maintains key state across restarts
persist-tun              # Maintains tunnel state across restarts
verb 3

```

### Explanation:
- **`client`**: Specifies the mode as client.
- **`dev tun`**: Creates a TUN device for tunneling.
- **`proto udp`**: Uses UDP protocol.
- **`remote`**: Server's IP and port.
- **`ca`, `cert`, `key`, `tls-auth`**: Paths to the security credentials.
- **`cipher`**: Encryption cipher.
- **`auth`**: Authentication algorithm.
- **`persist-key`/`persist-tun`**: Maintains connection across restarts.
- **`verb 3`**: Sets verbosity level for logging.

---

## Step 4: Connect to the OpenVPN Server

```bash
sudo systemctl start openvpn
sudo systemctl enable openvpn@client
```

### Create the VPN Connection:
```bash
sudo openvpn --config /etc/openvpn/client/client.conf   
```
- To run in a detached mode
```bash
sudo openvpn --config /etc/openvpn/client/client.conf --daemon

```

### Verify the VPN Connection:
```bash
ip a
```
- By running this command it will show the virtual interface that just now created by the VPN connection

### To kill the connection:
```bash
sudo kill openvpn
```









