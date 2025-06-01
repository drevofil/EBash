# Makefile для Telegram Script Notifier

SCRIPT_NAME = ebash
INSTALL_DIR = /usr/local/bin
VERSION = 1.5.1

.PHONY: install uninstall

install:
	@echo "Установка $(SCRIPT_NAME) v$(VERSION) в $(INSTALL_DIR)"
	@sudo install -v -m 755 $(SCRIPT_NAME) $(INSTALL_DIR)/$(SCRIPT_NAME)
	@echo "Успешно установлено!"
	@echo "Проверьте: which $(SCRIPT_NAME)"

uninstall:
	@echo "Удаление $(SCRIPT_NAME) из $(INSTALL_DIR)"
	@if [ -f "$(INSTALL_DIR)/$(SCRIPT_NAME)" ]; then \
		sudo rm -vf "$(INSTALL_DIR)/$(SCRIPT_NAME)"; \
		echo "Удалено: $(INSTALL_DIR)/$(SCRIPT_NAME)"; \
	else \
		echo "$(SCRIPT_NAME) не найден в $(INSTALL_DIR)"; \
	fi

.PHONY: install uninstall