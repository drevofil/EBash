#!/bin/bash
echo "Начало выполнения"
sleep 2
echo "Промежуточные логи"
echo "Еще логи..."
cat non_existent_file  # Эта команда вызовет ошибку
echo "Этот текст не будет выведен"