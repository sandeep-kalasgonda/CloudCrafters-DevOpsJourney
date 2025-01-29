# DNS & BIND

## What & Why is DNS?

DNS stands for **Domain Name System**.  
It's a system that translates domain names into IP addresses and vice versa, allowing browsers to load web pages.  
→ **Phone-book of the internet**.

**User-Friendly Browsing:** Without DNS, browsing the internet would require remembering complex IP addresses.

---

## How it Resolves the Domain Name?

**Example:** `www.google.com`

- **Root (`.`)**: The starting point in the DNS hierarchy.
- **TLD (`com`)**: A generic top-level domain for commercial websites.
- **Second-Level Domain (`google`)**: The unique domain name for Google.
- **Subdomain (`www`)**: A subdomain that typically refers to the main website.
- **DNS Record (`A record`)**: Maps `www.google.com` to an IP address.

---

## Zone and Zone File

- **Zone**: A container of DNS records for a domain.
- **Zone File**: A file that holds these records.
- **Types:**
  - Primary (Master)
  - Secondary (Slave)
  - Reverse Zone
- **Nature of Zone:**
  - **Forward Lookup Zones**: Domain Name → IP Address
  - **Reverse Lookup Zones**: IP Address → Domain Name

---

## Types of Records in Zone File

- **NS (Name Server):** Helps in reading the zone file.
- **SOA (Start of Authority):** Helps create/delete records.
- **A Record:** Maps a domain name to an IPv4 address.
- **AAAA Record:** Maps a domain name to an IPv6 address.
- **CNAME:** Pointer for the alias.
- **PTR (Pointer):** Maps an IP address to a domain name.
- **MX (Mail Exchange):** Points to the organization's mail server.

---

## BIND and Installation

**BIND (Berkeley Internet Name Domain)** is a free, open-source DNS server that translates domain names into IP addresses.

### Commands:

**Installation:**
```bash
sudo apt update
sudo apt install bind9 bind9utils bind9-doc
```

**Enable the service:**
```bash
sudo systemctl enable bind9  # or sudo systemctl enable named
sudo systemctl start bind9   # or sudo systemctl start named
```

---

## Configure BIND9

Edit the configuration file:
```bash
sudo vim /etc/bind/named.conf.options
```

### Sample Configuration:
```conf
options {
    directory "/var/cache/bind";  // Directory for the BIND cache files
    allow-query { any; };         // Defines which hosts can query the server
    recursion yes;                // Enable recursion for caching DNS
    listen-on { any; };           // Listens on all interfaces
    listen-on-v6 { any; };        // Listen for IPv6 requests
};
```

---

## Configure Local Zone

Edit the local zone configuration:
```bash
sudo vim /etc/bind/named.conf.local
```

### Sample Zone Configuration:
```conf
zone "example.com" { 
    type master;  # Change to 'slave' for a secondary zone
    file "/etc/bind/db.example.com"; # Use master’s IP for slave
};
```

Replace `example.com` with the actual domain name.

---

## Configure / Creating Zone Files

Edit the zone file:
```bash
sudo vim /etc/bind/db.example.com
```

### Sample Zone File:
```conf
$TTL    604800
@       IN      SOA     ns1.example.com. admin.example.com. (
                              2025012801 ; Serial
                              86400      ; Refresh
                              7200       ; Retry
                              1209600    ; Expire
                              86400 )    ; Negative Cache TTL

; Name servers
        IN      NS      ns1.example.com.

; A records for the name servers
ns1     IN      A       192.168.1.1

; A records for your domain
@       IN      A       192.168.1.2
www     IN      A       192.168.1.2
```

---

## Check the Configuration

### Commands:
```bash
sudo named-checkconf
sudo named-checkzone example.com /etc/bind/db.example.com
```

Replace `example.com` and `db.example.com` accordingly.

### Expected Output (if successful):
```bash
zone example.com/IN: loaded serial 2025012801
OK
```

**Restart the service:**
```bash
sudo systemctl restart bind9  # or sudo systemctl restart named
```

---

## Client System Setup

Edit the resolver configuration:
```bash
sudo vim /etc/resolv.conf
```

### Add this line:
```conf
nameserver <IP of the DNS server>
```

---

## Verify the Server in Client System

### Command:
```bash
dig <domain.name>
# OR
dig @<IP of the DNS server> <domain.name>
```

### Example:
```bash
dig @192.168.5.136 google.com
```

---

## Suggestions to Improve DNS & BIND

- **Implement DNSSEC** for security against spoofing and cache poisoning.
- **Use Split-Horizon DNS** to serve different DNS records for internal and external networks.
- **Enable Logging and Monitoring** to track queries and detect anomalies.
- **Set Up Forwarders** to optimize query resolution by forwarding unknown requests to trusted external resolvers.
- **Use a Secondary (Slave) DNS Server** for redundancy and fault tolerance.
- **Optimize TTL Values** to balance caching efficiency and propagation speed.
- **Ensure Proper Firewall Rules** to allow only trusted DNS queries and zone transfers.

