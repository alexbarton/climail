#!/usr/bin/env bash
#
# climail/climail.inc.sh
# Common initialization and bash functions for all climail tools.
#

init_gettext() {
	local locale_dir

	# shellcheck disable=SC1091
	. gettext.sh
	export TEXTDOMAIN=climail
	if [[ -z ${TEXTDOMAINDIR:-} ]]; then
		for locale_dir in ./po "${HOME}/.local/share/locale" /usr/local/share/locale; do
			[[ -r "${locale_dir}/de/LC_MESSAGES/${TEXTDOMAIN}.mo" ]] || continue
			export TEXTDOMAINDIR=$locale_dir
			break
		done
	fi
}

get_mailbox_name() {
	if [[ "$1" = "+" ]]; then
		echo "INBOX"
	else
		echo "${1#+.}"
	fi
}

validate_maildir_or_abort() {
	if [[ ! -e "$MAILDIR" ]]; then
		eval_gettext "Error: \"\${MAILDIR}\" not found!" >&2; echo >&2
		exit 1
	fi
	if [[ ! -r "$MAILDIR" ]]; then
		eval_gettext "Error: \"\${MAILDIR}\" is not readable!" >&2; echo >&2
		exit 1
	fi
	if [[ ! -d "$MAILDIR/cur" || ! -d "$MAILDIR/new" ]]; then
		eval_gettext "Error: \"\${MAILDIR}\" seems not to be a Maildir!" >&2; echo >&2
		exit 1
	fi
}

export LISTER=${LISTER:-"${SCRIPT_DIR:-}"/lister}
export MAILDIR="${MAILDIR:-/var/mail/${LOGNAME}}"
export PAGER=${CLIMAIL_PAGER:-${PAGER:-more}}

init_gettext

if [[ "${EDITOR:-}" =~ (^|/)n?vim && ! "${EDITOR}" =~ \-c ]]; then
	# Looks like EDITOR is set to a VIM variant and no -c option is given
	# so far, let's set the file type!
	export EDITOR="${EDITOR} -c 'set filetype=mail'"
fi

if [[ -z "${VISUAL:-}" ]]; then
	# No "visual" tool is set. Try to select a good one!
	if command -v bat >/dev/null 2>&1; then
		export VISUAL="bat --language=eml"
	elif command -v batcat >/dev/null 2>&1; then
		export VISUAL="batcat --language=eml"
	elif command -v less >/dev/null 2>&1; then
		export VISUAL="less"
	fi
fi
