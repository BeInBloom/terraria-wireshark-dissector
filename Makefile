PLUGIN_NAME := terraria.lua
PLUGIN_DIR := $(HOME)/.local/lib/wireshark/plugins
PLUGIN_PATH := $(PLUGIN_DIR)/$(PLUGIN_NAME)

.PHONY: install uninstall path

install:
	mkdir -p "$(PLUGIN_DIR)"
	ln -sf "$(PWD)/$(PLUGIN_NAME)" "$(PLUGIN_PATH)"
	@echo "Installed: $(PLUGIN_PATH)"

uninstall:
	rm -f "$(PLUGIN_PATH)"
	@echo "Removed: $(PLUGIN_PATH)"

path:
	@echo "$(PLUGIN_PATH)"
