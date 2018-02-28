# CNI Installer

A docker image to install [CNI](https://github.com/containernetworking/cni) plugins.

## Plugins

The following plugins are available:

- [Standard CNI plugins](https://github.com/containernetworking/plugins) v0.7.0
  - bridge
  - dhcp
  - flannel
  - host
  - device
  - host
  - local
  - ipvlan
  - loopback
  - macvlan
  - portmap
  - ptp
  - sample
  - tuning
  - vlan
- [MULTUS](https://github.com/Intel-Corp/multus-cni) CNI plugin
  - multus

## Install

The container supports the installation of CNI plugin binaries as well as a
creation of CNI configuration files.

### Plugins

When the container is started, CNI plugins are installed to the directory
specified via the environment variable `INSTALL_DIR`, which defaults to
`/opt/cni/bin/`. This directory is supposed to be mounted into the container.

To just install a subset of plugins, pass the environment variable `PLUGINS`
to the container with a space-separated list of plugins:

```shell
docker run --rm -v /opt/cni/bin:/opt/cni/bin -e PLUGINS="ipvlan multus" travelping/cni-installer
```

### Configuration

Configuration file templates can be passed to the container via a mounted
directory (`$CONF_TEMPLATE_DIR`, default: `/config/`). For each file in that
directory, the installer does a simple environment variable replacement and
writes the result to the `$CONF_DIR` (default: `/ent/cni/net.d/`).

```shell
$ cat cni-templates/05-ipvlan.conf
{
        "name": "mynet",
        "type": "ipvlan",
        "master": "$DEV_MASTER",
        "ipam": {
                "type": "host-local",
                "subnet": "$SUBNET"
        }
}

$ docker run --rm -v /etc/cni/net.d:/etc/cni/net.d -v `pwd`/cni-templates:/config -e PLUGINS="ipvlan multus" -e "DEV_MASTER=eth2" -e "SUBNET=172.19.2.0/24" travelping/cni-installer
Installing ipvlan
Installing multus


###### /etc/cni/net.d/05-ipvlan.conf ######
{
        "name": "mynet",
        "type": "ipvlan",
        "master": "eth2",
        "ipam": {
                "type": "host-local",
                "subnet": "172.19.2.0/24"
        }
}
###############
```
