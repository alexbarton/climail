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

check: all
	./bin/checkmail --help | grep -Fq Usage:
	shellcheck $(BIN_SCRIPTS)
	mdl *.md

install:
	install -m 0755 $(BIN_SCRIPTS) "$(BIN_DIR)"

.PHONY: all clean distclean maintainer-clean check install
