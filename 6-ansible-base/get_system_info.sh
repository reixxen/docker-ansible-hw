#!/bin/bash

echo "=== СИСТЕМНАЯ ИНФОРМАЦИЯ ===" > info.txt

echo -e "\n--- Hostname ---" >> info.txt
ansible localhost -m setup -a "filter=ansible_hostname" | grep ansible_hostname >> info.txt

echo -e "\n--- Тип OS ---" >> info.txt
ansible localhost -m setup -a "filter=ansible_os_family" | grep ansible_os_family >> info.txt

echo -e "\n--- Дистрибутив ---" >> info.txt
ansible localhost -m setup -a "filter=ansible_distribution" | grep ansible_distribution >> info.txt

echo -e "\n--- Версия OS ---" >> info.txt
ansible localhost -m setup -a "filter=ansible_distribution_version" | grep ansible_distribution_version >> info.txt

echo -e "\n--- IP-адрес ---" >> info.txt
ansible localhost -m setup -a "filter=ansible_default_ipv4" | grep -A 5 ansible_default_ipv4 >> info.txt

echo -e "\n=== ПЕРЕМЕННЫЕ ОКРУЖЕНИЯ ===" >> info.txt
ansible localhost -m setup -a "filter=ansible_env" | grep ansible_env >> info.txt

echo "Информация записана в info.txt"
