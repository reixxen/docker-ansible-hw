# Docker Swarm stack: nginx + postgres

## Необходимо написать docker-stack, который

- Поднимает nginx равный числу нод
- Конфиг в nginx подкладывается как config
- Поднимает postgres, привязанный к ноде с определённым лейблом (placement, constraints) и прокидывает Volumes
- Все они используют одну overlay network

## Описание

- deploy.mode: global для nginx — один nginx на каждой ноде автоматически (не нужно указывать replicas).
- Для публикации порта 80 на каждой ноде указан ports с mode: host. Если использовать Traefik/ингресс-меш и балансировку по всем нодам, можно опустить mode: host и использовать mode: ingress
- postgres имеет placement.constraints — у нас это node.labels.pg == true. Нода должна иметь этот лейбл.
- Volume pgdata использует driver_opts с type: none и device: /srv/postgres/data — это bind-mount каталога на хосте. каталог /srv/postgres/data должен существовать и быть доступным на той ноде, где будет запущен postgres (иначе Docker не сможет смонтировать).

## Стек делает следующее

- поднимает nginx в режиме global (по одному контейнеру на каждую ноду — т. е. «равный числу нод»)
- конфиг nginx подаётся как Docker config с именем config
- поднимает postgres на ноду с заданным лейблом (через placement.constraints) и прокидывает persistent volume, который смонтируется в каталог на той ноде
- все сервисы подключены к одной overlay сети.

## Подготовка перед деплоем

### Назначить лейбл нужной ноде

```bash
docker node update --label-add pg=true node-1
```

### Создать каталог для volume на ноде pg=true

```bash
ssh node-1 "sudo mkdir -p /srv/postgres/data && sudo chown -R 999:999 /srv/postgres/data"
```

### Создание config и secret

```bash
docker config create nginx_config ./nginx.conf
docker secret create pg_password ./pg_password.txt
```

Файл pg_password.txt должен содержать только пароль.

## Деплой стека

```bash
docker service ls
docker service ps mystack_nginx
docker service ps mystack_postgres
```
