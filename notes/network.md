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
