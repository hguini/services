FROM	alpine:3.12

RUN		apk add mariadb mariadb-client supervisor\
		telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted --no-cache && \
		mkdir -p /run/mysqld/

COPY	./supervisor.conf /etc/supervisord.conf
COPY 	./telegraf.conf /etc/telegraf/
COPY	./my.cnf			/etc/
COPY	./wordpress.sql		/
COPY	./start_mysql.sh	/

EXPOSE 3306

VOLUME ["var/lib/mysql"]

ENTRYPOINT	sh start_mysql.sh