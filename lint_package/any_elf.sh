#!/usr/bin/bash
#
#   any_elf.sh - Warn about ELF files in 'any' architecture packages
#
#   Copyright (c) 2015 Allan McRae <allan@archlinux.org>
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

[[ -n "$LIBMAKEPKG_LINT_PACKAGE_ANY_ELF_SH" ]] && return
LIBMAKEPKG_LINT_PACKAGE_ANY_ELF_SH=1

LIBRARY=${LIBRARY:-'/usr/share/makepkg'}

source "$LIBRARY/util/message.sh"
source "$LIBRARY/util/pkgbuild.sh"


lint_package_functions+=('warn_any_elf')

warn_any_elf() {
	local arch=$(get_pkg_arch)

	if [[ $arch = "any" ]]; then
		while read -r filename; do
			if [[ $(head -c4 "$filename" | tr -d \\0) == $'\x7fELF' ]]; then
				warning "$(gettext "Package for '%s' architecture contains %s files")" "any" "ELF"
				break
			fi
		done < <(find "$pkgdir" -type f)
	fi
}
