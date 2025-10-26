# Vagrant Multi-Server Environment

Этот проект создает локальную среду из 5 виртуальных машин с Ubuntu 20.04 с помощью Vagrant и VirtualBox.

## Описание

Vagrantfile автоматически разворачивает 5 виртуальных машин со следующими характеристиками:

- **Имена машин**: server1, server2, server3, server4, server5
- **ОС**: Ubuntu 20.04 LTS
- **Память**: 2 GB RAM каждая
- **CPU**: 1 vCPU каждая
- **Сеть**: Приватная сеть с IP адресами 10.11.10.1 - 10.11.10.5

## Предварительные требования

Перед использованием убедитесь, что установлены:

- [Vagrant](https://www.vagrantup.com/downloads) (версия 2.0+)
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- SSH ключи (должны быть сгенерированы в `~/.ssh/id_rsa.pub`)

## Использование

1. Клонируйте репозиторий или сохраните Vagrantfile в отдельную директорию
2. Откройте терминал в директории с Vagrantfile
3. Выполните команду:

```bash
vagrant up
```

## Доступ к виртуальным машинам

### Через SSH

Для доступа к конкретной машине используйте:

```bash
# Для server1
vagrant ssh server1

# Для server2  
vagrant ssh server2

# И так далее для server3, server4, server5
```

Или используйте прямое SSH подключение через указанные порты:

```bash
# server1
ssh vagrant@localhost -p 2223

# server2
ssh vagrant@localhost -p 2224

# server3
ssh vagrant@localhost -p 2225

# server4  
ssh vagrant@localhost -p 2226

# server5
ssh vagrant@localhost -p 2227
```

## Сетевые настройки

SSH порты: 2223-2227 (соответственно server1-server5)

Приватная сеть: 10.11.10.1-10.11.10.5

Хостовые имена: server1.local, server2.local, etc.

Структура виртуальных машин

| Машина | IP адрес   | SSH порт | Хостовое имя |
| ------ | ---------- | -------- | ------------ |
|server1 | 10.11.10.1 | 2223     | server1      |
|server2 | 10.11.10.2 | 2224     | server2      |
|server3 | 10.11.10.3 | 2225     | server3      |
|server4 | 10.11.10.4 | 2226     | server4      |
|server5 | 10.11.10.5 | 2227     | server5      |

### Управление виртуальными машинами

- Запуск всех машин

```bash
vagrant up
```

- Запуск конкретной машины

```bash
vagrant up server1
```

- Остановка всех машин

```bash
vagrant halt
```

- Остановка конкретной машины

```bash
vagrant halt server1
```

- Перезагрузка машин

```bash
vagrant reload
```

- Удаление машин

```bash
vagrant destroy
```

- Проверка статуса

```bash
vagrant status
```
