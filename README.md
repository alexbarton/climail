# climail: Suite of commands for handling Maildir email on the command line

The *climail* package provides some commands to make it easier to handle
internet email in "Maildir" format on the command line:

- `checkmail`: Check Maildir recursively for new email.
- `openmail`: Setup and call an email client for a Maildir folder.
- `readmail`: Interactively select a mailbox to read mail from.
- `lister`: List all mailboxes in a Maildir tree.

Homepage: <https://github.com/alexbarton/climail>

## Prerequisites

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

## checkmail: Check Maildir recursively for new email

Check the `Maildir` of the current user recursively for new email, and open all
folders found with `openmail`.

### Usage: checkmail

- `checkmail [<mailbox_command> [<arguments...>]]`
- `checkmail {--list-only|-l}`

## openmail: Setup and call an email client for a Maildir folder

Run a command on a mailbox in `Maildir` format. By default, an email client
is used to read mail.

The following email clients are supported by default:

- `mail`: called as `mail -f`.
- `s-nail`: preferred when found, called as `s-nail -f`.

An alternative command and its arguments can can be specified on the command
line. And this can be an arbitrary command, it must not be an interactive CLI
email client.

When no mailbox is specified, `+` (the "INBOX") is used by default.

If the mailbox name does start with a dot ("."), the missing "+" is prepended
automatically. When both plus and dot ("+.") are missing on a mailbox starting
with an alphanumeric character, "+." is prepended automatically. And the plain
names "INBOX" and "inbox" are always translated into "+".

This way you can use *friendly* folder names as shown when starting `openmail`
and used in the selector of the `readmail` command, for example.

### Usage: openmail

`openmail [<mailbox> [<mailbox_command> [<arguments...>]]]`

Environment:

- `CLIMAIL_PAGER`: `PAGER` is set to its value (when available) before calling
  the `<mailbox_command>`.

## readmail: Interactively select a mailbox to read mail from

The `readmail` command calls `lister` and `fzf` in an "endless" loop to
interactively select a mail folder and call `openmail` on it.

Once `fzf` returns an non-zero exit code, for example when exited with CTRL+D,
`readmail` ends the loop and exits.

### Usage: readmail

`readmail [<search_pattern ...>]`

When a search pattern is given, `readmail` does not enter its loop, but exits
regardless of the exit code of the `openmail` command after one invocation.

## lister: List all mailboxes in a Maildir tree

Find and format a list of all mailboxes in a Maildir tree. When writing to a
terminal, the output is piped through `column`.

The `lister` command can be set and exported in the `LISTER` environment
variable for S-nail and GNU Mailutils, for example, what the `openmail` command
does by default when `LISTER` is not already set.

### Usage: lister

`lister [<Maildir_directory>]`
