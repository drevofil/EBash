# Telegram Script Notifier 🚀

Утилита для отправки уведомлений в Telegram о выполнении скриптов с деталями запуска, статусом завершения и релевантными логами.

## Особенности ✨

- **Уведомления в Telegram** при запуске и завершении скриптов
- **Автоматический анализ ошибок** - показывает контекст ошибки в логах
- **Обработка прерываний** (Ctrl+C) с отправкой специального уведомления
- **Кросс-платформенность** - работает на Linux и macOS
- **Простая установка** в системный PATH через Makefile
- **Умное логирование** - разные форматы логов для успешных выполнений и ошибок

## Установка ⚙️

### Требования
- `bash` (версия 4.0+)
- `curl`
- Telegram-бот ([создать через @BotFather](https://t.me/BotFather))

### Быстрая установка

```bash
# Клонируйте репозиторий
git clone https://github.com/yourusername/telegram-script-notifier.git
cd telegram-script-notifier

# Установите с правами суперпользователя
sudo make install

# Настройте переменные окружения
echo 'export TELEGRAM_BOT_TOKEN="ВАШ_ТОКЕН"' >> ~/.bashrc
echo 'export TELEGRAM_CHAT_ID="ВАШ_CHAT_ID"' >> ~/.bashrc
source ~/.bashrc
```

### Проверка установки
```bash
ebash --version
# ebash v1.4.0
```

## Использование 💻

### Базовый запуск
```bash
ebash bash ваш_скрипт.sh
```

### С аргументами
```bash
ebash rsync -avz /source /destination
```

### Долгий процесс
```bash
nohup ebash python долгий_скрипт.py &
```

### Для cron-задач
```bash
0 3 * * * . /home/user/.bashrc; ebash bash ночной_бэкап.sh
```

## Примеры сообщений 📨

### Успешное выполнение
```
✅ Скрипт завершен: `backup.sh`
⌛ Длительность: 00:12:45
📋 Статус: УСПЕШНО
🕒 Время завершения: 2025-06-01 03:00:15 MSK
🔢 Код выхода: 0
📝 Логи:
    Backup started
    Processing...
    Backup completed successfully
    Cleanup old backups
    Done.
```

### Ошибка выполнения
```
❌ Скрипт завершен: `data_sync.sh`
⌛ Длительность: 00:00:42
📋 Статус: С ОШИБКОЙ
🕒 Время завершения: 2025-06-01 12:15:30 MSK
🔢 Код выхода: 1
📝 Логи:
    Connecting to server...
    ERROR: Connection timeout
    Retrying (1/3)...
    FATAL: All connection attempts failed
```

### Прерывание пользователем
```
⏹ Скрипт прерван: `long_processing.sh`
🖥 Хост: `server01`
🕒 Время работы: 120 сек
```

## Управление 🛠️

### Установка
```bash
sudo make install
```

### Удаление
```bash
sudo make uninstall
```

### Проверка версии
```bash
ebash --version
```

## Кастомизация ⚙️

### Логирование
- При успехе: отправляются последние 5 строк лога
- При ошибке: отправляется контекст ошибки (10 строк после + 5 строк до)

### Ключевые слова для ошибок
Скрипт ищет в логах следующие паттерны:
```bash
error|fail|exception|undefined|not found|no such file
```

Чтобы изменить, отредактируйте строку:
```bash
ERROR_CONTEXT=$(grep -A 10 -B 5 -i "ваши_ключевые_слова" ...)
```

### Формат сообщений
Вы можете изменить стартовые и финальные сообщения, редактируя переменные:
```bash
START_MESSAGE="🚀 *Запущен скрипт:* \`$COMMAND_NAME\` ..."
MAIN_MESSAGE="$STATUS_EMOJI *Скрипт завершен:* \`$COMMAND_NAME\` ..."
```

## Ограничения ⚠️
- Максимальная длина сообщения в Telegram: 4096 символов
- Для cron-задач необходимо подгружать переменные окружения
- При очень больших логах вывод может быть обрезан

## Решение проблем 🔍

### Сообщения не приходят
1. Проверьте токен и chat ID:
```bash
curl "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/getUpdates"
```

2. Проверьте доступ к Telegram API:
```bash
curl -v "https://api.telegram.org"
```

3. Убедитесь, что бот не заблокирован в Telegram

### Ошибки формата
Если возникают проблемы с экранированием, можно:
1. Отключить Markdown:
```bash
# В функции send_telegram замените
-d "parse_mode=Markdown" → удалите эту строку
```

2. Упростить сообщение:
```bash
# Замените FULL_MESSAGE на MAIN_MESSAGE
send_telegram "$MAIN_MESSAGE"
```

## Лицензия 📄
MIT License. Подробнее в файле [LICENSE](LICENSE).

---
**Примечание**: Для безопасности храните токен бота в защищенном месте. Этот инструмент предназначен для личного использования на доверенных системах.