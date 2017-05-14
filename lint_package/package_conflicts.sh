#!/usr/bin/bash
#
#   package_conflicts.sh - Warn about unmentioned conflicts with existing packages
#
#   Copyright (c) 2013-2017 Pacman Development Team <pacman-dev@archlinux.org>
#
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

[[ -n "$LIBMAKEPKG_LINT_PACKAGE_PACKAGE_CONFLICTS_SH" ]] && return
LIBMAKEPKG_LINT_PACKAGE_PACKAGE_CONFLICTS_SH=1

LIBRARY=${LIBRARY:-'/usr/share/makepkg'}

source "$LIBRARY/util/message.sh"

lint_package_functions+=('warn_package_conflicts')

warn_package_conflicts() {
	local repo name path

	while IFS=$'\t' read -r repo name _ path; do
		# Don't warn the user about defined conflicts
		if ! in_array "$name" "${conflicts[@]}" && ! in_array "$name" "${provides[@]}" && [[ $name != $pkgname ]]; then
			warning "$(gettext '%s contains %s which will conflict with the %s package')" "$pkgname" "$path" "$name"
		fi
	done < <(find "$pkgdir" \( -type f -o -empty \) -printf '%P\n' | pacman -Fo --machinereadable - | tr '\0' '\t')

	return 0
}
