#!/bin/bash
# Скрипт создания резервной копии Moodle

echo "=== Создание резервной копии Moodle ==="

# Создаём папку для бэкапов, если её нет
mkdir -p content/backup

# Формируем имя файла с текущей датой
BACKUP_NAME="course_kunicina_$(date +%Y%m%d_%H%M%S).mbz"
BACKUP_PATH="content/backup/$BACKUP_NAME"

echo "Создаю резервную копию курса..."

# Создаём бэкап через консоль Moodle
docker exec practice--kunicina--moodle-moodle-1 /opt/bitnami/php/bin/php /opt/bitnami/moodle/admin/cli/backup.php --courseid=1 --destination=/tmp/backup.mbz

# Копируем бэкап из контейнера на хост
docker cp practice--kunicina--moodle-moodle-1:/tmp/backup.mbz "$BACKUP_PATH"

echo "Резервная копия сохранена: $BACKUP_PATH"
echo "=== Бэкап завершён ==="