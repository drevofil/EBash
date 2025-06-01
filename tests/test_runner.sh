#!/bin/bash
set -e

# Функция для выполнения теста
run_test() {
  local test_name=$1
  local script=$2
  local expected_exit=$3
  
  echo "🚀 Запуск теста: $test_name"
  
  # Запускаем команду через ebash
  set +e
  ebash bash "$script" > "$test_name.log" 2>&1
  exit_code=$?
  set -e
  
  # Проверяем результат
  if [ $exit_code -eq "$expected_exit" ]; then
    echo "✅ $test_name: УСПЕХ (ожидалось: $expected_exit, получили: $exit_code)"
    return 0
  else
    echo "❌ $test_name: ОШИБКА (ожидалось: $expected_exit, получили: $exit_code)"
    echo "=== ЛОГ ТЕСТА ==="
    cat "$test_name.log"
    return 1
  fi
}

# Выполняем тесты
errors=0

run_test "SCP_Успех" "tests/scenarios/scp_success.sh" 0 || errors=$((errors+1))
run_test "SCP_Ошибка" "tests/scenarios/scp_fail.sh" 1 || errors=$((errors+1))

run_test "RSYNC_Успех" "tests/scenarios/rsync_success.sh" 0 || errors=$((errors+1))
run_test "RSYNC_Ошибка" "tests/scenarios/rsync_fail.sh" 23 || errors=$((errors+1))  # rsync возвращает 24 при частичном сбое

# run_test "PG_DUMP_Успех" "/tests/scenarios/pg_dump_success.sh" 0 || errors=$((errors+1))
# run_test "PG_DUMP_Ошибка" "/tests/scenarios/pg_dump_fail.sh" 1 || errors=$((errors+1))

# run_test "MONGO_DUMP_Успех" "/tests/scenarios/mongodump_success.sh" 0 || errors=$((errors+1))
# run_test "MONGO_DUMP_Ошибка" "/tests/scenarios/mongodump_fail.sh" 1 || errors=$((errors+1))

# Отправляем результаты в Telegram
if [ $errors -eq 0 ]; then
  message="🔥 ВСЕ ТЕСТЫ ПРОЙДЕНЫ УСПЕШНО! 🔥"
else
  message="❌ ТЕСТЫ НЕ ПРОЙДЕНЫ: $errors ошибок ❌"
fi

curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage" \
  -d "chat_id=${TELEGRAM_CHAT_ID}" \
  -d "text=$message" \
  -d "parse_mode=Markdown" >/dev/null || true

# Возвращаем код ошибки для CI
exit $errors