#!/bin/bash
# Успешная операция SCP
echo "Создаем тестовый файл" > /tmp/testfile.txt
rsync -av /tmp/testfile.txt /tmp/testfile_copy.txt