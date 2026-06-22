PLUGIN_NAME := terraria.lua
PLUGIN_DIR := $(HOME)/.local/lib/wireshark/plugins
PLUGIN_PATH := $(PLUGIN_DIR)/$(PLUGIN_NAME)
LUA_LS_LOG_DIR := .lua-ls-log
LUA_LS_META_DIR := .lua-ls-meta

.PHONY: install uninstall path check-lua

install:
	mkdir -p "$(PLUGIN_DIR)"
	ln -sf "$(PWD)/$(PLUGIN_NAME)" "$(PLUGIN_PATH)"
	@echo "Installed: $(PLUGIN_PATH)"

uninstall:
	rm -f "$(PLUGIN_PATH)"
	@echo "Removed: $(PLUGIN_PATH)"

path:
	@echo "$(PLUGIN_PATH)"

check-lua:
	mise exec -- lua-language-server --check="$(PWD)" --configpath="$(PWD)/.luarc.json" --checklevel=Warning --logpath="$(PWD)/$(LUA_LS_LOG_DIR)" --metapath="$(PWD)/$(LUA_LS_META_DIR)"
