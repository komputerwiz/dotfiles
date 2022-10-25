#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# check that we are running as root or sudo (effective uid = 0)
if [ $EUID -ne 0 ]; then
    echo "This script must be run as root." 1>&2
    exit 1
fi


# remove all existing entries
iptables -F INPUT


################
# IP BLACKLIST #
################

IP4_REGEX='\<[[:digit:]]{1,3}(\.[[:digit:]]{1,3}){3}\>'

for ip in $(grep -E "^$IP4_REGEX" "$DIR/blacklist" | sed -r "s/^($IP4_REGEX).*\$/\\1/"); do
    # Syntax to ban an IP address:
    # iptables -A INPUT -s xxx.xxx.xxx.xxx -j DROP
    iptables -A INPUT -s "$ip" -j DROP

    if [ $? -eq 0 ]; then
        echo "Blocked IP address: $ip"
    else
        echo "Unable to block IP address: $ip"
    fi
done
