#!/usr/bin/bash
#
#   lots_of_docs.sh - Warn if a package is carrying more documentation than it should
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

[[ -n "$LIBMAKEPKG_LINT_PACKAGE_LOTS_OF_DOCS_SH" ]] && return
LIBMAKEPKG_LINT_PACKAGE_LOTS_OF_DOCS_SH=1

LIBRARY=${LIBRARY:-'/usr/share/makepkg'}

source "$LIBRARY/util/message.sh"
source "$LIBRARY/util/dirsize.sh"
source "$LIBRARY/util/util.sh"


lint_package_functions+=('warn_lots_of_docs')

warn_lots_of_docs() {
	[[ $pkgname = *"-doc" || $pkgname = *"-docs"  || ! -d "$pkgdir/usr/share/doc" ]] && return

	local size=$(cd_safe "$pkgdir"; dirsize)
	local docsize=$(cd_safe "$pkgdir/usr/share/doc"; dirsize)

	# floor'ed
	percent=$((100 * docsize / size))

	if (( percent > 50 )); then
		warning "$(gettext "Package was %s docs by size; maybe you should split out a docs package")" "$percent%"
	fi
}
