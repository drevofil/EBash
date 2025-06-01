# Makefile for Telegram Script Notifier

.PHONY: install

install:
	@echo "Добавление текущего каталога в PATH..."
	@CURRENT_DIR=$$(pwd)
	@if ! grep -q "export PATH=\$$PATH:$$CURRENT_DIR" ~/.bashrc; then \
		echo "" >> ~/.bashrc; \
		echo "# Добавлено telegram-script-notifier" >> ~/.bashrc; \
		echo "export PATH=\"\$$PATH:$$CURRENT_DIR\"" >> ~/.bashrc; \
		echo "Добавлено в ~/.bashrc: export PATH=\"\$$PATH:$$CURRENT_DIR\""; \
	else \
		echo "Текущий каталог уже добавлен в PATH в ~/.bashrc"; \
	fi
	@echo ""
	@echo "Установка завершена! Теперь вы можете использовать 'ebash' из любого каталога."
	@echo "Выполните следующую команду, чтобы применить изменения:"
	@echo "source ~/.bashrc"
	@echo "Проверьте: which ebash"

uninstall:
	@echo "Удаление ссылок из ~/.bashrc..."
	@CURRENT_DIR=$$(pwd)
	@sed -i "\@export PATH=\"\$$PATH:$$CURRENT_DIR\"@d" ~/.bashrc
	@echo "Удалены ссылки на каталог из ~/.bashrc"
	@echo "Удалите репозиторий вручную: rm -rf $$CURRENT_DIR"

.PHONY: install uninstall