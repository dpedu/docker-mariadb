FROM ubuntu:xenial

# RUN sed -i -E 's/deb http:\/\/archive.ubuntu.com/deb http:\/\/debmirror.services.davepedu.com:8080/' /etc/apt/sources.list

RUN set -x && \
    apt-get update && \
    apt-get install -y software-properties-common && \
    apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8 && \
    add-apt-repository 'deb [arch=amd64] http://nyc2.mirrors.digitalocean.com/mariadb/repo/10.2/ubuntu xenial main' && \
    apt-get update && \
    mkdir /var/run/mysqld && \
    echo "mariadb-server-10.2 mysql-server/root_password_again password root" | debconf-set-selections && \
    echo "mariadb-server-10.2 mysql-server/root_password password root" | debconf-set-selections && \
    apt-get install -y mariadb-server-10.2 mariadb-client-10.2 && \
    sed -i -E 's/bind-address\s+=.+$/bind-address = 0.0.0.0/' /etc/mysql/my.cnf && \
    chown -R mysql:mysql /var/run/mysqld && \
    rm -rf /var/lib/apt/lists/*

ADD start /start

EXPOSE 3306

ENTRYPOINT ["/start"]

VOLUME /var/lib/mysql

USER mysql
