# Docker

## Add user to docker group (sudo-less docker commands)

```
# usermod -a -G docker $USER
```

## Run mysql client inside docker container

```
$ docker-compose -f yml/test.yml run mysql /bin/bash
# mysql --host=mysql --user=root db_test
```


# Docker Compose

Equivalent of docker's `-i -t`:

```
stdin_open: true
tty: true
```
