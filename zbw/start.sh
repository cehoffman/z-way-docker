#!/bin/sh

# Used to present shortcut links on find.z-wave.me if you are on the same
# network as the z-way-server
export ZBW_INTERNAL_IP=$PUBLIC_IP
export ZBW_INTERNAL_PORT=$PUBLIC_PORT
export ZBW_PASSWORD=$(cat /etc/zbw/passwd)
export ZBW_BOXTYPE=$(cat /etc/z-way/box_type)

# Used so a remote find.z-wave.me instance can access the z-way-server
FWD_OPTS="-R 0.0.0.0:10000:$ZWAY_PORT_8083_TCP_ADDR:$ZWAY_PORT_8083_TCP_PORT"
if [ -f /etc/zbw/flags/forward_ssh ]; then
  FWD_OPTS="$FWD_OPTS -R 0.0.0.0:10001:172.17.42.1:22"
fi

exec ssh -F /tmp/ssh_config -T zbw $FWD_OPTS
