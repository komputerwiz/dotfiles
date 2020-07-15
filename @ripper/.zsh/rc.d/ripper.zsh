alias startvpn='sudo systemctl start tamuvpn.service'
alias fvpn='sudo systemctl restart tamuvpn.service'
alias stopvpn='sudo systemctl stop tamuvpn.service'

alias vaultopen='sudo systemctl start mnt-vault.mount'
alias vaultclose='sudo systemctl stop systemd-cryptsetup@vault.service'
