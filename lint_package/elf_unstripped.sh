#!/usr/bin/bash
#
#   elf_unstripped.sh - Warn about unstripped ELF files
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

[[ -n "$LIBMAKEPKG_LINT_PACKAGE_ELF_UNSTRIPPED_SH" ]] && return
LIBMAKEPKG_LINT_PACKAGE_ELF_UNSTRIPPED_SH=1

LIBRARY=${LIBRARY:-'/usr/share/makepkg'}

source "$LIBRARY/util/message.sh"


lint_package_functions+=('warn_elf_unstripped')

warn_elf_unstripped() {
	while read -r filename; do
		if LC_ALL=C readelf -s "$filename" 2>/dev/null | grep -q '\.symtab'; then
			warning "$(gettext "ELF file '%s' is unstripped")" "${filename#$pkgdir/}"
		fi
	done < <(find "$pkgdir" -type f)
}
