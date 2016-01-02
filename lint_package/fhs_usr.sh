#!/usr/bin/bash
#
#   fhs_root.sh - Warn about non FHS items in the usr/ directory
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

[[ -n "$LIBMAKEPKG_LINT_PACKAGE_FHS_USR_SH" ]] && return
LIBMAKEPKG_LINT_PACKAGE_FHS_USR_SH=1

LIBRARY=${LIBRARY:-'/usr/share/makepkg'}

source "$LIBRARY/util/message.sh"
source "$LIBRARY/util/util.sh"


lint_package_functions+=('warn_fhs_usr')

warn_fhs_usr() {
	local usr_dirs=('bin' 'inlcude' 'lib' 'lib32' 'local' 'share' 'src')
	local usr_symlinks=('lib64' 'sbin')

	# only given directories are allowed in usr/
	if [[ -d $pkgdir/usr ]]; then
		while read filename; do
			local f=${filename#$pkgdir/usr/}
			if in_array $f ${usr_dirs[@]} ${usr_symlinks[@]}; then
				if [[ ! -d $filename ]]; then
					warning "$(gettext "Non-FHS item in package '%s' directory")" "usr/"
					break
				fi
			else
				warning "$(gettext "Non-FHS item in package '%s' directory")" "usr/"
				break
			fi
		done < <(find $pkgdir/usr -maxdepth 1 -mindepth 1)
	fi

	# on Arch systems, these directories are symlinks
	for d in ${usr_symlinks[@]}; do
		if [[ -e $pkgdir/usr/$d && ! -L $pkgdir/usr/$d ]]; then
			warning "$(gettext "Package directory '%s' conflicts with system symlink")" "usr/$d/"
		fi
	done

	# the usr/bin directory should not have subdirectories
	if [[ -d $pkgdir/usr/bin ]]; then
		if (( $(find $pkgdir/usr/bin -maxdepth 1 -mindepth 1 -type d | wc -l) != 0 )); then
			warning "$(gettext "Package directory '%s' should not contain subdirectories")" "usr/bin/"
		fi
	fi

	# the usr/share/ directory should only contain directories
	if [[ -d $pkgdir/usr/share ]]; then
		if (( $(find $pkgdir/usr/share -maxdepth 1 -mindepth 1 ! -type d | wc -l) != 0 )); then
			warning "$(gettext "Package directory '%s' should not contain files")" "usr/share/"
		fi
	fi

	# the usr/local/ directory should not contain files
	if [[ -d $pkgdir/usr/local ]]; then
		if (( $(find $pkgdir/usr/local -type f | wc -l) != 0 )); then
			warning "$(gettext "Package directory '%s' should not contain files")" "usr/local/"
		fi
	fi
}
