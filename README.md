# climail: Suite of commands for handling Maildir email on the command line

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

`readmail`

## lister: List all mailboxes in a Maildir tree

Find and format a list of all mailboxes in a Maildir tree. When writing to a
terminal, the output is piped through `column`.

The `lister` command can be set and exported in the `LISTER` environment
variable for S-nail and GNU mailutils, for example, what the `openmail` command
does by default when `LISTER` is not already set.

### Usage: lister

`lister [<Maildir_directory>]`
