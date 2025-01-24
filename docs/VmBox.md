# Installing VirtualBox using CLI Commands in Ubuntu

This README provides a step-by-step guide to installing VirtualBox on Ubuntu using the command line interface (CLI).

## Prerequisites

- A running instance of Ubuntu (version 20.04 or later is recommended).
- A user account with `sudo` privileges.

## Steps to Install VirtualBox

### Step 1: Update the System
Ensure your system is up-to-date:

```bash
sudo apt update
sudo apt upgrade -y
```

### Step 2: Add the VirtualBox Repository

1. Import the Oracle VirtualBox public key:

```bash
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
```

2. Add the VirtualBox repository to your system:

```bash
echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
```

### Step 3: Install VirtualBox

1. Update the package list to include the new repository:

```bash
sudo apt update
```

2. Install VirtualBox. Replace `<version>` with the desired version (e.g., `7.0`):

```bash
sudo apt install virtualbox-<version>
```

For example, to install version 7.0:

```bash
sudo apt install virtualbox-7.0
```

### Step 4: Verify the Installation

1. Check the installed VirtualBox version:

```bash
virtualbox --version
```

2. Launch VirtualBox:

```bash
virtualbox
```

## Optional: Install the VirtualBox Extension Pack

1. Download the Extension Pack matching your VirtualBox version from the [official VirtualBox website](https://www.virtualbox.org/wiki/Downloads).

2. Install the Extension Pack using the following command, replacing `<version>` with your VirtualBox version:

```bash
sudo VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-<version>.vbox-extpack
```

3. Confirm the installation:

```bash
VBoxManage list extpacks
```

## Troubleshooting

- If you encounter issues during installation, ensure that all dependencies are met:

```bash
sudo apt install -f
```

- For kernel module errors, rebuild the VirtualBox kernel modules:

```bash
sudo /sbin/vboxconfig
```

## Uninstalling VirtualBox

To remove VirtualBox completely from your system:

```bash
sudo apt remove --purge virtualbox*
sudo apt autoremove -y
```

## Additional Resources

- [VirtualBox Official Documentation](https://www.virtualbox.org/wiki/Documentation)
- [Ubuntu Community Help Wiki](https://help.ubuntu.com/community/VirtualBox)

