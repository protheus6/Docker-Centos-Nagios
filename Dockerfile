# Base Centos To Install Nagios
FROM centos/systemd:latest
MAINTAINER Protheus <sauvage.jeff@gmail.com>

ENV PERL_MM_USE_DEFAULT 1

RUN yum -y update; yum clean all


RUN yum update -y --nogpgcheck 
RUN yum install perl perl-CGI perl-Digest-MD5 rrdtool perl-rrdtool perl-GD perl-Time-HiRes cpanminus -y --nogpgcheck 

RUN yum install gcc glibc glibc-common gd gd-devel net-snmp net-snmp-utils openssl-devel wget unzip -y --nogpgcheck 
RUN yum install httpd php php-cli php-gd rrdtool-php php-pear php-mysql -y --nogpgcheck

RUN yum install kernel-headers kernel-devel -y --nogpgcheck
RUN yum groupinstall "Development Tools" -y --nogpgcheck
RUN yum install mailx which openssl openssl-libs nmap sudo -y --nogpgcheck

RUN yum install mariadb mariadb-server -y --nogpgcheck

RUN yum clean all


RUN systemctl enable mariadb


VOLUME [ "/sys/fs/cgroup" ]



CMD ["/usr/sbin/init"]
