# Base Centos To Install Nagios
FROM centos:latest
MAINTAINER Protheus <sauvage.jeff@gmail.com>

ENV PERL_MM_USE_DEFAULT 1

RUN yum -y update; yum clean all
RUN yum -y swap -- remove fakesystemd -- install systemd systemd-libs

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

RUN systemctl mask getty.target swap.target
RUN systemctl disable graphical.target; systemctl enable multi-user.target

VOLUME [ "/sys/fs/cgroup" ]

ENV container=docker

RUN yum update -y --nogpgcheck 
RUN yum install perl perl-CPAN perl-CGI perl-Digest-MD5 rrdtool perl-rrdtool perl-GD perl-Time-HiRes -y --nogpgcheck 

RUN yum install gcc glibc glibc-common gd gd-devel net-snmp net-snmp-utils openssl-devel wget unzip -y --nogpgcheck 
RUN yum install httpd php php-cli php-gd rrdtool-php -y --nogpgcheck

RUN yum install kernel-headers kernel-devel -y --nogpgcheck
RUN yum groupinstall "Development Tools" -y --nogpgcheck
RUN yum install which openssl openssl-libs -y --nogpgcheck

RUN cpan Module::Build'
RUN cpan Nagios::Config




CMD ["/usr/lib/systemd/systemd"]
