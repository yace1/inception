
FROM debian:bullseye-slim

ENV DEBIAN_FRONTEND=noninteractive

# Install gnupg2 package
RUN apt-get update && apt-get install -y gnupg2

# Import MariaDB GPG key
RUN apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xF1656F24C74CD1D8

# Add MariaDB repository
RUN echo "deb [arch=amd64] http://mirror.nodesdirect.com/mariadb/repo/10.6/debian bullseye main" > /etc/apt/sources.list.d/mariadb.list

# Install MariaDB server
RUN apt-get update && apt-get install -y mariadb-server

COPY ./conf/my.cnf 							/etc/mysql/my.cnf
COPY ./conf/bootstrap.sh 					/usr/local/bin/bootstrap.sh
COPY ./conf/create_mariadb_admin_user.sh	/usr/local/bin/create_mariadb_admin_user.sh
RUN chmod +x /usr/local/bin/*


ENV MYSQL_BIND_ADDRESS=0.0.0.0
ENV MYSQL_PORT=3306
#ENV MYSQL_ADMIN_PASS=
#ENV MYSQL_ADMIN_USER=
ENV MYSQL_ADMIN_HOST=%

# Add volumes
VOLUME  ["/etc/mysql", "/var/lib/mysql"]

# Expose ports
EXPOSE 3306

# Run bootstrap
CMD ["/usr/local/bin/bootstrap.sh"]