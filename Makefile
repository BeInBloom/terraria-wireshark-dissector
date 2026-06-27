PLUGIN_NAME := terraria.lua
PLUGIN_DIR ?= $(HOME)/.local/lib/wireshark/plugins
PLUGIN_PATH := $(PLUGIN_DIR)/$(PLUGIN_NAME)
RUNTIME_PLUGIN_DIR ?= /tmp/terraria-wireshark-plugins
SRC_DIR := $(CURDIR)/src
PLUGIN_SOURCE := $(SRC_DIR)/terraria.lua
MODULE_PATH := $(PLUGIN_DIR)/terraria
MODULE_SOURCE := $(SRC_DIR)/terraria
LUA_LS_LOG_DIR := .lua-ls-log
LUA_LS_META_DIR := .lua-ls-meta

.PHONY: install uninstall path check-lua runtime-check

install:
	mkdir -p "$(PLUGIN_DIR)"
	ln -sf "$(PLUGIN_SOURCE)" "$(PLUGIN_PATH)"
	ln -sfn "$(MODULE_SOURCE)" "$(MODULE_PATH)"
	@echo "Installed: $(PLUGIN_PATH)"

uninstall:
	rm -f "$(PLUGIN_PATH)" "$(MODULE_PATH)"
	@echo "Removed: $(PLUGIN_PATH)"

path:
	@echo "$(PLUGIN_PATH)"

check-lua:
	mise exec -- lua-language-server --check="$(CURDIR)" --configpath="$(CURDIR)/.luarc.json" --checklevel=Warning --logpath="$(CURDIR)/$(LUA_LS_LOG_DIR)" --metapath="$(CURDIR)/$(LUA_LS_META_DIR)"

runtime-check:
	@test -n "$(PCAP)" || (echo "Set PCAP=/path/to/capture.pcap[ng]" && exit 1)
	$(MAKE) install PLUGIN_DIR="$(RUNTIME_PLUGIN_DIR)"
	WIRESHARK_PLUGIN_DIR="$(RUNTIME_PLUGIN_DIR)" tshark -r "$(PCAP)" -V >"/tmp/terraria-runtime-check.log" 2>&1
	@echo "Runtime log: /tmp/terraria-runtime-check.log"
