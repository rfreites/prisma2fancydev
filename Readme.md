# [Docker image for Prisma2 developers (ronnf89/prisma2fancydev)](https://hub.docker.com/r/ronnf89/prisma2fancydev/)

This image extends [node:latest](https://hub.docker.com/_/node/) oficial image and adds:
- [Prisma Framework](https://github.com/prisma/prisma2)

# How to use this image
The basic pattern for starting an Prisma2 instance is:
```sh
$ docker run --name some-prisma2 -d ronnf89/prisma2fancydev
```
If you'd like to be able to access the instance from the host without the container's IP, standard port mappings can be used:

Map the corresponding port according to the case and DEPLOY_ENV variable `prod` and `dev` and empty
```sh
$ docker run --name some-prisma2 -p 8000:4000 ronnf89/prisma2fancydev
```
Deploy on detach mode add `-d` flag
```sh
$ docker run --name some-prisma2 -p 8000:4000 -d ronnf89/prisma2fancydev
```
Then, access it via http://localhost:8000 or http://host-ip:8000 in a browser.

There are multiple database types supported by this image, most easily used via standard container linking. In the default configuration, SQLite can be used to avoid a second container and write to flat-files. More detailed instructions for different (more production-ready) database types follow.

When first accessing the webserver provided by this image, it will go through a brief setup process. The details provided below are specifically for the "Set up database" step of that configuration process.

# Prisma2
By default, prisma2 CLI into a running container as the following command:

```sh
$ docker exec CONTAINER_ID prisma2 --help
```

# MySQL
```sh
$ docker run --name some-prisma2 --link some-mysql:mysql -d ronnf89/prisma2fancydev
```
- Database type: MySQL, MariaDB, or equivalent
- Database name/username/password: <details for accessing your MySQL instance> (MYSQL_USER, MYSQL_PASSWORD, MYSQL_DATABASE; see environment variables in the description for mysql)
- ADVANCED OPTIONS; Database host: mysql (for using the /etc/hosts entry added by --link to access the linked container's MySQL instance)

# PostgreSQL
```sh
$ docker run --name some-prisma2 --link some-postgres:postgres -d ronnf89/prisma2fancydev
```
- Database type: PostgreSQL
- Database name/username/password: <details for accessing your PostgreSQL instance> (POSTGRES_USER, POSTGRES_PASSWORD; see environment variables in the description for postgres)
- ADVANCED OPTIONS; Database host: postgres (for using the /etc/hosts entry added by --link to access the linked container's PostgreSQL instance)

# Volumes
By default, this image does not include any volumes.

This can be bind-mounted into a new container:

```sh
$ docker run --name some-prisma2 --link some-postgres:postgres -d \
    -v /path/on/host/app:/src/app \
    ronnf89/prisma2fancydev
```

- add .env file at the root of your project with the following lines

- Run dev environment
```sh
DEPLOY_ENV=dev
```

- Run prod environment
```sh
DEPLOY_ENV=prod
```

- add docker-compose.yml file at the root of your project with the following lines.

```sh
version: '3.1'

networks:
  adonisjs:
    external: false

services:
  app:
    image: ronnf89/prisma2fancydev
    volumes:
      - .:/src/app
      - /var/www/node_modules
    depends_on:
      - postgres
    environment:
      - DEPLOY_ENV=dev
      # - DEPLOY_ENV=prod
    ports:
      - 8080:4000
  studio:
    image: ronnf89/prisma2fancydev
    volumes:
      - .:/src/app
      - /var/www/node_modules
    depends_on:
      - postgres
    environment:
      - DEPLOY_ENV=studio
    ports:
      - 8082:5555

  postgres:
    image: postgres
    environment:
      - POSTGRES_PGDATA=/var/lib/postgresql/data/pgdata
      - POSTGRES_USER=${DB_USER}
      - POSTGRES_PASSWORD=${DB_PASSWORD}
      - POSTGRES_DB=${DB_DATABASE}
    restart: always
    volumes:
      - db-data:/var/lib/postgresql/data
volumes:
  db-data: {}
```

- Run command at your project root:
```sh
$ docker-compose up -d
```

Now you can access to your differents container services.

- prod or dev: http://localhost:4000
- Prisma Studio: http://localhost:5000


Thanks for read me, please share me to your adonisjs community.

License
----

MIT


**Free Software, Hell Yeah!**