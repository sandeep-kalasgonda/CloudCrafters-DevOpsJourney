# Multipass Run Notes on Ubuntu

## Prerequisites

Ensure Ubuntu is installed and up to date:
```sh
sudo apt update && sudo apt upgrade -y
```

Install snapd if it’s not already installed:
```sh
sudo apt install snapd
```

## Installing Multipass

Use the Snap package manager to install Multipass:
```sh
sudo snap install multipass
```

Verify the installation:
```sh
multipass --version
```

## Basic Multipass Commands

### Launch an Instance

Create and start an Ubuntu VM:
```sh
multipass launch --name <instance-name>
```

Example:
```sh
multipass launch --name my-instance
```

### List Instances

View all running and stopped instances:
```sh
multipass list
```

### Access an Instance

SSH into a running instance:
```sh
multipass shell <instance-name>
```

Example:
```sh
multipass shell my-instance
```

### Stop an Instance

Stop a running instance:
```sh
multipass stop <instance-name>
```

### Delete an Instance

Remove an instance completely:
```sh
multipass delete <instance-name>
```

Followed by:
```sh
multipass purge
```

## Network Configuration

To configure network bridging or connect instances to specific network interfaces, refer to the official Multipass documentation: [Multipass Networking Guide](https://multipass.run/docs/networking)

## Example Workflow

Launch a VM:
```sh
multipass launch --name test-instance
```

SSH into the VM:
```sh
multipass shell test-instance
```

Install a package inside the instance:
```sh
sudo apt install nginx
```

Stop and delete the instance when done:
```sh
multipass stop test-instance
multipass delete test-instance
multipass purge
```

## Mounting Volume

### Example Workflow

Start by launching an instance if it’s not already running:
```sh
multipass launch --name my-instance
```

Mount a local directory:
```sh
multipass mount ~/my-data my-instance:/home/ubuntu/my-data
```

Access the instance and verify the mount:
```sh
multipass shell my-instance
cd /home/ubuntu/my-data
ls
```

Unmount the directory when done:
```sh
multipass umount my-instance
```

## Troubleshooting Tips

### Mount Path Not Accessible

Ensure the instance is running. Start the instance with:
```sh
multipass start <instance-name>
```

### Permission Denied on Local Directory

Make sure you have the proper permissions to access the local directory on your host machine.

### Unmount Issues

If unmounting fails, stop the instance first:
```sh
multipass stop <instance-name>
```

Then attempt unmounting again.

## Key Notes

- You can mount multiple directories to the same instance.
- Use full paths for better reliability when specifying the `<local-path>`.
- The changes made in the mounted directory on either the host or the instance will reflect immediately on both sides.

## Multipass Network Types and Run Notes

### Overview

Multipass instances use virtual networks to connect with the host machine and external networks. By default, Multipass instances use NAT (Network Address Translation), but other configurations like Bridged Networking can be set up for advanced use cases.

### Types of Networks

#### NAT Networking (Default)

- Instances share the host machine’s network connection.
- No additional configuration is needed.
- Allows internet access for instances via the host.

#### Bridged Networking

- Directly connects the instance to the same network as the host.
- Requires additional configuration with a bridged network adapter.
- Useful for assigning instances their own IP addresses on the LAN.

#### Host-Only Networking

- Used for communication between the host and the instances only.
- Instances cannot access the internet.

#### Custom Networks

- Advanced configurations to set up specific virtual network adapters.
- Requires manual setup using KVM and related tools.

### Network Run Notes

#### 1. Default NAT Network

The default network setup requires no manual configuration. Simply launch an instance:
```sh
multipass launch --name my-instance
```

Verify network connectivity:
```sh
multipass exec my-instance -- ping -c 3 google.com
```

#### 2. Bridged Networking

**Prerequisites:**

- Ensure you have a bridged adapter available.
- Check your network interfaces:
    ```sh
    ip link show
    ```

**Steps to Configure Bridged Networking:**

1. Identify your host’s network interface (e.g., `enp0s3`).
2. Launch the instance with the `--network` flag:
     ```sh
     multipass launch --name my-instance --network enp0s3
     ```

Verify the instance has a bridged IP address:
```sh
multipass exec my-instance -- ip addr
```

#### 3. Host-Only Networking

**Steps to Configure Host-Only Networking:**

1. Create a custom virtual bridge on the host machine.
2. Use `netplan` or `brctl` to configure the bridge. Example for `netplan`:
     ```yaml
     network:
         version: 2
         renderer: networkd
         bridges:
             br0:
                 interfaces: []
                 addresses:
                     - 192.168.56.1/24
     ```

Launch the instance using the custom bridge:
```sh
multipass launch --name my-instance --network br0
```

### Example Commands for Network Management

#### List Available Networks

Check available networks on your host machine:
```sh
multipass networks
```

#### Assign a Specific Network to an Instance

Use the `--network` flag during instance creation:
```sh
multipass launch --name my-instance --network <network-name>
```

#### Check Network Configuration Inside an Instance

Access the instance and check its network settings:
```sh
multipass shell my-instance
ip addr
```

### Troubleshooting Tips

#### Instance Cannot Connect to the Internet

- Ensure the host machine has internet connectivity.
- Restart the instance:
    ```sh
    multipass restart my-instance
    ```

Verify DNS resolution inside the instance:
```sh
nslookup google.com
```

#### Bridged Networking Fails

- Ensure the bridged interface on the host is active.
- Check permissions for multipass to use the bridge.

#### Host-Only Network is Unreachable

- Verify the virtual bridge is correctly configured.
- Restart `multipassd` to reload network settings:
    ```sh
    sudo systemctl restart multipassd
    ```

## Key Notes

- NAT networking is sufficient for most use cases (e.g., internet access).
- Bridged networking is ideal for direct access from other devices on the same LAN.
- Custom networks require expertise with tools like KVM, netplan, or iptables.

For more detailed information, refer to the official Multipass documentation: [Multipass Documentation](https://multipass.run/docs)
