#!/usr/bin/bash
#
#   elf_location.sh - Warn about ELF files outside standard locations
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

[[ -n "$LIBMAKEPKG_LINT_PACKAGE_ELF_LOCATION_SH" ]] && return
LIBMAKEPKG_LINT_PACKAGE_ELF_LOCATION_SH=1

LIBRARY=${LIBRARY:-'/usr/share/makepkg'}

source "$LIBRARY/util/message.sh"


lint_package_functions+=('warn_elf_location')

warn_elf_location() {
	local valid_elf_locations=('usr/bin' 'usr/lib' 'usr/lib32' 'opt')

	while read -r filename; do
		for l in ${valid_elf_locations[@]}; do
			if [[ $filename == $pkgdir/$l/* ]]; then
				continue 2
			fi
		done

		if [[ $(head -c4 "$filename" | tr -d \\0) == $'\x7fELF' ]]; then
			warning "$(gettext "%s files located in non-standard directories")" "ELF"
			break
		fi
	done < <(find "$pkgdir" -type f)
}
