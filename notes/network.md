DNS
===

## IPv4

Cloudflare
* 1.1.1.1
* 1.0.0.1

Google
* 8.8.8.8
* 8.8.4.4

## IPv6

Cloudflare
* 2606:4700:4700::1111
* 2606:4700:4700::1001

Google
* 2001:4860:4860::8888
* 2001:4860:4860::8844

SSH
===


## Disable IPv6 for specific host

```
Host example.com
    AddressFamily inet
```


Network Manager
===============

```
# <tab> completion works for these commands
nmcli device show <device>

nmcli connection show --active
nmcli connection edit <connection>

nmcli> remove ipv4.dns
nmcli> set ipv4.ignore-auto-dns yes
nmcli> set ipv4.dns 8.8.8.8 8.8.4.4 (or other dns servers)
nmcli> save
nmcli> quit

nmcli connection down <connection>
nmcli connection up <connection>
```

Source: https://askubuntu.com/questions/721080/how-to-change-dns-of-network-from-terminal#721107
