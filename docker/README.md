Usage
----------

To run this image:

    docker run 
      -d \
      --privileged \
			--cap-add IPC_LOCK \
			-p 7630:7630 \
      -P \
      -v /sys/fs/cgroup:/sys/fs/cgroup \
      ClusterLabs/hawk \
      /init

What do these parameters do?

    -d = detach from tty
    --privileged = allow capabilities, dbus requires this to lower permissions
    -P = map exposed ports over NAT
    -v = map cgroups, systemd requires this to function
    hachque/systemd-boot = the name of this image
    /init = start systemd

SSH / Login
--------------

**Username:** root

**Password:** linux
