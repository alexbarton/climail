# climail: Suite of commands for handling Maildir email on the command line

## checkmail: Check Maildir recursively for new email

Check the `Maildir` of the current user recursively for new email, and open all
folders found with the email client.

The following email clients are supported by default:

- `mail`
- `s-nail` (preferred when found)

An alternative email client can be specified on the command line.

### Usage: checkmail

`checkmail [<mailbox_command> [<arguments...>]]`
