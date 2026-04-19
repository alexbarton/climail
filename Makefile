#
# climail: Makefile
#

DESTDIR ?=
PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin
LIBEXECDIR ?= $(PREFIX)/libexec
LOCALEDIR ?= $(PREFIX)/share/locale
MANDIR ?= $(PREFIX)/share/man

BIN_SCRIPTS = \
	bin/checkmail \
	bin/lister \
	bin/openmail \
	bin/readmail \

LIBEXEC_FILES = \
	libexec/climail/climail.inc.sh \

POFILES := $(wildcard po/*.po)
LANGS := $(patsubst po/%.po,%,$(POFILES))
MOFILES := $(foreach lang,$(LANGS),po/$(lang)/LC_MESSAGES/climail.mo)

MANPAGES_MD = \
	man/man1/checkmail.md \
	man/man1/lister.md \
	man/man1/openmail.md \
	man/man1/readmail.md \
	man/de/man1/checkmail.md \
	man/de/man1/lister.md \
	man/de/man1/openmail.md \
	man/de/man1/readmail.md \

MANPAGES = $(MANPAGES_MD:.md=.1)

all: $(BIN_SCRIPTS) po/messages.pot $(MOFILES) $(MANPAGES)

po/%/LC_MESSAGES/climail.mo: po/%.po
	mkdir -p po/$*/LC_MESSAGES
	msgfmt -o po/$*/LC_MESSAGES/climail.mo $<

po/messages.pot:
	make update-pot

%.1: %.md
	pandoc -s -t man $< -o $@

clean:
	rm -f po/*/LC_MESSAGES/climail.mo
	rmdir po/*/LC_MESSAGES 2>/dev/null || true
	rmdir po/* 2>/dev/null || true
	rm -f $(MANPAGES)

distclean: clean
	rm -f po/*.po~

maintainer-clean: distclean
	rm -f po/messages.pot

define CHECK_PROGRAM
echo "Testing $(1) ..."; \
bash -n ./$(1) || exit 1; \
LANG=C ./$(1) --help | grep -Fq Usage: || { echo "$(1): Error on --help!"; exit 1; }; \
LANG=C ./$(1) --invalid_arg 2>&1 >/dev/null | grep -Fq Usage: || { echo "$(1): error on --invalid_arg!"; exit 1; };
endef

check: all
	@for p in $(LIBEXEC_FILES); do \
	  echo "Checking $$p ..."; bash -n "$$p" || exit 1; \
	 done
	@for p in $(BIN_SCRIPTS); do \
	  $(call CHECK_PROGRAM,$$p) \
	 done
	shellcheck $(BIN_SCRIPTS) $(LIBEXEC_FILES)
	mdl -g -r ~MD025 .
	grep -Fq 'checks the Maildir' man/man1/checkmail.1
	grep -Fq 'keine Schleife begonnen' man/de/man1/readmail.1

install: all
	install -d -m 0755 "$(DESTDIR)$(BINDIR)"
	install -m 0755 $(BIN_SCRIPTS) "$(DESTDIR)$(BINDIR)"
	install -d -m 0755 "$(DESTDIR)$(LIBEXECDIR)/climail"
	install -m 0644 $(LIBEXEC_FILES) "$(DESTDIR)$(LIBEXECDIR)/climail/"
	@for lang in $(LANGS); do \
	  install -d -m 0755 "$(DESTDIR)$(LOCALEDIR)/$$lang/LC_MESSAGES"; \
	  install -m 0644 po/$$lang/LC_MESSAGES/climail.mo "$(DESTDIR)$(LOCALEDIR)/$$lang/LC_MESSAGES/climail.mo"; \
	done
	install -d -m 0755 "$(DESTDIR)$(MANDIR)/man1"
	install -d -m 0755 "$(DESTDIR)$(MANDIR)/de/man1"
	@for manpage in $(MANPAGES); do \
	  install -m 0644 $$manpage "$(DESTDIR)$(MANDIR)/$${manpage#man/}"; \
	done

# Regenerate messages.pot from all scripts
update-pot:
	xgettext --language=Shell --from-code=UTF-8 \
		--keyword=gettext --keyword=eval_gettext \
		-o po/messages.pot bin/* libexec/climail/*

# Merge new strings into all .po files
update-po: update-pot
	for pofile in $(POFILES); do \
	  msgmerge --update $$pofile po/messages.pot; \
	done

.PHONY: all clean distclean maintainer-clean check install update-pot update-po
