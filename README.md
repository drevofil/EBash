# Extended Bash для запуска скриптов с уведомлениями в Teleragm 🚀

Проект для отправки уведомлений в Telegram о выполнении скриптов с деталями запуска, статусом завершения и последними строками логов.

## Особенности ✨

- Отправка уведомлений в Telegram при запуске и завершении скриптов
- Включение ключевых деталей: имя скрипта, хост, рабочая директория
- Показ кода завершения и времени выполнения
- Отправка последних 5 строк логов
- Простая переносимость между системами
- Безопасное хранение токена через переменные окружения

## Требования ⚙️

- `bash` (версия 4.0+)
- `curl`
- Telegram-бот (создается через [@BotFather](https://t.me/BotFather))

## Быстрый старт 🚀

1. **Создайте Telegram-бота**:
   ```bash
   # Создайте бота через @BotFather и получите токен
   # Узнайте chat_id:
   curl "https://api.telegram.org/bot<ВАШ_ТОКЕН>/getUpdates" | jq '.result[0].message.chat.id'
   ```

2. **Скачайте скрипт**:
   ```bash
   wget https://raw.githubusercontent.com/yourusername/telegram-script-notifier/main/ebash
   chmod +x ebash
   ```

3. **Настройте переменные окружения**:
   ```bash
   export TELEGRAM_BOT_TOKEN="123456789:ABCDEFGhijklmnopQRSTUVWXYZ"
   export TELEGRAM_CHAT_ID="123456789"
   ```

4. **Запустите ваш скрипт через обертку**:
   ```bash
   ./ebash bash backup.sh
   ```

## Примеры использования 💻

### Базовый запуск
```bash
./ebash python data_processing.py
```

### С аргументами
```bash
./ebash rsync -avz /source /destination
```

### Долгий процесс в фоне
```bash
nohup ./ebash bash long_operation.sh &
```

### Для cron-задач
```bash
0 3 * * * . /path/to/env_vars; /path/to/ebash bash nightly_backup.sh
```

## Перенос на другой сервер 🔁

1. Скопируйте `ebash` на новый сервер
2. Установите переменные окружения:
   ```bash
   # Добавьте в ~/.bashrc или отдельный файл:
   echo 'export TELEGRAM_BOT_TOKEN="ваш_токен"' >> ~/.telegram_vars
   echo 'export TELEGRAM_CHAT_ID="ваш_chat_id"' >> ~/.telegram_vars
   ```
3. При запуске подгружайте переменные:
   ```bash
   source ~/.telegram_vars && ./ebash your_script.sh
   ```

## Примеры сообщений в Telegram 📱

**При запуске:**
```
🚀 Запущен скрипт: `backup.sh`
🖥 Хост: `server01`
📂 Рабочий каталог: `/home/user/backups`
```

**При успешном завершении:**
```
✅ Скрипт завершён: `backup.sh`
⌛ Длительность: 125 сек.
🔢 Код выхода: 0
📝 Лог (последние строки):
    [2023-10-01] Backup completed
    Transferred: 15.4GB
    Speed: 120MB/s
    Deleted 3 old backups
    All operations finished
```

**При ошибке:**
```
❌ Скрипт завершён: `data_sync.sh`
⌛ Длительность: 42 сек.
🔢 Код выхода: 1
📝 Лог (последние строки):
    ERROR: Disk full!
    rsync: write failed on "/dest/file.iso": No space left on device (28)
    rsync error: error in file IO (code 11)
```

## Кастомизация ⚙️

Вы можете изменить параметры отправки логов, отредактировав строку:
```bash
LOG_TAIL=$(tail -n 5 "$LOG_FILE" | sed 's/^/\n    /')
```
Замените `5` на нужное количество строк лога.

## Лицензия 📄

MIT License. Используйте свободно в личных и коммерческих проектах.

---

**Примечание**: Для безопасности рекомендуется хранить токен в зашифрованном виде или использовать секреты вашего CI/CD-окружения.