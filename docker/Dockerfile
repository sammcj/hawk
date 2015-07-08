FROM opensuse:13.2
MAINTAINER Sam McLeod <smj(at)fastmail(dot)com>

# Configure zypper
RUN zypper addrepo http://download.opensuse.org/repositories/network:ha-clustering:Stable/openSUSE_13.2/network:ha-clustering:Stable.repo

# RUN zypper addrepo http://download.opensuse.org/repositories/network:/ha-clustering:/Factory/openSUSE_13.2/network:ha-clustering:Factory.repo

RUN zypper --non-interactive --gpg-auto-import-keys ref

# Remove existing systemd targets
#RUN rm -R /usr/lib/systemd/system/* 2>/dev/null
#RUN rm -R /usr/lib/systemd/system-generators/* 2>/dev/null
#RUN rm -R /etc/systemd/system/* 2>/dev/null
#RUN rm -R /etc/init.d/* 2>/dev/null

# Install hawk packages
RUN zypper --non-interactive install hawk hawk-templates ha-cluster-bootstrap
RUN zypper --non-interactive install rubygem-puma
RUN systemctl enable hawk
RUN systemctl enable pacemaker
RUN systemctl enable corosync

# Add new default target
RUN rm -rf /usr/lib/systemd/system/default.target /usr/lib/systemd/system/basic.target /usr/lib/systemd/system/sysinit.target /usr/lib/systemd/system/sshd.service /usr/lib/systemd/system/dbus.service /usr/lib/systemd/system/dbus.socket /usr/lib/systemd/system/default.target.wants

ADD default.target /usr/lib/systemd/system/default.target
ADD basic.target /usr/lib/systemd/system/basic.target
ADD sysinit.target /usr/lib/systemd/system/sysinit.target
ADD sshd.service /usr/lib/systemd/system/sshd.service
ADD dbus.service /usr/lib/systemd/system/dbus.service
ADD dbus.socket /usr/lib/systemd/system/dbus.socket

# Allow logins without audit kernel module.
RUN sed -r -n -i '/session(\s+)required(\s+)pam_loginuid/{s|^|#|};p'  /etc/pam.d/login
RUN sed -r -n -i '/session(\s+)required(\s+)pam_loginuid/{s|^|#|};p'  /etc/pam.d/sshd

ADD corosync.conf /etc/corosync/corosync.conf

# set password to hacluster
RUN echo -e "hacluster\nhacluster" | passwd hacluster


EXPOSE 22
EXPOSE 7630

# Link services into the default target.
RUN mkdir /usr/lib/systemd/system/default.target.wants
RUN ln -s /usr/lib/systemd/system/sshd.service /usr/lib/systemd/system/default.target.wants/sshd.service
RUN ln -s /usr/lib/systemd/system/dbus.socket /usr/lib/systemd/system/default.target.wants/dbus.socket
RUN ln -s /usr/lib/systemd/system/hawk.service /usr/lib/systemd/system/default.target.wants/hawk.service
RUN ln -s /usr/lib/systemd/system/pacemaker.service /usr/lib/systemd/system/default.target.wants/pacemaker.service
RUN ln -s /usr/lib/systemd/system/corosync.service /usr/lib/systemd/system/default.target.wants/corosync.service

# Force /var/run to be symlink'd to /run
RUN rm -Rf /var/run
RUN ln -s /run /var/run

# Link /init to systemd
RUN ln -s /bin/systemd /init

# Set /init as the default
CMD ["/init"]
