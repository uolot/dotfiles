# VPN setup

1. Install `aur/openvpn-update-systemd-resolved`
1. Enable with `systemctl enable --now systemd-resolved.service`
1. Create `auth-user-pass.txt` with VPN login in the first line and password in the second.
1. Add this to `client.ovpn`:

```
script-security 2
setenv PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
up /etc/openvpn/scripts/update-systemd-resolved
down /etc/openvpn/scripts/update-systemd-resolved
down-pre
auth-user-pass /path/to/auth-user-pass.txt
```
