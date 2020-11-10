#!/usr/bin/bash
#
#   empty_dir.sh - Warn about empty directories in a package
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

[[ -n "$LIBMAKEPKG_LINT_PACKAGE_EMPTY_DIR_SH" ]] && return
LIBMAKEPKG_LINT_PACKAGE_EMPTY_DIR_SH=1

LIBRARY=${LIBRARY:-'/usr/share/makepkg'}

source "$LIBRARY/util/message.sh"
source "$LIBRARY/util/util.sh"


lint_package_functions+=('warn_empty_dir')

warn_empty_dir() {
	local dirs

	# we are unable to use '-empty' as it is non-POSIX and not supported by all find variants
	mapfile -t dirs < <(find "$pkgdir" -type d)

	for d in "${dirs[@]}"; do
		if dir_is_empty "$d"; then
			warning "$(gettext "Directory '%s' is empty")" "${d#$pkgdir/}"
		fi
	done
}
