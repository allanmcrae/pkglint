#!/usr/bin/bash
#
#   rpath.sh - Warn about insecure RPATHs
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

[[ -n "$LIBMAKEPKG_LINT_PACKAGE_RPATH_SH" ]] && return
LIBMAKEPKG_LINT_PACKAGE_RPATH_SH=1

LIBRARY=${LIBRARY:-'/usr/share/makepkg'}

source "$LIBRARY/util/message.sh"


lint_package_functions+=('warn_rpath')

warn_rpath() {
	local IFS=":"

	while read -r filename; do
		if [[ $(head -c4 "$filename" | tr -d \\0) == $'\x7fELF' ]]; then
			rpath=($(readelf -d "$filename" 2>/dev/null | sed -nr 's/.*Library rpath: \[(.*)\].*/\1/p'))
			warn=0

			for rp in ${rpath[@]}; do
				case $rp in
					/lib | /usr/lib | /usr/lib32 | \$ORIGIN | \${ORIGIN})
						;;
					/lib/* | /usr/lib/* | /usr/lib32/*)
						if [[ ! -d "$pkgdir/$rp" ]]; then
							warn=1
						fi
						;;
					\$ORIGIN/* | \${ORIGIN}/*)
						if [[ ! -d ${filename%/*}/${rp#*/} ]]; then
							warn=1
						fi
						;;
					*)
						warn=1
						;;
				esac

			done

			if (( warn )); then
				warning "$(gettext "Package file contains insecure RPATH: '%s'")" "${filename#$pkgdir/}"
			fi
		fi
	done < <(find "$pkgdir" -type f)
}
