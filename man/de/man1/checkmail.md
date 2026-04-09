---
title: checkmail
author: Alexander Barton, alex@barton.de
date: April 2026
section: 1
header: Dienstprogramme für Benutzer
footer: climail package
---

# BEZEICHNUNG

checkmail - Maildir rekursiv auf neue E‑Mails prüfen

# ÜBERSICHT

**checkmail** [*mailbox_command* [*arguments...*]] \
**checkmail** {**\--list-only** | **-l**}

# BESCHREIBUNG

**checkmail** durchsucht das Maildir des aktuellen Benutzers rekursiv nach neuen
E‑Mails und öffnet alle gefundenen Ordner mit **openmail(1)**, wobei der Befehl
*mailbox_command* und seine Parameter *arguments* übergeben werden, wenn diese
auf der Kommandozeile angegeben wurden.

# OPTIONEN

**-l**, **\--list-only**
: Nur die Ordner mit neuen Nachrichten anzeigen, ohne sie zu öffnen.

# ENVIRONMENT

**MAILDIR**
: Überschreibt den Standardpfad zum Maildir (**/var/log/${LOGNAME}**).

# RÜCKGABEWERT

**0**
: Erfolgreich ausgeführt.

**1**
: Fehler beim Durchsuchen oder Öffnen.

# SIEHE AUCH

**openmail(1)**, **readmail(1)**, **lister(1)**

# FEHLER MELDEN

Bug-Tracker: <https://github.com/alexbarton/climail/issues>
