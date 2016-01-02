#!/usr/bin/bash
#
#   fhs_root.sh - Warn about non FHS items in the root directory
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

[[ -n "$LIBMAKEPKG_LINT_PACKAGE_FHS_ROOT_SH" ]] && return
LIBMAKEPKG_LINT_PACKAGE_FHS_ROOT_SH=1

LIBRARY=${LIBRARY:-'/usr/share/makepkg'}

source "$LIBRARY/util/message.sh"
source "$LIBRARY/util/util.sh"


lint_package_functions+=('warn_fhs_root')

warn_fhs_root() {
	local root_dirs=('boot' 'etc' 'opt' 'srv' 'usr' 'var')
	local root_dirs_empty=('dev' 'home' 'media' 'mnt' 'proc' 'root' 'run' 'sys' 'tmp')
	local root_symlinks=('bin' 'lib' 'lib64' 'sbin')

	# only given directories are allowed in the system root
	while read filename; do
		local f=${filename#$pkgdir/}
		if in_array $f ${root_dirs[@]} ${root_dirs_empty[@]} ${root_symlinks[@]}; then
			if [[ ! -d $filename ]]; then
				warning "$(gettext "Non-FHS item in package root directory")"
				break
			fi
		else
			# files in root starting with "." are reserved by pacman
			if [[ $f == .* ]]; then
				continue
			fi

			warning "$(gettext "Non-FHS item in package root directory")"
			break
		fi
	done < <(find $pkgdir -maxdepth 1 -mindepth 1)

	# these directories should not contain files
	for d in ${root_dirs_empty[@]}; do
		if [[ -d $pkgdir/$d ]]; then
			if (( $(find $pkgdir/$d -maxdepth 1 -mindepth 1 | wc -l) != 0 )); then
				warning "$(gettext "Package directory '%s/' should be empty")" "$d"
			fi
		fi
	done

	# on Arch systems, these directories are symlinks
	for d in ${root_symlinks[@]}; do
		if [[ -e $pkgdir/$d && ! -L $pkgdir/$d ]]; then
			warning "$(gettext "Package directory '%s/' conflicts with system symlink")" "$d"
		fi
	done
}
