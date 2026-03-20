#!/bin/bash
# Скрипт восстановления Moodle из резервной копии

echo "=== Восстановление Moodle ==="

# Переменные
BACKUP_FILE=$1
MOODLE_DATA="/bitnami/moodle"
MOODLEDATA_DATA="/bitnami/moodledata"

# Проверка, что передан файл бэкапа
if [ -z "$BACKUP_FILE" ]; then
    echo "Ошибка: укажите путь к файлу резервной копии"
    echo "Пример: ./restore.sh backup/backup.mbz"
    exit 1
fi

# Проверка, что файл существует
if [ ! -f "$BACKUP_FILE" ]; then
    echo "Ошибка: файл $BACKUP_FILE не найден"
    exit 1
fi

echo "Восстановление из файла: $BACKUP_FILE"

# Остановка контейнера
echo "Останавливаю контейнер Moodle..."
docker-compose stop moodle

# Копирование файла бэкапа в контейнер
echo "Копирую файл бэкапа в контейнер..."
docker cp "$BACKUP_FILE" practice--kunicina--moodle-moodle-1:/tmp/backup.mbz

# Восстановление через консоль Moodle
echo "Восстанавливаю данные..."
docker exec -it practice--kunicina--moodle-moodle-1 /opt/bitnami/php/bin/php /opt/bitnami/moodle/admin/cli/restore_backup.php --file=/tmp/backup.mbz

# Запуск контейнера
echo "Запускаю контейнер Moodle..."
docker-compose start moodle

echo "=== Восстановление завершено ==="