On such an Ubuntu system, installing LXC is as simple as:

```bash
sudo apt-get install lxc
```

Your system will then have all the LXC commands available, all its templates as well as the python3 binding should you want to script LXC.

Use the following command to check whether the Linux kernel has the required configuration:

```bash
lxc-checkconfig
```

Create Privileged Containers
Privileged containers are containers that are created by root and run as root.

Privileged containers are the easiest way to get started learning about and experimenting with LXC, but they may not be appropriate for production use. Depending on the host Linux distribution, privileged containers may be protected by some capability dropping, apparmor profiles, selinux context or seccomp policies but ultimately, the processes still run as root and so you should never give access to root inside a privileged container to an untrusted party. Even knowing that privileged containers are less secure, if you still must create privileged containers or they are specifically required for your use case, then creating them is quite simple. By default, LXC will create privileged containers.

Note that the terminal prompts we use here may be different than you see on your computer. The terminal prompts we use here emphasize if we are currently in a host shell or container shell and which user we are.

Create a privileged container with the following command. You can choose any container name that will be memorable for you. LXC's download template will help you select a container image available from https://images.linuxcontainers.org/

```bash
root@host:~# lxc-create --name mycontainer --template download
```

If you know the container image you want to use, you can specify the options to be sent to the download template. For example,

```bash
root@host:~# lxc-create --name mycontainer --template download -- --dist alpine --release 3.19 --arch amd64
```

After creating the container, you can start it.

```bash
root@host:~# lxc-start --name mycontainer
```

You can see status information about the container.

```bash
root@host:~# lxc-info --name mycontainer
```

You can see status information about all containers.

```bash
root@host:~# lxc-ls --fancy
```

Start a container shell.

```bash
root@host:~# lxc-attach --name mycontainer
```

Inside the container is where we really get a feeling for what a system container is and how it is like a lightweight virtual machine in many ways. The changes we make inside the container persist. If we later stop the container and restart it, our changes will still be there.

Explore the container.

```bash
root@mycontainer:~# cat /etc/os-release
```

Update the package index, upgrade installed packages, and install more packages you would like available.

```bash
root@mycontainer:~# apk update
root@mycontainer:~# apk add --upgrade apk-tools
root@mycontainer:~# apk upgrade --available
root@mycontainer:~# apk add vim python3
```

Exit the container shell.

```bash
root@mycontainer:~# exit
```

You can stop the container.

```bash
root@host:~# lxc-stop --name mycontainer
```

If you will never need the container again, then you can permanently destroy it.

```bash
root@host:~# lxc-destroy --name mycontainer
```
