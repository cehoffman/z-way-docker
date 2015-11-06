# About

This is [z-way-server](http://razberry.z-wave.me/index.php?id=24) packaged as
a set of docker containers for installation on
[Hypriot](http://blog.hypriot.com/). The standard firmware upgrade of z-way
**SHOULD NOT** be used to upgrade this installation. Instead `ZWAY_VERSION` in
[server/Dockerfile](server/Dockerfile) should be changed to the new version and
the server image rebuilt.

# Installation

The current installation method has several manual steps that could be
automated fairly easily.

1. Install Hypriot on a PI

2. Clone this repository to the PI.

    ~~~sh
    docker build -t z-way/base:2 base
    docker build -t z-way/server:2.1.1 server
    docker build -t z-way/webif:2.1.1 webif
    docker build -t z-way/zbw:2.1.1 zbw
    ~~~

3. Copy your current z-way server configuration to a USB stick as follows.

| Source                                     | USB Destination                  |
| ---                                        | ---                              |
| /opt/z-way-server/automation/storage       | current/automation/storage       |
| /opt/z-way-server/automation/userModules   | current/automation/userModules   |
| /opt/z-way-server/config/Configuration.xml | current/config/Configuration.xml |
| /opt/z-way-server/config/Rules.xml         | current/config/Rules.xml         |
| /opt/z-way-server/config/maps              | current/config/maps              |
| /opt/z-way-server/config/zddx              | current/config/zddx              |
| /etc/zbw                                   | current/zbw                      |
| /tmp/zbw_connect.priv                      | current/zbw/id_rsa.key           |

4. Automount the USB stick to /mnt/z-way on boot. There are a few tutorials
   already out there covering this, but the gist is find the UUID of the USB
   stick and add an entry to fstab to mount it. This assumes the drive is
   formated with an ext4 filesystem.

   ~~~sh
   sudo blkid # find the UUID of the usb device
   echo "UUID=<found uuid> /mnt/z-way ext4 auto,defaults 0 1" | cat /etc/fstab - | sudo tee /etc/fstab
   ~~~

5. Delete any parameter options referencing `ttyAMA0` in **/boot/cmdline.txt**.

6. Reboot to make `/dev/ttyAMA0` available for z-way usage.

7. Enable systemd services to keep z-way running

    ~~~sh
    sudo systemd enable $PWD/server/z-way-server.service
    sudo systemd start z-way-server

    sudo systemd enable $PWD/zbw/zbw.service
    sudo systemd start zbw
    ~~~

# Notes

The Mongoose configuration server image (webif) is included here, but it is
advised not to use it because it is offers alternative ways of control system
settings that this container process tries to control, e.g. timezone
configuration.

[init](init) was made with the assumption that it is run from a remote computer
trying to initialize system settings and install system services in step 4.
