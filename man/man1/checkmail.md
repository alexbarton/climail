---
title: checkmail
author: Alexander Barton, alex@barton.de
date: April 2026
section: 1
header: User Commands
footer: climail package
---

# NAME

checkmail - check Maildir recursively for new email

# SYNOPSIS

**checkmail** [*mailbox_command* [*arguments...*]] \
**checkmail** {**\--list-only** | **-l**}

# DESCRIPTION

**checkmail** checks the Maildir of the current user recursively for new email,
and opens all folders found with **openmail(1)**, passing the *mailbox_command*
and its *arguments* when specified on the command line.

# OPTIONS

**-l**, **\--list-only**
: Only list folders containing new messages without opening them.

# ENVIRONMENT

**MAILDIR**
: Overrides the default Maildir path (**/var/log/${LOGNAME}**).

# EXIT STATUS

**0**
: Successful execution.

**1**
: Error while scanning or opening folders.

# SEE ALSO

**openmail(1)**, **readmail(1)**, **lister(1)**

# BUGS

Report bugs at: <https://github.com/alexbarton/climail/issues>
