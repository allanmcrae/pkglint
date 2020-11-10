#!/usr/bin/bash
#
#   makepkg_functions.sh - Warn about calls to internal makepkg functions
#
#   Copyright (c) 2020 Michael Straube <michael.straubej@gmail.com>
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

[[ -n "$LIBMAKEPKG_LINT_PKGBUILD_MAKEPKG_FUNCTIONS_SH" ]] && return
LIBMAKEPKG_LINT_PKGBUILD_MAKEPKG_FUNCTIONS_SH=1

LIBRARY=${LIBRARY:-'/usr/share/makepkg'}

source "$LIBRARY/util/message.sh"


lint_pkgbuild_functions+=('warn_makepkg_functions')

warn_makepkg_functions() {
	local bad_calls=(msg msg2 warning error plain)

	for i in "${bad_calls[@]}"; do
		if grep -q -E ^[^#]+[[:blank:]]"$i"[[:blank:]] "$BUILDFILE"; then
			warning "$(gettext "PKBGUILD uses internal makepkg '%s' subroutine")" "$i"
		fi
	done
}
