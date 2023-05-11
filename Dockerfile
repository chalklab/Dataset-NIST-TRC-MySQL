# this file is designed based on the idea of multi-stage builds
# see https://docs.docker.com/build/building/multi-stage/ for more information on why this is a good build pattern

# temporary build stage

# start with the latest mysql Docker image from Dockerhub (dockethub.com)
# (debian just requests a specific operating system - this is not critical)
# for options see https://hub.docker.com/_/mysql
# the "as" option here allows use to refer to this 'temporary' image
FROM mysql:debian as dumper

# these define environment variables used in the image (https://docs.docker.com/engine/reference/builder/#env)
ENV MYSQL_DATABASE=trc
ENV MYSQL_ROOT_PASSWORD=trcroot
ENV MYSQL_USER=trcuser
ENV MYSQL_PASSWORD=trcpass

# we 'add' the compressed (using gzip) SQL data file to the special folder 'docker-entrypoint-initdb.d'
# when the image is created anything in this folder is processed automatically
# in this case, the SQL file is copied, uncompressed, and then loaded into mysql as database 'trc' (see ENV above)
COPY mysql/trcv2_mysql8.sql /docker-entrypoint-initdb.d

# this command disables some automated scripts not needed in this temporary build stage
RUN ["sed", "-i", "s/exec \"$@\"/echo \"skipping...\"/", "/usr/local/bin/docker-entrypoint.sh"]

# switch the user 'mysql' and run the mysqld daemon configuring mysql with the ENV variables above
USER mysql
RUN ["/usr/local/bin/docker-entrypoint.sh", "mysqld"]

# final build stage - this is the image that is actually created and takes the data from the temporaru build above
FROM mysql:debian
ENV MYSQL_DATABASE=trc
ENV MYSQL_ROOT_PASSWORD=trcroot
ENV MYSQL_USER=trcuser
ENV MYSQL_PASSWORD=trcpass

# copy data added/created to/in the temporary image above to this final image
COPY --from=dumper /var/lib/mysql /data
RUN rm -rf /var/lib/mysql/*
RUN mv /data/* /var/lib/mysql/

# if you have installed Docker Desktop (DD) on your computer (https://www.docker.com/products/docker-desktop/)
# you can go to the command line, change directory to this folder, and run the following command to create the image
# 'docker build -t dockerimage:latest .' OR 'docker build --platform linux/amd64 -t dockerimage:latest .' on Apple M1/M2
# the image will then show up in DD under images and you can click 'Run' to try it out
# (there is no need to enter anything in the dialog box that comes up) - this creates a container with a random name
# to run commands, click 'Containers' in DD and then click on the container you see there
# then click on 'terminal' and at the command line type in 'mysql -u trcuser -ptrcpass trc'
# this takes you into mysql and you can show the tables in the database by typing 'show tables;'