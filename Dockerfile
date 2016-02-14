FROM ubuntu:trusty
MAINTAINER Dave P

# RUN sed -i -E 's/deb http:\/\/archive.ubuntu.com/deb http:\/\/debmirror.services.davepedu.com:8080/' /etc/apt/sources.list

# Create rduser (password is rduser)
RUN locale-gen en && \
    apt-get update && \
    apt-get -y install supervisor && \
    mkdir /var/run/mysqld && \
    echo "mariadb-server-5.5 mysql-server/root_password_again password root" | debconf-set-selections && \
    echo "mariadb-server-5.5 mysql-server/root_password password root" | debconf-set-selections && \
    apt-get -y install mariadb-server-5.5 mariadb-client-5.5 && \
    sed -i -E 's/bind-address\s+=.+$/bind-address = 0.0.0.0/' /etc/mysql/my.cnf

COPY supervisord-mariadb.conf /etc/supervisor/conf.d/mariadb.conf
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD start /start

EXPOSE 3306

# ENTRYPOINT ["/start"]
