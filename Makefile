#
# Makefile
#

DESTDIR ?=
PREFIX ?= /usr/local
BIN_DIR ?= $(PREFIX)/bin

all:

clean:

distclean: clean

maintainer-clean: distclean

check: all
	./bin/checkmail --help | grep -Fq Usage:
	shellcheck bin/checkmail
	mdl *.md

install:
	install -m 0755 bin/checkmail "$(BIN_DIR)/checkmail"

.PHONY: all clean distclean maintainer-clean check install
