Создать файл index.html с любым содержимом на выбор

Написать Dockerfile базирующийся на nginx, в который положить файл в конфиге в уроке в /etc/nginx/conf.d/default.conf. Сам html файл положить в /usr/share/nginx/html:


server {
    listen 80;
    root /usr/share/nginx/html;

    location / {
        index index.html index.htm;
        try_files $uri $uri/ /index.html =404;
    }

    error_page 404 /index.html;
    location = /404 {
        return 404;
    }
}


Запустить контейнер, зайти в него и сделать curl на 80 порт, получив в ответ файл

В репозитории должен быть Dockerfile для сборки.
