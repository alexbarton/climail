# climail: Suite of commands for handling Maildir email on the command line

The *climail* package provides commands to make it easier to handle internet
email in "Maildir" format on the command line:

- `checkmail`: Check Maildir recursively for new email.

  Manual page:
  [en](man/man1/checkmail.md)
  [de](man/de/man1/checkmail.md)

- `openmail`: Setup and call an email client for a Maildir folder.

  Manual page:
  [en](man/man1/openmail.md)
  [de](man/de/man1/openmail.md)

- `readmail`: Interactively select a mail folder to read mail from.

  Manual page:
  [en](man/man1/readmail.md)
  [de](man/de/man1/readmail.md)

- `lister`: List all mailboxes in a Maildir tree.

  Manual page:
  [en](man/man1/lister.md)
  [de](man/de/man1/lister.md)

Homepage: <https://github.com/alexbarton/climail>

## Prerequisites

### Runtime dependencies

1. Your local email setup must use the *"Maildir" layout*. Either in its
   default location `/var/mail/${LOGNAME}` or specified by the `MAILDIR`
   environment variable.

1. *GNU bash* must be available. You can use a different shell, but all tools
   use the `bash` shell as interpreter. The "shebang" line uses `/usr/bin/env`
   to execute `bash` in your search path (`$PATH`).

1. *GNU gettext* must be installed. Specifically, the `gettext.sh` script must
   be in your search path (`$PATH`). On Debian-based systems, it is included in
   the "gettext-base" package, which can be installed like this:

   ```sh
   apt-get update && apt-get install gettext-base
   ```

   You can verify that it is installed and can be found with this command:
   `type gettext.sh`: this should output the full path name to the script.

1. A capable *command line mail reader*, like `mail` from the *GNU Mailutils*
   or (even better and preferred) `s-nail` from the *S-nail* (*S-mailx*)
   package must be *available* and *configured* to handle email in your local
   `Maildir` folder(s).

1. The `readmail` command depends on `fzf`, the *command-line fuzzy finder*.

### Tools required or used during building

Required tools:

1. *Pandoc* (`pandoc`) is used to generate all manual pages from their
   respective Markdown sources.
1. *GNU gettext* (`xgettext`, `msgfmt`, `msgmerge`) is required to build the
   message catalog and language files.

Tools used for the `make check` target:

1. Markdownlint (`mdl`)
1. ShellCheck (`shellcheck`)

## Installation

You can run the scripts right from the source directory or install them into
the system. In both cases, the language files must be generated with `make`.

To install everything into the `/usr/local` hierarchy, the default, call:

```sh
make all && sudo make install
```

The common `DESTDIR`, `PREFIX`, etc. variables are supported in the `Makefile`,
therefore you can call the following command to install into an (writable)
`/opt/climail` path:

```sh
make PREFIX=/opt/climail install
```

### Command line mail reader setup

As noted above, the *mail reader* (typically `mail` or `s-nail`) must be
configured for your local Maildir setup. A starting point for your `~/.mailrc`
file could look like this, for example:

```plain
# Set INBOX, MBOX, and "record" (sent mail) folder.
set folder=/var/mail/your_user_name
set MBOX=+.Archive
set record=+.Sent
```
