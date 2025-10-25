Необходимо написать docker-stack, который:

Поднимает nginx равный числу нод
Конфиг в nginx подкладывается как config
Поднимает postgres, привязанный к ноде с определённым лейблом (placement, constraints) и прокидывает Volumes
Все они используют одну overlay network

## Описание
deploy.mode: global для nginx — это означает один nginx на каждой ноде автоматически (не нужно указывать replicas).
Для публикации порта 80 на каждой ноде указан ports с mode: host. Если использовать Traefik/ингресс-меш и балансировку по всем нодам, можно опустить mode: host и использовать mode: ingress
postgres имеет placement.constraints — у нас это node.labels.pg == true. Нода должна иметь этот лейбл.
Volume pgdata использует driver_opts с type: none и device: /srv/postgres/data — это bind-mount каталога на хосте. каталог /srv/postgres/data должен существовать и быть доступным на той ноде, где будет запущен postgres (иначе Docker не сможет смонтировать).

## стек делает следующее:
поднимает nginx в режиме global (по одному контейнеру на каждую ноду — т. е. «равный числу нод»)
конфиг nginx подаётся как Docker config с именем config
поднимает postgres на ноду с заданным лейблом (через placement.constraints) и прокидывает persistent volume, который смонтируется в каталог на той ноде
все сервисы подключены к одной overlay сети.

## создание Docker Config, Secret и задеплоить стек
При необходимости пометьте нужную ноду лейблом (на менеджере):

пример: помечаем ноду с hostname node-1
docker node update --label-add pg=true node-1

## cоздать Docker config с именем config (имя должно совпадать с тем, что в stack-файле):
docker config create config ./nginx.conf

## Создать secret для пароля Postgres:
docker secret create pg_password ./pg_password.txt

## Деплой стека:
docker stack deploy -c docker-stack.yml mystack
