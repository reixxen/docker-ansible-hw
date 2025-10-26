#!/bin/bash

DATA_DIR="/home/newuser/data"
CONTAINER_NAME="postgres-container"
POSTGRES_PASSWORD="mysecretpassword"
POSTGRES_DB="mydatabase"
PORT="5432"

if [ ! -d "$DATA_DIR" ]; then
    echo "Ошибка: Директория $DATA_DIR не существует"
    exit 1
fi

docker run -d \
  --name $CONTAINER_NAME \
  -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD \
  -e POSTGRES_DB=$POSTGRES_DB \
  -v $DATA_DIR:/var/lib/postgresql/data \
  -p $PORT:5432 \
  postgres:latest

echo "PostgreSQL контейнер запущен:"
echo "  Имя контейнера: $CONTAINER_NAME"
echo "  Директория данных: $DATA_DIR"
echo "  Порт: $PORT"
