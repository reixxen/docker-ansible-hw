запустить контейнер postresql и пробросить volume /home/vasa/data/:/data/pg

убить контейнер не трогая примонтированный /home/vasa/data

посмотреть содержимое каталога /home/vasa/data

перенести каталог /home/vasa/data в любую другую директорию и снова запусти postresql c новые путём /home/{{newpath}}/data

В репозитории должна быть команда по запуску.

Цель задания:
Научиться создавать персистентное хранилище данных для контейнера PostgreSQL, обеспечивая сохранность данных при перезапуске или удалении контейнера.

Шаги выполнения:
Скачивание образа PostgreSQL:
Используйте команду docker pull postgres, чтобы скачать официальный образ PostgreSQL из Docker Hub.
Запуск контейнера с Volume:
Необходимо запустить контейнер PostgreSQL, пробросив Volume для сохранения данных.
Тестирование персистентности:
Удалите контейнер, не трогая ранее созданный Volume.
Проверьте, что данные не потеряны.
Перенос данных:
Переместите содержимое папки в другую директорию.
Запустите новый контейнер PostgreSQL, указав новый путь к данным.
# 1. Скачивание образа PostgreSQL
docker pull postgres:latest
# 2. Запуск контейнера с Volume
docker run -d \
  --name postgres-container \
  -e POSTGRES_PASSWORD=mysecretpassword \
  -e POSTGRES_DB=mydatabase \
  -v /home/vasa/data/:/var/lib/postgresql/data \
  -p 5432:5432 \
  postgres:latest
# 3. Тестирование работы (опционально)
## Подключиться к контейнеру и создать тестовые данные
docker exec -it postgres-container psql -U postgres -d mydatabase
## В psql выполнить:
CREATE TABLE test_table (id SERIAL PRIMARY KEY, name VARCHAR(100));
INSERT INTO test_table (name) VALUES ('test data');
SELECT * FROM test_table;
\q
# 4. Остановка и удаление контейнера (без удаления данных)
## Останавливаем контейнер
docker stop postgres-container
## Удаляем контейнер (данные остаются в /home/vasa/data)
docker rm postgres-container
# 5. Проверка содержимого каталога данных
ls -la /home/vasa/data/
# 6. Перенос данных в новую директорию
## Создаем новую директорию
sudo mkdir -p /home/newuser/data
## Копируем данные (используем sudo для сохранения прав)
sudo cp -r /home/vasa/data/* /home/newuser/data/
## Или перемещаем данные
sudo mv /home/vasa/data/* /home/newuser/data/
# 7. Запуск нового контейнера с новым путем
docker run -d --name postgres-new -e POSTGRES_PASSWORD=mysecretpassword -e POSTGRES_DB=mydatabase -v /home/newuser/data:/var/lib/postgresql/data -p 5432:5432 postgres:latest
# 8. Проверка сохранности данных
## Подключаемся к новому контейнеру и проверяем данные
docker exec -it postgres-new psql -U postgres -d mydatabase -c "SELECT * FROM test_table;"
