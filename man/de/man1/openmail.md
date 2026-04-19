---
title: openmail
author: Alexander Barton, alex@barton.de
date: April 2026
section: 1
header: Dienstprogramme für Benutzer
footer: climail package
---

# BEZEICHNUNG

openmail — Mailreader für einen Maildir-Ordner vorbereiten und starten

# ÜBERSICHT

**openmail** [*mailbox* [*mailbox_command* [*arguments...*]]]

# BESCHREIBUNG

**openmail** führt einen Befehl auf einem Maildir-Ordner aus. Standardmäßig wird
ein E-Mail-Client gestartet, um den Ordner zu lesen.

Unterstützte Mailreader:

- **mail**(1): aufgerufen als "mail -f".
- **s-nail**: bevorzugt, wenn vorhanden, aufgerufen als "s-nail -f".

Ein alternativer Befehl *mailbox_command* und seine Parameter *arguments* können
auf der Kommandozeile angegeben werden. Das kann ein beliebiges Kommando sein,
es muss kein interaktives E-Mail-Programm für die Kommandozeile sein.

Wenn kein Mail-Ordner *mailbox* angegeben wurde, wird "+" (die "INBOX")
verwendet.

Falls der Name *mailbox* mit einem Punkt (".") beginnt, wird das fehlende "+"
automatisch ergänzt. Wenn sowohl das Plus als auch der Punkt ("+.") fehlen und
der Name mit einem alphanumerischen Zeichen beginnt, wird "+." automatisch
vorangestellt. Und die Namen "INBOX" und "inbox" werden immer in "+" übersetzt.

Auf diese Weise können *freundliche* Ordner-Namen verwendet werden, wie sie zum
Beispiel auch beim Start von **openmail** angezeigt und in der Auswahlliste von
**readmail**(1) verwendet werden.

# ENVIRONMENT

**CLIMAIL_PAGER**
: Überschreibt den "PAGER" bevor der Mailreader gestartet wird.

**EDITOR**
: Oft von E-Mail-Programmen genutzt, um einen Text-Editor zum Erstellen einer
  neuen E-Mail zu starten. Wenn **openmail** in **EDITOR** *VIM* (oder einen
  Abkömmling) erkennt, hängt es "-c \'set filetype=mail\'" an die **EDITOR**
  Variable an, um einen geeigneten Dateityp auch dann zu erzwingend, wenn der
  Editor mit einer temporären Datei mit einem beliebigen Namen aufgerufen wird.

**MAILDIR**
: Überschreibt den Standardpfad zum Maildir (**/var/log/${LOGNAME}**).

# RÜCKGABEWERT

**0**
: Erfolgreich ausgeführt.

**1**
: Fehler beim Aufruf des Mailreaders oder des angegebenen Befehls.

# SIEHE AUCH

**checkmail**(1), **readmail**(1), **lister**(1), **mail**(1), **s-nail**(1)

# FEHLER MELDEN

Bug-Tracker: <https://github.com/alexbarton/climail/issues>
