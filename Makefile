PREFIX_BIN ?= /usr/local/bin

.PHONY: all
all:
	@echo 'nothing to do'

.PHONY: install
install:
	cp ./zensu.sh $(PREFIX_BIN)/zensu

.PHONY: uninstall
uninstall:
	rm -f $(PREFIX_BIN)/zensu

.PHONY: check
check:
	which zensu
