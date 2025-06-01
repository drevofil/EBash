#!/bin/bash
# Успешная операция SCP
echo "Создаем тестовый файл" > /tmp/testfile.txt
scp /tmp/testfile.txt /tmp/testfile_copy.txt