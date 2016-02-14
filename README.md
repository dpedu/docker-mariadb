docker-mariadb
==============

MariaDB (mysql) in a container.

Suggested usage: `docker run -d -p 3306:3306 -v /host/overrides.conf:/etc/mysql/conf.d/overrides.conf -v /host/sqldata:/var/lib/mysql mariadb`

Tips
----

* Change mysql listening port by setting the env var MYSQL_PORT.
