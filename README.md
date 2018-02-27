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
- [MULTUS](https://github.com/Intel-Corp/multus-cni)

## Install

When the container is started, CNI plugins are installed to the directory specified via the environment variable `INSTALL_DIR`, which defaults to `/opt/cni/bin/`. This directory is supposed to be mounted into the container.

To just install a subset of plugins, pass the environment variable `PLUGINS` to the container with a space-separated list of plugins:

```shell
docker run --rm -v /opt/cni/bin:/opt/cni/bin -e PLUGINS="ipvlan multus" travelping/cni-installer
```
