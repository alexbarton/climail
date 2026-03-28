#
# climail: Makefile
#

DESTDIR ?=
PREFIX ?= /usr/local
BIN_DIR ?= $(PREFIX)/bin

BIN_SCRIPTS = \
	bin/checkmail \
	bin/lister \
	bin/openmail \
	bin/readmail \

all:

clean:

distclean: clean

maintainer-clean: distclean

define CHECK_PROGRAM
echo "Testing $(1) ..."; \
./$(1) --help | grep -Fq Usage: || { echo "$(1): Error on --help!"; exit 1; }; \
./$(1) --invalid_arg 2>&1 >/dev/null | grep -Fq Usage: || { echo "$(1): error on --invalid_arg!"; exit 1; };
endef

check: all
	@for p in $(BIN_SCRIPTS); do \
	  $(call CHECK_PROGRAM,$$p) \
	 done
	shellcheck $(BIN_SCRIPTS)
	mdl *.md

install:
	install -m 0755 -v $(BIN_SCRIPTS) "$(BIN_DIR)"

.PHONY: all clean distclean maintainer-clean check install
