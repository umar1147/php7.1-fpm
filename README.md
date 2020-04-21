# PHP 7.3-fpm

**Base image:** `php:7.3.17-fpm`

**WORKDIR:** `/www`

Add **aws-env** util form AWS SSM ([aws-env](https://github.com/Droplr/aws-env/))

# Docker compose (example)

docker-compose.yml
```yml
version: '3'

services:
  app:
    image: umar1147:php7.3-fpm
    volumes:
      - ./:/www
    env_file:
```