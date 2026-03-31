#
# climail: Makefile
#

DESTDIR ?=
PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin
LOCALEDIR ?= $(PREFIX)/share/locale

BIN_SCRIPTS = \
	bin/checkmail \
	bin/lister \
	bin/openmail \
	bin/readmail \

POFILES := $(wildcard po/*.po)
LANGS := $(patsubst po/%.po,%,$(POFILES))
MOFILES := $(foreach lang,$(LANGS),po/$(lang)/LC_MESSAGES/climail.mo)

all: $(BIN_SCRIPTS) po/messages.pot $(MOFILES)

po/%/LC_MESSAGES/climail.mo: po/%.po
	mkdir -p po/$*/LC_MESSAGES
	msgfmt -o po/$*/LC_MESSAGES/climail.mo $<

po/messages.pot:
	make update-pot

clean:
	rm -f po/*/LC_MESSAGES/climail.mo
	rmdir po/*/LC_MESSAGES 2>/dev/null || true
	rmdir po/* 2>/dev/null || true

distclean: clean
	rm -f po/*.po~

maintainer-clean: distclean
	rm -f po/messages.pot

define CHECK_PROGRAM
echo "Testing $(1) ..."; \
LANG=C ./$(1) --help | grep -Fq Usage: || { echo "$(1): Error on --help!"; exit 1; }; \
LANG=C ./$(1) --invalid_arg 2>&1 >/dev/null | grep -Fq Usage: || { echo "$(1): error on --invalid_arg!"; exit 1; };
endef

check: all
	@for p in $(BIN_SCRIPTS); do \
	  $(call CHECK_PROGRAM,$$p) \
	 done
	shellcheck $(BIN_SCRIPTS)
	mdl *.md

install: all
	install -d -m 0755 -v "$(DESTDIR)$(BINDIR)"
	install -m 0755 -v $(BIN_SCRIPTS) "$(DESTDIR)$(BINDIR)"
	@for lang in $(LANGS); do \
	  install -d -m 0755 -v "$(DESTDIR)$(LOCALEDIR)/$$lang/LC_MESSAGES"; \
	  install -m 0644 -v po/$$lang/LC_MESSAGES/climail.mo "$(DESTDIR)$(LOCALEDIR)/$$lang/LC_MESSAGES/climail.mo"; \
	done

# Regenerate messages.pot from all scripts
update-pot:
	xgettext --language=Shell --from-code=UTF-8 --keyword=gettext --keyword=eval_gettext -o po/messages.pot bin/*

# Merge new strings into all .po files
update-po: update-pot
	for pofile in $(POFILES); do \
	  msgmerge --update $$pofile po/messages.pot; \
	done

.PHONY: all clean distclean maintainer-clean check install update-pot update-po
