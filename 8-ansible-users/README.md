# Напишите роль для создания пользователей

- Проходится по массиву имён пользователей и их паролей
- Создаёт для каждого пользователя
- Генерит публичный и приватный ключ
- Кладёт публичную часть в authorized_keys
- Добавляется всех пользователей в группу docker

## Требования

- Проходит ansible-lint
- vault.yml с паролями должен быть зашифрован

### Запуск playbook со вскрытием vault

пароль указан в файле .vault_pwd

```bash
ansible-playbook -i inventory playbook.yml --vault-id test@prompt -K
```

или

```bash
ansible-playbook -i inventory playbook.yml --vault-id test@.vault_pwd -K
```
